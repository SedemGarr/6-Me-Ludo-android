// ignore_for_file: use_build_context_synchronously

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:six_me_ludo_android/constants/app_constants.dart';
import 'package:six_me_ludo_android/constants/player_constants.dart';
import 'package:six_me_ludo_android/models/board.dart';
import 'package:six_me_ludo_android/providers/app_provider.dart';
import 'package:six_me_ludo_android/providers/sound_provider.dart';
import 'package:six_me_ludo_android/services/database_service.dart';
import 'package:six_me_ludo_android/services/navigation_service.dart';
import 'package:six_me_ludo_android/services/translations/dialogue_service.dart';
import 'package:six_me_ludo_android/utils/utils.dart';
import 'package:six_me_ludo_android/widgets/choice_dialog.dart';
import 'package:visibility_detector/visibility_detector.dart';

import '../constants/icon_constants.dart';
import '../models/game.dart';
import '../models/user.dart';
import '../models/user_settings.dart';
import '../services/game_status_service.dart';

class GameProvider with ChangeNotifier {
  late Board board;

  // text controllers
  TextEditingController joinGameController = TextEditingController();
  TextEditingController gameChatController = TextEditingController();

  // game
  late Game currentGame;
  late Stream<Game> currentGameStream;
  late int playerNumber;
  late Color playerColor;
  late Color playerSelectedColor;

  bool isJoinGameCodeValidLength() {
    return joinGameController.text.length == AppConstants.joinGameCodeLength;
  }

  int getGameChatCount() {
    return currentGame.thread.length;
  }

  String getGameChatUnreadCountAsString(String id) {
    int unreadCount = currentGame.thread.where((element) => !element.seenBy.contains(id)).length;

    if (currentGame.bannedPlayers.contains(id) || unreadCount == 0) {
      return '';
    }

    return ' - $unreadCount';
  }

  String getPlayerNameFromId(String id) {
    int playerNumber = currentGame.playerIds.indexWhere((element) => element == id);

    return currentGame.players[playerNumber].psuedonym;
  }

  IconData getAIPreferenceIcon(String value) {
    switch (value) {
      case PlayerConstants.pacifist:
        return PlayerConstants.pacifistIcon;
      case PlayerConstants.averageJoe:
        return PlayerConstants.averageJoeIcon;
      case PlayerConstants.vicious:
        return PlayerConstants.viciousIcon;
      case PlayerConstants.randomPersonality:
        return PlayerConstants.randomIcon;
      default:
        return AppIcons.aIPersonalityTypeIcon;
    }
  }

  IconData gameSpeedPreferenceIcon(int value) {
    switch (value) {
      case UserSettings.slowSpeed:
        return AppIcons.slowGameSpeedIcon;
      case UserSettings.normalSpeed:
        return AppIcons.normalGameSpeedIcon;
      case UserSettings.fastSpeed:
        return AppIcons.fastGameSpeedIcon;
      default:
        return AppIcons.gameSpeedIcon;
    }
  }

  void initialiseBoard(BuildContext context) {
    board = Board.generateBoard(context);
  }

  void initialiseGame(Game game, String id) {
    currentGame = game;
    currentGameStream = DatabaseService.getCurrentGameStream(currentGame.id);
    playerNumber = game.playerIds.indexWhere((element) => element == id);
    playerColor = PlayerConstants.swatchList[playerNumber].playerColor;
    playerSelectedColor = PlayerConstants.swatchList[playerNumber].playerSelectedColor;
  }

  void syncGameData(BuildContext context, Game game, String id) {
    checkIfNewMessageHasArrived(game, id, context);
    currentGame = game;
    playerNumber = game.playerIds.indexWhere((element) => element == id);
    playerColor = PlayerConstants.swatchList[playerNumber].playerColor;
    playerSelectedColor = PlayerConstants.swatchList[playerNumber].playerSelectedColor;
  }

  void checkIfNewMessageHasArrived(Game newGame, String id, BuildContext context) {
    if (newGame.thread.length != currentGame.thread.length) {
      if (newGame.thread[newGame.thread.length - 1].createdById != id) {
        SoundProvider soundProvider = context.read<SoundProvider>();
        soundProvider.playSound(GameStatusService.newMessageReceived);
      }
    }
  }

  Future<void> hostGame(Users user, AppProvider appProvider) async {
    appProvider.setLoading(true, true);

    try {
      Game newGame = await DatabaseService.createGame(user);
      initialiseGame(newGame, user.id);
      appProvider.setLoading(false, true);
      NavigationService.goToGameScreen();
    } catch (e) {
      appProvider.setLoading(false, true);
      Utils.showToast(DialogueService.genericErrorText.tr);
      debugPrint(e.toString());
    }
  }

