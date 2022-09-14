// ignore_for_file: use_build_context_synchronously

import 'dart:math';

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
import '../models/die.dart';
import '../models/direction.dart';
import '../models/game.dart';
import '../models/move.dart';
import '../models/piece.dart';
import '../models/player.dart';
import '../models/reaction.dart';
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

  bool isPlayerHost(String id) {
    return currentGame.hostId == id;
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

  void copyGameID() {
    Utils.showToast(DialogueService.gameIDCopiedToClipboardText.tr);
    Utils.copyToClipboard(currentGame.id);
  }

  void handleSuddenGameDeletion() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Utils.showToast(DialogueService.gameDeletedText.tr);
      NavigationService.genericGoBack();
    });
  }

  Move getValidMove(Game game) {
    List<Move> availableMoves = [];

    for (int j = 0; j < game.players[game.playerTurn].pieces.length; j++) {
      // handle six roll
      if (game.players[game.playerTurn].pieces[j].isBased && !game.players[game.playerTurn].pieces[j].isHome && game.die.rolledValue == 6) {
        if (!doesIndexContainFriendlyPiece(game, Player.getPlayerStartIndex(game.playerTurn))) {
          availableMoves.add(Move(
              piece: game.players[game.playerTurn].pieces[j],
              direction: Direction.forward,
              destinationIndex: Player.getPlayerStartIndex(game.playerTurn),
              isGoingHome: Player.getPlayerHomeIndex(game.playerTurn) == Player.getPlayerStartIndex(game.playerTurn),
              isStartingKick: doesIndexContainEnemyPiece(Game.fromJson(game.toJson()), Player.getPlayerStartIndex(game.playerTurn)),
              isKick: doesIndexContainEnemyPiece(Game.fromJson(game.toJson()), Player.getPlayerStartIndex(game.playerTurn))));
        }
      }

      // forward movement
      if (!game.players[game.playerTurn].pieces[j].isBased && !game.players[game.playerTurn].pieces[j].isHome) {
        List<int> validIndices = Player.getPlayerValidIndices(game.playerTurn);
        int piecePosition = validIndices.indexWhere((element) => element == game.players[game.playerTurn].pieces[j].position);
        //
        if (validIndices.asMap().containsKey(piecePosition + game.die.rolledValue)) {
          if (!doesIndexContainFriendlyPiece(game, validIndices[piecePosition + game.die.rolledValue])) {
            availableMoves.add(Move(
                piece: game.players[game.playerTurn].pieces[j],
                direction: Direction.forward,
                destinationIndex: validIndices[piecePosition + game.die.rolledValue],
                isGoingHome: Player.getPlayerHomeIndex(game.playerTurn) == validIndices[piecePosition + game.die.rolledValue],
                isStartingKick: false,
                isKick: doesIndexContainEnemyPiece(Game.fromJson(game.toJson()), validIndices[piecePosition + game.die.rolledValue])));
          }
        }

        // backward movement
        if (validIndices.asMap().containsKey(piecePosition - game.die.rolledValue)) {
          if (!doesIndexContainFriendlyPiece(game, validIndices[piecePosition - game.die.rolledValue])) {
            Game tempGame = Game.fromJson(game.toJson());
            tempGame.selectedPiece = game.players[game.playerTurn].pieces[j];
            //
            if (doesIndexContainEnemyPiece(game, getAIPlayerDestination(tempGame, false))) {
              availableMoves.add(Move(
                  piece: game.players[game.playerTurn].pieces[j],
                  direction: Direction.backward,
                  destinationIndex: validIndices[piecePosition - game.die.rolledValue],
                  isGoingHome: Player.getPlayerHomeIndex(game.playerTurn) == validIndices[piecePosition - game.die.rolledValue],
                  isStartingKick: false,
                  isKick: true));
            }
          }
        } else {
          if (game.players[game.playerTurn].startBackKickIndices.asMap().containsKey((piecePosition - game.die.rolledValue).abs() - 1)) {
            Game tempGame = Game.fromJson(game.toJson());
            tempGame.selectedPiece = game.players[game.playerTurn].pieces[j];

            if (doesIndexContainEnemyPiece(game, game.players[game.playerTurn].startBackKickIndices[(piecePosition - game.die.rolledValue).abs() - 1])) {
              availableMoves.add(Move(
                  piece: game.players[game.playerTurn].pieces[j],
                  direction: Direction.backward,
                  destinationIndex: game.players[game.playerTurn].startBackKickIndices[(piecePosition - game.die.rolledValue).abs() - 1],
                  isGoingHome: Player.getPlayerHomeIndex(game.playerTurn) == game.players[game.playerTurn].startBackKickIndices[(piecePosition - game.die.rolledValue).abs() - 1],
                  isStartingKick: false,
                  isKick: true));
            }
          }
        }
      }
    }

    // factor in ai personality so moves they are not entirely random
    if (game.players[game.playerTurn].isAIPlayer) {
      switch (Player.getPlayerReputation(game.players[game.playerTurn].reputationValue)) {
        case PlayerConstants.pacifist:
          // remove all kicks if possible but allow starting kicks otherwise ai may enter infinite loop
          availableMoves = availableMoves.where((element) => !element.isKick).toList().isEmpty && availableMoves.where((element) => element.isStartingKick).toList().isNotEmpty
              ? availableMoves.where((element) => element.isStartingKick).toList()
              : availableMoves.where((element) => !element.isKick).toList();
          // check if there are any home moves
          if (canPlayerGoHome(availableMoves)) {
            availableMoves = availableMoves.where((element) => element.isGoingHome).toList();
          }
          break;
        case PlayerConstants.averageJoe:
          // try as much as possible to avoid back-kicks unless absolutely necessary
          if (availableMoves.where((element) => element.direction == Direction.forward).toList().isNotEmpty) {
            availableMoves = availableMoves.where((element) => element.direction == Direction.forward).toList();
          }
          // try and prioritize home moves
          if (canPlayerGoHome(availableMoves)) {
            availableMoves = availableMoves.where((element) => element.isGoingHome).toList();
          }
          break;
        case PlayerConstants.vicious:
          // try and prioritize kicks if not then prioritize home moves
          availableMoves = availableMoves.where((element) => element.isKick).toList().isNotEmpty
              ? availableMoves.where((element) => element.isKick).toList()
              : canPlayerGoHome(availableMoves)
                  ? availableMoves.where((element) => element.isGoingHome).toList()
                  : availableMoves;
          break;
      }
    }

    // if there are no moves available, return a null piece. the move will be skipped
    return availableMoves.isEmpty ? Move.getNullMove() : availableMoves[Random().nextInt(availableMoves.length)];
  }

  int getAIPlayerDestination(Game game, bool isForwards) {
    List<int> validIndices = Player.getPlayerValidIndices(game.playerTurn);
    int piecePosition = validIndices.indexWhere((element) => element == game.selectedPiece!.position);
    int dieValue = game.die.rolledValue;

    if (isForwards) {
      return validIndices[piecePosition + dieValue];
    } else {
      return validIndices[piecePosition - dieValue];
    }
  }

  int determineDieValue(Game game) {
    int randomValue = (Random().nextInt(6) + 1);

    if (game.shouldAssistStart) {
      if (game.players[game.playerTurn].numberOfDieRolls == 0) {
        return 6;
      }

      if (game.hostSettings.prefersCatchupAssist && game.players[game.playerTurn].pieces.where((element) => element.isBased).length == 4) {
        return 6;
      }

      return randomValue;
    } else {
      return randomValue;
    }
  }

  bool isOnlyOnePlayerLeft(Game game) {
    return game.players.where((element) => !element.hasLeft || !game.kickedPlayers.contains(element.id)).length == 1;
  }

  bool checkIfGameHasEnded(Game game) {
    if (!game.hasSessionEnded) {
      bool areAllPiecesHome = true;

      for (int i = 0; i < game.players.length; i++) {
        if (!game.players[i].hasLeft || game.kickedPlayers.contains(game.players[i].id)) {
          for (int j = 0; j < game.players[i].pieces.length; j++) {
            if (!game.players[i].pieces[j].isHome) {
              areAllPiecesHome = false;
            }
          }
        }
      }

      if (areAllPiecesHome || game.players.where((element) => !element.hasLeft).length - game.finishedPlayers.length == 1) {
        return true;
      } else {
        return false;
      }
    }
    return false;
  }

  bool wasPreviousRollNotASix(Game game) {
    return game.die.rolledValue != 6;
  }

  bool doesIndexContainFriendlyPiece(Game game, int index) {
    for (int i = 0; i < game.players.length; i++) {
      for (int j = 0; j < game.players[i].pieces.length; j++) {
        if (game.players[i].pieces[j].position == index) {
          if (game.players[i].pieces[j].owner == game.playerTurn) {
            return true;
          }
        }
      }
    }

    return false;
  }

  bool doesIndexContainEnemyPiece(Game game, int index) {
    for (int i = 0; i < game.players.length; i++) {
      for (int j = 0; j < game.players[i].pieces.length; j++) {
        if (game.players[i].pieces[j].position == index) {
          if (game.players[i].pieces[j].owner != game.playerTurn) {
            return true;
          }
        }
      }
    }

    return false;
  }

  bool canPlayerGoHome(List<Move> availableMoves) {
    return availableMoves.where((element) => element.isGoingHome).toList().isNotEmpty;
  }

  bool isMovePlayerPossible(Game game) {
    for (int j = 0; j < game.players[game.playerTurn].pieces.length; j++) {
      if (!game.players[game.playerTurn].pieces[j].isBased && !game.players[game.playerTurn].pieces[j].isHome) {
        List<int> validIndices = Player.getPlayerValidIndices(game.playerTurn);
        int piecePosition = validIndices.indexWhere((element) => element == game.players[game.playerTurn].pieces[j].position);

        // if forward move is possible
        if (validIndices.asMap().containsKey(piecePosition + game.die.rolledValue)) {
          if (!doesIndexContainFriendlyPiece(game, validIndices[piecePosition + game.die.rolledValue])) {
            return true;
          }
        }

        // if backward move is possible
        if (validIndices.asMap().containsKey(piecePosition - game.die.rolledValue)) {
          if (!doesIndexContainFriendlyPiece(game, validIndices[piecePosition - game.die.rolledValue])) {
            return true;
          }
        } else {
          if (!doesIndexContainFriendlyPiece(game, game.players[game.playerTurn].startBackKickIndices[(piecePosition - game.die.rolledValue).abs() - 1])) {
            if (doesIndexContainEnemyPiece(game, game.players[game.playerTurn].startBackKickIndices[(piecePosition - game.die.rolledValue).abs() - 1])) {
              return true;
            }
          }
        }
      }
    }

    return false;
  }

  bool canPlayerKick(Game game) {
    if (isMovePlayerPossible(game)) {
      for (int i = 0; i < game.players[game.playerTurn].pieces.length; i++) {
        // if the piece is not home
        if (!game.players[game.playerTurn].pieces[i].isHome) {
          // first check if based pieces can kick by checking if the user has a 6
          if (game.players[game.playerTurn].pieces[i].isBased) {
            if (game.die.rolledValue == 6) {
              if (doesIndexContainEnemyPiece(game, Player.getPlayerStartIndex(game.playerTurn))) {
                return true;
              }
            }
          } else {
            // check pieces in play
            List<int> validIndices = Player.getPlayerValidIndices(game.playerTurn);
            int piecePosition = validIndices.indexWhere((element) => element == game.players[game.playerTurn].pieces[i].position);

            // does forwards index exist?
            if (validIndices.asMap().containsKey(piecePosition + game.die.rolledValue)) {
              if (doesIndexContainEnemyPiece(game, validIndices[piecePosition + game.die.rolledValue])) {
                return true;
              }
            }

            // does backwards index exist?
            if (validIndices.asMap().containsKey(piecePosition - game.die.rolledValue)) {
              if (doesIndexContainEnemyPiece(game, validIndices[piecePosition - game.die.rolledValue])) {
                return true;
              }
            } else {
              if (!doesIndexContainFriendlyPiece(game, game.players[game.playerTurn].startBackKickIndices[(piecePosition - game.die.rolledValue).abs() - 1])) {
                if (doesIndexContainEnemyPiece(game, game.players[game.playerTurn].startBackKickIndices[(piecePosition - game.die.rolledValue).abs() - 1])) {
                  return true;
                }
              }
            }
          }
        }
      }
    }

    return false;
  }

  Game incrementCouldHaveBeenKicked(Game game, index) {
    int playerNumber = 1000;

    for (var i = 0; i < game.players.length; i++) {
      for (var j = 0; j < game.players[i].pieces.length; j++) {
        if (game.players[i].pieces[j].position == index) {
          playerNumber = i;
        }
      }
    }

    if (game.players[playerNumber].isAIPlayer) {
      game.players[playerNumber].setReputationValue(game.players[playerNumber].reputationValue - 1);
    }
    return game;
  }

  Game incrementKickStats(Game game, int kickerIndex, int kickedIndex) {
    game.players[kickedIndex].numberOfTimesKickedInSession++;
    game.players[kickerIndex].numberOfTimesKickerInSession++;

    return game;
  }

  Game resetGamePiecesToDefaultAfterPlayerLeaves(Game game, String id) {
    game.players[game.players.indexWhere((element) => element.id == id)].pieces = [...Piece.getDefaultPieces(game.players.indexWhere((element) => element.id == id))];
    return game;
  }

  Game resetKickStats(Game game) {
    for (Player player in game.players) {
      player.numberOfTimesKickedInSession = 0;
      player.numberOfTimesKickerInSession = 0;
    }
    return game;
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

  Future<void> leaveGame(Game game, String id, BuildContext context) async {
    if (game.hostId == id) {
      await DatabaseService.deleteGame(game);
    } else {
      game.players[game.players.indexWhere((element) => element.id == id)].hasLeft = true;
      game = resetGamePiecesToDefaultAfterPlayerLeaves(game, id);
      if (isOnlyOnePlayerLeft(game)) {
        await DatabaseService.deleteGame(game);
      } else {
        if (!game.hasStarted) {
          await removePlayerFromGame(game, id);
          return;
        }
        if (game.playerTurn == game.players[game.players.indexWhere((element) => element.id == id)].playerColor) {
          await incrementTurn(game, context);
        }
        game.reaction = Reaction.parseGameStatus(GameStatusService.playerLeft);
        await DatabaseService.updateGame(game, true);
      }
    }
  }

  Future<void> removePlayerFromGame(Game game, String id) async {
    game.players.removeWhere((element) => element.id == id);
    game.playerIds.remove(id);

    for (int i = 0; i < game.players.length; i++) {
      game.players[i].pieces = Piece.getDefaultPieces(i);
      game.players[i].playerColor = i;
      game.players[i].validIndices = Player.getPlayerValidIndices(i);
    }

    await DatabaseService.updateGame(game, true);
  }

  Future<void> incrementTurn(Game game, context) async {
    if (!game.hasSessionEnded) {
      // check if previous move has ended the game
      if (game.players[game.playerTurn].pieces.where((element) => !element.isHome).isEmpty) {
        if (!game.finishedPlayers.contains(game.playerIds[game.playerTurn])) {
          game.finishedPlayers.add(game.playerIds[game.playerTurn]);
          game.players[game.playerTurn].hasFinished = true;
          game.reaction = Reaction.parseGameStatus(GameStatusService.playerFinish);
        }
      }

      // check if game has ended
      if (!checkIfGameHasEnded(game)) {
        game.canPass = false;

        if (game.playerTurn + 1 >= game.players.length) {
          // if previous value was 6
          if (wasPreviousRollNotASix(game)) {
            game.playerTurn = 0;
          }
        } else {
          // if previous value was 6
          if (wasPreviousRollNotASix(game)) {
            game.playerTurn++;
          }
        }

        if (game.players[game.playerTurn].hasLeft ||
            game.kickedPlayers.contains(game.players[game.playerTurn].id) ||
            game.players[game.playerTurn].hasFinished ||
            game.players[game.playerTurn].pieces.where((element) => element.isHome).length == 4) {
          await incrementTurn(game, context);
        } else if (game.players[game.playerTurn].isAIPlayer) {
          await rollDieForAIPlayer(game, context);
        } else {
          game.lastUpdatedBy = game.players[game.playerTurn].id;
          game.die.rolledValue = 0;
          game.canPlay = true;
          await DatabaseService.updateGame(game, true);
        }
      } else {
        await endSession(game);
      }
    }
  }

  Future<void> rollDieForAIPlayer(Game game, BuildContext context) async {
    if (!game.hasSessionEnded) {
      Future.delayed(Duration(milliseconds: game.hostSettings.preferredSpeed), () async {
        await rollDie(game, game.players[game.playerTurn].id, context);
      });
    }
  }

  Future<void> rollDie(Game game, String userId, BuildContext context) async {
    if (!game.hasSessionEnded) {
      bool areAllPiecesBased = true;

      game.die.isRolling = true;
      game.die.lastRolledBy = userId;
      game.die.rolledValue = 0;
      game.players[game.playerTurn].numberOfDieRolls++;
      game.selectedPiece = null;
      game.hasRestarted = false;
      game.canPass = false;
      await DatabaseService.updateGame(game, true);

      Future.delayed(const Duration(milliseconds: 1000), () async {
        game.die.isRolling = false;
        game.die.lastRolledBy = userId;
        game.reaction = Reaction.parseGameStatus(GameStatusService.playerRoll);
        game.die.rolledValue = determineDieValue(game);

        await DatabaseService.updateGame(game, true);

        // check if user has no valid moves
        Future.delayed(Duration(milliseconds: game.hostSettings.preferredSpeed), () async {
          for (int i = 0; i < game.players[game.playerTurn].pieces.length; i++) {
            if (!game.players[game.playerTurn].pieces[i].isBased) {
              areAllPiecesBased = false;
            }
          }

          if (game.die.rolledValue != 6 && areAllPiecesBased) {
            game.reaction = Reaction.parseGameStatus(GameStatusService.blank);
            await incrementTurn(game, context);
          } else {
            if (game.players[game.playerTurn].isAIPlayer) {
              handleAIPlayerGameLogic(game, context);
            } else {
              Game tempGame = Game.fromJson(game.toJson());
              tempGame.canPass = true;
              tempGame.canPlay = true;
              await DatabaseService.updateGame(tempGame, true);
            }
          }
        });
      });
    }
  }

  Future<void> handleAIPlayerGameLogic(Game game, BuildContext context) async {
    if (!game.hasSessionEnded) {
      Future.delayed(Duration(milliseconds: game.hostSettings.preferredSpeed), () async {
        try {
          // determine valid moves
          Move move = getValidMove(game);
          game.selectedPiece = move.piece;

          if (game.selectedPiece == null) {
            await passTurn(game, context);
          } else {
            await movePiece(game, move.destinationIndex, move.piece, context);
          }
        } catch (e) {
          await passTurn(game, context);
          Utils.showToast(DialogueService.genericErrorText.tr);
        }
      });
    }
  }

  Future<void> passTurn(Game game, BuildContext context) async {
    if (!game.hasSessionEnded) {
      game.selectedPiece = null;
      await incrementTurn(game, context);
    }
  }

  Future<void> movePiece(Game game, int destinationIndex, Piece? selectedPiece, BuildContext context) async {
    if (!game.hasSessionEnded) {
      game.canPass = false;

      // AI REPUTATION
      if (game.hasAdaptiveAI) {
        for (int i = 0; i < game.players[game.playerTurn].pieces.length; i++) {
          // if the piece is not home
          if (!game.players[game.playerTurn].pieces[i].isHome) {
            // first check if based pieces can kick by checking if the user has a 6
            if (game.players[game.playerTurn].pieces[i].isBased) {
              if (game.die.rolledValue == 6) {
                if (doesIndexContainEnemyPiece(game, Player.getPlayerStartIndex(game.playerTurn))) {
                  game = incrementCouldHaveBeenKicked(game, Player.getPlayerStartIndex(game.playerTurn));
                }
              }
            } else {
              // check pieces in play
              List<int> validIndices = Player.getPlayerValidIndices(game.playerTurn);
              int piecePosition = validIndices.indexWhere((element) => element == game.players[game.playerTurn].pieces[i].position);

              // does forwards index exist?
              if (validIndices.asMap().containsKey(piecePosition + game.die.rolledValue)) {
                if (doesIndexContainEnemyPiece(game, validIndices[piecePosition + game.die.rolledValue])) {
                  game = incrementCouldHaveBeenKicked(game, validIndices[piecePosition + game.die.rolledValue]);
                }
              }

              // does backwards index exist?
              if (validIndices.asMap().containsKey(piecePosition - game.die.rolledValue)) {
                if (doesIndexContainEnemyPiece(game, validIndices[piecePosition - game.die.rolledValue])) {
                  game = incrementCouldHaveBeenKicked(game, validIndices[piecePosition - game.die.rolledValue]);
                }
              } else {
                if (game.players[game.playerTurn].startBackKickIndices.asMap().containsKey((piecePosition - game.die.rolledValue).abs() - 1)) {
                  if (doesIndexContainEnemyPiece(game, game.players[game.playerTurn].startBackKickIndices[(piecePosition - game.die.rolledValue).abs() - 1])) {
                    game = incrementCouldHaveBeenKicked(game, game.players[game.playerTurn].startBackKickIndices[(piecePosition - game.die.rolledValue).abs() - 1]);
                  }
                }
              }
            }
          }
        }
      }

      // HUMAN REPUTATION
      if (canPlayerKick(game)) {
        // if player is human, check if a kick is possible and update reputation
        if (!game.players[game.playerTurn].isAIPlayer) {
          game.players[game.playerTurn].setReputationValue(game.players[game.playerTurn].reputationValue - 1);
          await updateUserCouldKick(game);
        }
      }

      for (int i = 0; i < game.players.length; i++) {
        for (int j = 0; j < game.players[i].pieces.length; j++) {
          if (game.players[i].pieces[j].position == destinationIndex) {
            if (game.players[i].pieces[j].owner != game.playerTurn) {
              // kick player
              game.players[i].pieces[j].isBased = true;
              game.players[i].pieces[j].isHome = false;
              game.players[i].pieces[j].position = Piece.determineInitialPiecePosition(game.players[i].pieces[j].owner, game.players[i].pieces[j].pieceNumber);

              game = incrementKickStats(game, game.playerTurn, game.players[i].pieces[j].owner);

              // handle adaptive ai - increment kick
              if (game.hasAdaptiveAI && game.players[i].isAIPlayer) {
                game.players[i].setReputationValue(game.players[i].reputationValue + 2);
              }

              // update user kick stats
              if (!game.players[game.playerTurn].isAIPlayer) {
                game.players[game.playerTurn].setReputationValue(game.players[game.playerTurn].reputationValue + 2);
                // await updateUserKicked(game);
                updateUserKicked(game);
              }

              // set game status
              game.reaction = Reaction.parseGameStatus(GameStatusService.playerKick);
              // make the move
              await incrementPlayerPosition(game, destinationIndex, false, selectedPiece!.isBased, context);
              return;
            } else {
              if (game.players[i].pieces[j].isHome) {
                await incrementPlayerPosition(game, destinationIndex, false, false, context);
              } else {
                // stack pieces
                Utils.showToast('Can\'t make that move');
                // figure out how to stack pieces. Not urgent
                return;
              }
            }
          }
        }
      }

      if (Player.getPlayerHomeIndex(game.playerTurn) == destinationIndex) {
        game.reaction = Reaction.parseGameStatus(GameStatusService.playerHome);
        // go home
        await incrementPlayerPosition(game, destinationIndex, true, false, context);
      } else if (selectedPiece!.isBased) {
        // coming out of base
        await incrementPlayerPosition(game, destinationIndex, false, true, context);
      } else {
        // make normal move
        await incrementPlayerPosition(game, destinationIndex, false, false, context);
      }
    }
  }

  Future<void> updateUserCouldKick(Game game) async {
    await DatabaseService.updateUserCouldKick(game.players[game.playerTurn].id, game.players[game.playerTurn].reputationValue);
  }

  Future<void> updateUserKicked(Game game) async {
    await DatabaseService.updateUserKicked(game.players[game.playerTurn].id, game.players[game.playerTurn].reputationValue);
  }

  Future<void> incrementPlayerPosition(Game game, int destinationIndex, bool isGoingHome, bool isLeavingBase, BuildContext context) async {
    if (!game.hasSessionEnded) {
      int selectedPieceNumber = game.players[game.playerTurn].pieces.indexWhere((element) => element.pieceNumber == game.selectedPiece!.pieceNumber);

      // SET PIECE DESTINATION
      game.players[game.playerTurn].pieces[selectedPieceNumber].position = destinationIndex;

      if (isGoingHome) {
        game.players[game.playerTurn].pieces[selectedPieceNumber].isHome = true;
        game.players[game.playerTurn].pieces[selectedPieceNumber].isBased = true;
        game.players[game.playerTurn].pieces[selectedPieceNumber].position = Piece.determineInitialPiecePosition(
            game.players[game.playerTurn].pieces[selectedPieceNumber].owner, game.players[game.playerTurn].pieces[selectedPieceNumber].pieceNumber);
      }

      if (isLeavingBase) {
        game.players[game.playerTurn].pieces[selectedPieceNumber].isHome = false;
        game.players[game.playerTurn].pieces[selectedPieceNumber].isBased = false;
      }

      game.selectedPiece = null;

      await incrementTurn(game, context);
    }
  }

  Future<void> forceStartGame(Game game, BuildContext context) async {
    game.hasStarted = true;
    game.canPlay = true;
    game.maxPlayers = game.players.length;
    game.reaction = Reaction.parseGameStatus(GameStatusService.gameStart);

    await DatabaseService.updateGame(game, true);

    // get ai player to start game
    if (game.players[0].isAIPlayer) {
      await rollDie(game, game.players[0].id, context);
    }
  }

  Future<void> restartGame(Game game, BuildContext context) async {
    game.hasFinished = false;
    game.hasSessionEnded = false;
    game.hasStarted = true;
    game.hasRestarted = true;
    game.canPlay = true;
    game.playerTurn = 0;
    game.finishedPlayers = [];
    game.reaction = Reaction.parseGameStatus(GameStatusService.blank);
    game.die = Die.getDefaultDie();
    game.selectedPiece = null;

    for (int i = 0; i < game.players.length; i++) {
      game.players[i].pieces = Piece.getDefaultPieces(i);
      game.players[i].hasFinished = false;
      game.players[i].numberOfDieRolls = 0;
    }

    game = resetKickStats(game);

    Utils.showToast(DialogueService.yourGameHasBeenRestartedText.tr);

    await DatabaseService.updateGame(game, true);

    // get ai player to start game
    if (game.players[0].isAIPlayer) {
      await rollDie(game, game.players[0].id, context);
    }
  }

  Future<void> reorderPlayerList(int oldIndex, int newIndex) async {
    if (newIndex > oldIndex) {
      newIndex = newIndex - 1;
    }

    String id = currentGame.playerIds.removeAt(oldIndex);
    Player player = currentGame.players.removeAt(oldIndex);

    currentGame.playerIds.insert(newIndex, id);
    currentGame.players.insert(newIndex, player);

    for (int i = 0; i < currentGame.players.length; i++) {
      currentGame.players[i].pieces = Piece.getDefaultPieces(i);
      currentGame.players[i].validIndices = Player.getPlayerValidIndices(i);
      currentGame.players[i].playerColor = i;
    }

    await DatabaseService.updateGame(currentGame, true);
  }

  Future<void> endSession(Game game) async {
    game.hasFinished = false;
    game.hasStarted = true;
    game.hasSessionEnded = true;
    game.reaction = Reaction.parseGameStatus(GameStatusService.gameFinish);
    await DatabaseService.updateGame(game, true);
  }

  Future<void> deleteGame(Game game) async {
    Utils.showToast(DialogueService.gameDeletedToastText.tr);
    DatabaseService.deleteGame(game);
  }

  showRestartGameDialog(Game game, BuildContext context) {
    return showChoiceDialog(
        context: context,
        titleMessage: DialogueService.restartGameDialogTitleText.tr,
        contentMessage: DialogueService.restartGameDialogContentText.tr,
        yesMessage: DialogueService.restartGameDialogYesText.tr,
        noMessage: DialogueService.restartGameDialogNoText.tr,
        onYes: () async {
          await restartGame(game, context);
        },
        onNo: () {});
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
        onYes: () {
          deleteGame(game);
        },
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
        onYes: () async {
          await leaveGame(game, id, context);
        },
        onNo: () {},
        context: context,
      );
    }
  }
}
