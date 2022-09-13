// ignore_for_file: use_build_context_synchronously

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:six_me_ludo_android/constants/app_constants.dart';
import 'package:six_me_ludo_android/models/board.dart';
import 'package:six_me_ludo_android/providers/app_provider.dart';
import 'package:six_me_ludo_android/services/database_service.dart';
import 'package:six_me_ludo_android/services/navigation_service.dart';
import 'package:six_me_ludo_android/services/translations/dialogue_service.dart';
import 'package:six_me_ludo_android/utils/utils.dart';
import 'package:six_me_ludo_android/widgets/choice_dialog.dart';

import '../models/game.dart';
import '../models/user.dart';

class GameProvider with ChangeNotifier {
  late Board board;

  // text controllers
  TextEditingController joinGameController = TextEditingController();

  // game
  late Game currentGame;
  late Stream<Game> currentGameStream;

  bool isJoinGameCodeValidLength() {
    return joinGameController.text.length == AppConstants.joinGameCodeLength;
  }

  void initialiseBoard(BuildContext context) {
    board = Board.generateBoard(context);
  }

  void initialiseGame(Game game) {
    currentGame = game;
    currentGameStream = DatabaseService.getCurrentGameStream(currentGame.id);
  }

  void syncGameData(Game game) {
    currentGame = game;
  }

  Future<void> hostGame(Users user, AppProvider appProvider) async {
    appProvider.setLoading(true, true);

    try {
      Game newGame = await DatabaseService.createGame(user);
      initialiseGame(newGame);
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

      initialiseGame(game);
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
          initialiseGame(newGame);
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