  Future<void> reJoinGame(Game game, String id) async {
    try {
      int playerNumber = game.playerIds.indexWhere((element) => element == id);

      game.players[playerNumber].hasLeft = false;
      game.players[playerNumber].isPresent = true;

      DatabaseService.updateGame(game, false);

      initialiseGame(game, id);
      NavigationService.goToGameScreen();
    } catch (e) {
      Utils.showToast(DialogueService.genericErrorText.tr);
      debugPrint(e.toString());
    }
  }

  Future<void> joinGameWithCode(Users user, AppProvider appProvider) async {
    if (joinGameController.text.length == AppConstants.joinGameCodeLength) {
      appProvider.setLoading(true, true);

      try {
        Game? newGame = await DatabaseService.getGame(joinGameController.text);

        // does game exist?
        if (newGame == null) {
          Utils.showToast(DialogueService.gameDoesNotExistText.tr);
          appProvider.setLoading(false, true);
          return;
        } else {
          // kicked
          if (newGame.kickedPlayers.contains(user.id)) {
            Utils.showToast(DialogueService.gameKickedText.tr);
            appProvider.setLoading(false, true);
            return;
          }

          if (newGame.playerIds.contains(user.id)) {
            // rejoin
            appProvider.setLoading(false, true);
            reJoinGame(newGame, user.id);
            return;
          } else if (newGame.players.length == newGame.maxPlayers) {
            // full
            Utils.showToast(DialogueService.gameFullText.tr);
            appProvider.setLoading(false, true);
            return;
          }

          // add new player
          await DatabaseService.addNewHumanPlayerToGame(newGame, user);
          initialiseGame(newGame, user.id);
          appProvider.setLoading(false, true);
          NavigationService.goToGameScreen();
        }
      } catch (e) {
        Utils.showToast(DialogueService.genericErrorText.tr);
        appProvider.setLoading(false, true);
        return;
      }
    } else {
      return;
    }
  }

  Future<void> sendChatMessage(String id, SoundProvider soundProvider) async {
    if (gameChatController.text.isNotEmpty) {
      String value = gameChatController.text.trim();

      if (!currentGame.hostSettings.prefersProfanity && Utils.isStringProfane(value)) {
        Utils.showToast(DialogueService.profaneMessageText.tr);
        return;
      }
      soundProvider.playSound(GameStatusService.newMessageSent);
      DatabaseService.sendGameChat(id, currentGame.id, value);
    }

    gameChatController.clear();
    Utils.dismissKeyboard();
  }

  Future<void> handleGameChatReadStatus(VisibilityInfo visibilityInfo, String id, int index) async {
    if (visibilityInfo.visibleFraction == 1) {
      if (!currentGame.thread[index].seenBy.contains(id)) {
        currentGame.thread[index].seenBy.add(id);
        await DatabaseService.updateGame(currentGame, false);
      }
    }
  }

  Future<void> showRejoinGameDialog(Game game, String id, BuildContext context) async {
    showChoiceDialog(
      titleMessage: DialogueService.rejoinGameDialogTitleText.tr,
      contentMessage: DialogueService.rejoinGameDialogContentText.tr,
      yesMessage: DialogueService.rejoinGameDialogYesText.tr,
      noMessage: DialogueService.rejoinGameDialogNoText.tr,
      onYes: () {
        reJoinGame(game, id);
      },
      onNo: () {},
      context: context,
    );
  }

  Future<void> showLeaveOrDeleteGameDialog(Game game, String id, BuildContext context) async {
    if (id == game.hostId) {
      // delete game
      showChoiceDialog(
        titleMessage: DialogueService.deleteGameDialogTitleText.tr,
        contentMessage: DialogueService.deleteGameDialogContentText.tr,
        yesMessage: DialogueService.deleteGameDialogYesText.tr,
        noMessage: DialogueService.deleteGameDialogNoText.tr,
        onYes: () {},
        onNo: () {},
        context: context,
      );
    } else {
      // leave game
      showChoiceDialog(
        titleMessage: DialogueService.leaveGameDialogTitleText.tr,
        contentMessage: DialogueService.leaveGameDialogContentText.tr,
        yesMessage: DialogueService.leaveGameDialogYesText.tr,
        noMessage: DialogueService.leaveGameDialogNoText.tr,
        onYes: () {},
        onNo: () {},
        context: context,
      );
    }
  }
}
