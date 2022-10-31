import 'dart:math';

import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:six_me_ludo_android/constants/app_constants.dart';
import 'package:six_me_ludo_android/constants/player_constants.dart';
import 'package:six_me_ludo_android/models/board.dart';
import 'package:six_me_ludo_android/providers/app_provider.dart';
import 'package:six_me_ludo_android/providers/nav_provider.dart';
import 'package:six_me_ludo_android/providers/sound_provider.dart';
import 'package:six_me_ludo_android/providers/user_provider.dart';
import 'package:six_me_ludo_android/screens/game/game_wrapper.dart';
import 'package:six_me_ludo_android/services/database_service.dart';
import 'package:six_me_ludo_android/services/local_storage_service.dart';
import 'package:six_me_ludo_android/services/navigation_service.dart';
import 'package:six_me_ludo_android/services/translations/dialogue_service.dart';
import 'package:six_me_ludo_android/utils/utils.dart';
import 'package:six_me_ludo_android/widgets/choice_dialog.dart';
import 'package:uuid/uuid.dart';
import 'package:visibility_detector/visibility_detector.dart';

import '../constants/icon_constants.dart';
import '../models/die.dart';
import '../models/direction.dart';
import '../models/game.dart';
import '../models/move.dart';
import '../models/piece.dart';
import '../models/player.dart';
import '../models/reaction.dart';
import '../models/thread.dart';
import '../models/user.dart';
import '../models/user_settings.dart';
import '../services/game_status_service.dart';

class GameProvider with ChangeNotifier {
  late Board board;
  late ConfettiController confettiController;
  Random random = Random();

  // text controllers
  TextEditingController joinGameController = TextEditingController();
  TextEditingController gameChatController = TextEditingController();

  // game
  Game? currentGame;
  Stream<Game>? currentGameStream;
  late int playerNumber;
  late Color playerColor;
  late Color playerSelectedColor;
  late List<int> validMoveIndices;

  // thread
  Thread? currentThread;
  Stream<Thread>? currentThreadStream;

  bool isJoinGameCodeValidLength() {
    return joinGameController.text.length == AppConstants.joinGameCodeLength;
  }

  bool isPlayerHost(String id) {
    return currentGame!.hostId == id;
  }

  bool doesPlayerOwnPiece(Piece piece) {
    return piece.owner == playerNumber;
  }

  bool canPlayerRollDie() {
    return !currentGame!.hasSessionEnded && isPlayerTurn() && !currentGame!.die.isRolling && currentGame!.die.rolledValue == 0;
  }

  bool hasWinner() {
    return currentGame!.finishedPlayers.isNotEmpty;
  }

  bool hasViciousOrPunchingBag() {
    return currentGame!.players.where((element) => element.numberOfTimesKickerInSession != 0 || element.numberOfTimesKickedInSession != 0).isNotEmpty;
  }

  bool isPlayerNotPlaying(Game game, Player player) {
    return player.hasLeft || game.kickedPlayers.contains(player.id) || player.hasFinished || player.pieces.where((element) => element.isHome).length == 4;
  }

  bool doesGameVersionMatch(String userVersion, String gameVersion) {
    return userVersion == gameVersion;
  }

  int getGameTabControllerLength() {
    return 3;
  }

  int getGameChatCount() {
    return currentThread!.messages.length;
  }

  String getGameChatUnreadCountAsString(String id) {
    int unreadCount = currentThread!.messages.where((element) => !element.seenBy.contains(id)).length;

    if (currentGame!.bannedPlayers.contains(id) || unreadCount == 0) {
      return '';
    }

    return ' - $unreadCount';
  }

  String parsePlayerPresenceText(bool isPresent) {
    return isPresent ? DialogueService.playerIsPresentText.tr : DialogueService.playerIsNotPresentText.tr;
  }

  String getPlayerNameFromId(String id) {
    int playerNumber = currentGame!.playerIds.indexWhere((element) => element == id);

    return currentGame!.players[playerNumber].psuedonym;
  }

  String getGameStatusText() {
    if (!currentGame!.hasStarted && !currentGame!.hasFinished) {
      int numberOfPlayersToJoin = currentGame!.maxPlayers - currentGame!.players.length;
      return numberOfPlayersToJoin == 1
          ? DialogueService.waitingForOneMoreText.tr
          : numberOfPlayersToJoin == 0
              ? ''
              : DialogueService.waitingForText.tr + numberOfPlayersToJoin.toString() + DialogueService.morePlayersText.tr;
    } else if (currentGame!.hasStarted && !currentGame!.hasSessionEnded) {
      if (isPlayerTurn()) {
        if (currentGame!.die.lastRolledBy == currentGame!.players[playerNumber].id) {
          if (currentGame!.die.isRolling) {
            return DialogueService.youHaveRolledTheDieText.tr;
          } else {
            if (currentGame!.die.rolledValue == 0) {
              return DialogueService.yourTurnOnceMoreText.tr;
            } else {
              return DialogueService.youHaveRolledAText.tr + currentGame!.die.rolledValue.toString();
            }
          }
        } else {
          return DialogueService.yourTurnText.tr;
        }
      } else {
        if (currentGame!.die.lastRolledBy == currentGame!.players[currentGame!.playerTurn].id) {
          if (currentGame!.die.isRolling) {
            return currentGame!.players[currentGame!.playerTurn].psuedonym + DialogueService.hasRolledTheDieText.tr;
          } else {
            if (currentGame!.die.rolledValue == 0) {
              return DialogueService.waitingForParticularPlayerText.tr + currentGame!.players[currentGame!.playerTurn].psuedonym;
            } else {
              return currentGame!.players[currentGame!.playerTurn].psuedonym + DialogueService.hasRolledAText.tr + currentGame!.die.rolledValue.toString();
            }
          }
        }
        return DialogueService.waitingForParticularPlayerText.tr + currentGame!.players[currentGame!.playerTurn].psuedonym;
      }
    } else {
      return '';
    }
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

  Player getWinnerPlayer() {
    return currentGame!.players.firstWhere((element) => element.id == currentGame!.finishedPlayers.first);
  }

  Player getViciousPlayer() {
    List<Player> listOfPlayers = [...currentGame!.players];
    listOfPlayers.sort((b, a) => a.numberOfTimesKickerInSession.compareTo(b.numberOfTimesKickerInSession));
    return listOfPlayers.first;
  }

  Player getPunchingBagPlayer() {
    List<Player> listOfPlayers = [...currentGame!.players];
    listOfPlayers.sort((b, a) => a.numberOfTimesKickedInSession.compareTo(b.numberOfTimesKickedInSession));
    return listOfPlayers.first;
  }

  Color getSelectedPiecePathColour(int index, Color boardColour) {
    int dieValue = currentGame!.die.rolledValue;

    if (currentGame!.selectedPiece == null || !doesPlayerOwnPiece(currentGame!.selectedPiece!)) {
      return boardColour;
    } else {
      if (!currentGame!.selectedPiece!.isBased) {
        List<int> highLightedIndices = [];
        int playerNumber = currentGame!.selectedPiece!.owner;
        int positionIndex = Player.getPlayerValidIndices(playerNumber).indexWhere((element) => element == currentGame!.selectedPiece!.position);

        if (positionIndex + (dieValue) < Player.getPlayerValidIndices(playerNumber).length) {
          highLightedIndices.add(Player.getPlayerValidIndices(playerNumber)[positionIndex + dieValue]);
        }
        if (positionIndex - (dieValue) >= 0) {
          highLightedIndices.add(Player.getPlayerValidIndices(playerNumber)[positionIndex - dieValue]);
        }
        if (positionIndex - (dieValue) < 0) {
          // if (game.die.rolledValue != 1) {
          if (Player.getPlayerStartBackKickIndices(currentGame!.playerTurn)[(positionIndex - currentGame!.die.rolledValue).abs() - 1] == index) {
            if (doesIndexHaveEnemyPiece(index)) {
              highLightedIndices.add(index);
            }
          }
          // }
        }

        validMoveIndices = [...highLightedIndices];

        if (highLightedIndices.contains(index)) {
          if (doesIndexHaveEnemyPiece(index)) {
            return PlayerConstants.swatchList[currentGame!.players[playerNumber].playerColor].playerSelectedColor;
          } else {
            if (doesIndexContainFriendlyPiece(index)) {
              return boardColour;
            } else {
              return PlayerConstants.swatchList[currentGame!.players[playerNumber].playerColor].playerSelectedColor;
            }
          }
        } else {
          return boardColour;
        }
      } else {
        if (dieValue == 6) {
          if (Player.getPlayerStartIndex(playerNumber) == index) {
            validMoveIndices = [Player.getPlayerStartIndex(playerNumber)];
            if (doesIndexHaveEnemyPiece(index)) {
              return PlayerConstants.swatchList[currentGame!.players[playerNumber].playerColor].playerSelectedColor;
            } else {
              if (doesIndexContainFriendlyPiece(index)) {
                return boardColour;
              } else {
                return PlayerConstants.swatchList[currentGame!.players[playerNumber].playerColor].playerSelectedColor;
              }
            }
          } else {
            return boardColour;
          }
        } else {
          return boardColour;
        }
      }
    }
  }

  void clearJoinGameController() {
    joinGameController.clear();
  }

  void initialiseBoard() {
    board = Board.generateBoard();
  }

  void initialiseGame(Game game, Thread thread, String id) {
    // game
    currentGame = game;
    currentGameStream = DatabaseService.getCurrentGameStream(currentGame!.id);
    playerNumber = game.playerIds.indexWhere((element) => element == id);
    playerColor = PlayerConstants.swatchList[playerNumber].playerColor;
    playerSelectedColor = PlayerConstants.swatchList[playerNumber].playerSelectedColor;
    validMoveIndices = [];
    // thread
    currentThread = thread;
    currentThreadStream = DatabaseService.getCurrentThreadStream(currentGame!.id);
  }

  void syncGameData(BuildContext context, Game game, Users user) {
    checkIfPlayerIsKickedFromGame(game, user.id);
    checkIfPlayerHasLeftGame(game);
    checkIfGameHasStarted(game);
    checkIfGameHasReStarted(game);
    checkForReputationChange(game);
    currentGame = game;
    playerNumber = game.playerIds.indexWhere((element) => element == user.id);

    if (playerNumber == -1) {
      // if player has left game or for some reason cannot be found
      goBack();
      return;
    }

    playerColor = PlayerConstants.swatchList[playerNumber].playerColor;
    playerSelectedColor = PlayerConstants.swatchList[playerNumber].playerSelectedColor;
    startGame(user);
  }

  void syncThreadData(BuildContext context, Thread thread, Users user) {
    checkIfNewMessageHasArrived(thread, user.id, context);
    currentThread = thread;
  }

  void checkIfNewMessageHasArrived(Thread newThread, String id, BuildContext context) {
    if (newThread.messages.length > currentThread!.messages.length) {
      if (newThread.messages.first.createdById != id) {
        SoundProvider soundProvider = context.read<SoundProvider>();
        soundProvider.playSound(GameStatusService.newMessageReceived);
      }
    }
  }

  void checkIfPlayerIsKickedFromGame(Game game, String id) {
    if (game.kickedPlayers.contains(id)) {
      Utils.showToast(DialogueService.gameKickedText.tr);
      goBack();
    }
  }

  void checkIfPlayerHasLeftGame(Game game) {
    if (game.players.length < currentGame!.players.length) {
      for (var i = 0; i < currentGame!.players.length; i++) {
        if (!game.players.contains(currentGame!.players[i])) {
          Utils.showToast(currentGame!.players[i].psuedonym + DialogueService.playerHasLeftText.tr);
        }
      }
    } else if (game.players.length > currentGame!.players.length) {
      Utils.showToast(game.players.last.psuedonym + DialogueService.playerHasJoinedText.tr);
    }
  }

  void checkIfGameHasStarted(Game game) {
    if (!currentGame!.hasStarted && game.hasStarted) {
      Utils.showToast(DialogueService.gameHasStartedText.tr);
    }
  }

  void checkIfGameHasReStarted(Game game) {
    if (currentGame!.hasStarted && game.hasRestarted && game.hasRestarted != currentGame!.hasRestarted) {
      Utils.showToast(DialogueService.gameHasStartedText.tr);
    }
  }

  void checkForReputationChange(Game game) {
    if (game.players.length == currentGame!.players.length) {
      List<Player> oldList = [...currentGame!.players];
      List<Player> newList = [...game.players];
      oldList.sort((b, a) => a.id.compareTo(b.id));
      newList.sort((b, a) => a.id.compareTo(b.id));

      for (var i = 0; i < newList.length; i++) {
        if (Player.getPlayerReputation(newList[i].reputationValue) != Player.getPlayerReputation(oldList[i].reputationValue)) {
          String userId = Get.context!.read<UserProvider>().getUserID();

          if (newList[i].id == userId) {
            Utils.showToast(DialogueService.youText.tr + DialogueService.reputationChangedPluralText.tr + Player.getPlayerReputationName(newList[i].reputationValue));
          } else {
            Utils.showToast(newList[i].psuedonym + DialogueService.reputationChangedText.tr + Player.getPlayerReputationName(newList[i].reputationValue));
          }
        }
      }
    }
  }

  void removePlayerMessages(String id) {
    currentThread!.messages.removeWhere((element) => element.createdById == id);
  }

  void showGameIdSnackbar(String id) {
    if (isPlayerHost(id) && !currentGame!.hasStarted) {
      if (!currentGame!.isOffline) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          copyGameID();
        });
      }
    }
  }

  void copyGameID() {
    Utils.showToast(DialogueService.gameIDCopiedToClipboardText.tr);
    Utils.copyToClipboard(currentGame!.id);
  }

  void handleSuddenGameDeletion() {
    Utils.showToast(DialogueService.gameDeletedText.tr);
    goBack();
  }

  void handleConfettiDisplay(String id) {
    if (id == currentGame!.finishedPlayers.first) {
      confettiController.play();
    }
  }

  void goBack() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      NavigationService.goToBackToHomeScreen();
    });
  }

  Future<void> startGame(Users user) async {
    if (isPlayerHost(user.id)) {
      if (!currentGame!.hasStarted && !currentGame!.hasFinished) {
        if (currentGame!.maxPlayers == currentGame!.players.length) {
          if (currentGame!.shouldAutoStart) {
            await forceStartGame(user);
          }
        }
      }
    }
  }

  Move getValidMove() {
    List<Move> availableMoves = [];

    for (int j = 0; j < currentGame!.players[currentGame!.playerTurn].pieces.length; j++) {
      // handle six roll
      if (currentGame!.players[currentGame!.playerTurn].pieces[j].isBased && !currentGame!.players[currentGame!.playerTurn].pieces[j].isHome && currentGame!.die.rolledValue == 6) {
        if (!doesIndexContainFriendlyPiece(Player.getPlayerStartIndex(currentGame!.playerTurn))) {
          int index = Player.getPlayerStartIndex(currentGame!.playerTurn);

          availableMoves.add(
            Move(
              piece: currentGame!.players[currentGame!.playerTurn].pieces[j],
              direction: Direction.forward,
              destinationIndex: index,
              isGoingHome: Player.getPlayerHomeIndex(currentGame!.playerTurn) == index,
              isStartingKick: doesIndexContainEnemyPiece(index),
              isKick: doesIndexContainEnemyPiece(index),
              kickee: getKickedPlayerNumber(index),
            ),
          );
        }
      }

      // forward movement
      if (!currentGame!.players[currentGame!.playerTurn].pieces[j].isBased && !currentGame!.players[currentGame!.playerTurn].pieces[j].isHome) {
        List<int> validIndices = Player.getPlayerValidIndices(currentGame!.playerTurn);
        int piecePosition = validIndices.indexWhere((element) => element == currentGame!.players[currentGame!.playerTurn].pieces[j].position);
        //
        if (validIndices.asMap().containsKey(piecePosition + currentGame!.die.rolledValue)) {
          if (!doesIndexContainFriendlyPiece(validIndices[piecePosition + currentGame!.die.rolledValue])) {
            int index = validIndices[piecePosition + currentGame!.die.rolledValue];

            availableMoves.add(
              Move(
                piece: currentGame!.players[currentGame!.playerTurn].pieces[j],
                direction: Direction.forward,
                destinationIndex: index,
                isGoingHome: Player.getPlayerHomeIndex(currentGame!.playerTurn) == index,
                isStartingKick: false,
                isKick: doesIndexContainEnemyPiece(index),
                kickee: getKickedPlayerNumber(index),
              ),
            );
          }
        }

        // backward movement
        if (validIndices.asMap().containsKey(piecePosition - currentGame!.die.rolledValue)) {
          if (!doesIndexContainFriendlyPiece(validIndices[piecePosition - currentGame!.die.rolledValue])) {
            Game tempGame = Game.fromJson(currentGame!.toJson());
            tempGame.selectedPiece = currentGame!.players[currentGame!.playerTurn].pieces[j];
            //
            if (doesIndexContainEnemyPiece(getAIPlayerDestination(tempGame, false))) {
              int index = validIndices[piecePosition - currentGame!.die.rolledValue];

              availableMoves.add(
                Move(
                  piece: currentGame!.players[currentGame!.playerTurn].pieces[j],
                  direction: Direction.backward,
                  destinationIndex: index,
                  isGoingHome: Player.getPlayerHomeIndex(currentGame!.playerTurn) == index,
                  isStartingKick: false,
                  isKick: true,
                  kickee: getKickedPlayerNumber(index),
                ),
              );
            }
          }
        } else {
          if (Player.getPlayerStartBackKickIndices(currentGame!.playerTurn).asMap().containsKey((piecePosition - currentGame!.die.rolledValue).abs() - 1)) {
            Game tempGame = Game.fromJson(currentGame!.toJson());
            tempGame.selectedPiece = currentGame!.players[currentGame!.playerTurn].pieces[j];

            if (doesIndexContainEnemyPiece(Player.getPlayerStartBackKickIndices(currentGame!.playerTurn)[(piecePosition - currentGame!.die.rolledValue).abs() - 1])) {
              int index = Player.getPlayerStartBackKickIndices(currentGame!.playerTurn)[(piecePosition - currentGame!.die.rolledValue).abs() - 1];

              availableMoves.add(
                Move(
                  piece: currentGame!.players[currentGame!.playerTurn].pieces[j],
                  direction: Direction.backward,
                  destinationIndex: index,
                  isGoingHome: Player.getPlayerHomeIndex(currentGame!.playerTurn) == index,
                  isStartingKick: false,
                  isKick: true,
                  kickee: getKickedPlayerNumber(index),
                ),
              );
            }
          }
        }
      }
    }

    return makeFinalAIMoveDecision(availableMoves);
  }

  Move makeFinalAIMoveDecision(List<Move> availableMoves) {
    // factor in ai personality so moves they are not entirely random
    if (currentGame!.players[currentGame!.playerTurn].isAIPlayer) {
      switch (Player.getPlayerReputation(currentGame!.players[currentGame!.playerTurn].reputationValue)) {
        case PlayerConstants.pacifist:
          availableMoves = handlePacifistAIMoves([...availableMoves]);
          break;
        case PlayerConstants.averageJoe:
          availableMoves = handleNormalAIMoves([...availableMoves]);
          break;
        case PlayerConstants.vicious:
          availableMoves = handleViciousAIMoves([...availableMoves]);
          break;
      }
    }

    // if there are no moves available, return a null move. the move will be skipped
    return availableMoves.isEmpty ? Move.getNullMove() : availableMoves[random.nextInt(availableMoves.length)];
  }

  List<Move> handlePacifistAIMoves(List<Move> availableMoves) {
    // remove all kicks if possible but allow starting kicks otherwise ai may enter infinite loop
    availableMoves = availableMoves.where((element) => !element.isKick).toList().isEmpty && availableMoves.where((element) => element.isStartingKick).toList().isNotEmpty
        ? availableMoves.where((element) => element.isStartingKick).toList()
        : availableMoves.where((element) => !element.isKick).toList();
    // check if there are any home moves
    if (canPlayerGoHome(availableMoves)) {
      availableMoves = availableMoves.where((element) => element.isGoingHome).toList();
    }

    return availableMoves;
  }

  List<Move> handleNormalAIMoves(List<Move> availableMoves) {
    if (currentGame!.players[currentGame!.playerTurn].targetPlayerNumber != null) {
      availableMoves = handlePotentialTargetPlayer([...availableMoves], false);

      if (availableMoves.where((element) => element.kickee == currentGame!.players[currentGame!.playerTurn].targetPlayerNumber).toList().isNotEmpty) {
        return availableMoves;
      }
    }

    // if there is no target player in reach, try as much as possible to avoid back-kicks unless absolutely necessary
    if (availableMoves.where((element) => element.direction == Direction.forward).toList().isNotEmpty) {
      availableMoves = availableMoves.where((element) => element.direction == Direction.forward).toList();
    }
    // try and prioritize home moves
    if (canPlayerGoHome(availableMoves)) {
      availableMoves = availableMoves.where((element) => element.isGoingHome).toList();
    }

    return availableMoves;
  }

  List<Move> handleViciousAIMoves(List<Move> availableMoves) {
    // try and prioritize kicks if not then prioritize home moves
    availableMoves = availableMoves.where((element) => element.isKick).toList().isNotEmpty
        ? handlePotentialTargetPlayer([...availableMoves], true)
        : canPlayerGoHome(availableMoves)
            ? availableMoves.where((element) => element.isGoingHome).toList()
            : availableMoves;
    return availableMoves;
  }

  List<Move> handlePotentialTargetPlayer(List<Move> availableMoves, bool isVicious) {
    if (currentGame!.players[currentGame!.playerTurn].targetPlayerNumber != null) {
      // is there any way to kick target player?
      List<Move> targetPlayerKicks = availableMoves.where((element) => element.kickee == currentGame!.players[currentGame!.playerTurn].targetPlayerNumber).toList();

      if (targetPlayerKicks.isNotEmpty) {
        return targetPlayerKicks;
      }
    }

    if (isVicious) {
      return availableMoves.where((element) => element.isKick).toList();
    }

    return availableMoves;
  }

  int? getTargetNumberForAIPlayer(Game game, int playerNumber) {
    List<Player> playingPlayers = game.players.where((element) => !isPlayerNotPlaying(game, element)).toList();

    return getPlayerClosestToEnd(playingPlayers, playerNumber);
  }

  int? getPlayerClosestToEnd(List<Player> players, int playerNumber) {
    List<Player> tempPlayers = [...players];

    tempPlayers.sort((a, b) => a.distanceToHome.compareTo(b.distanceToHome));

    for (Player player in tempPlayers) {
      if (player.playerColor != playerNumber) {
        return player.playerColor;
      }
    }

    return null;
  }

  int? getKickedPlayerNumber(int index) {
    if (doesIndexContainEnemyPiece(index)) {
      for (int i = 0; i < currentGame!.players.length; i++) {
        for (int j = 0; j < currentGame!.players[i].pieces.length; j++) {
          if (currentGame!.players[i].pieces[j].position == index) {
            if (currentGame!.players[i].pieces[j].owner != currentGame!.playerTurn) {
              return currentGame!.players[i].pieces[j].owner;
            }
          }
        }
      }
    }

    return null;
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

  int determineDieValue() {
    int randomValue = (random.nextInt(6) + 1);

    if (currentGame!.shouldAssistStart) {
      if (currentGame!.players[currentGame!.playerTurn].numberOfDieRolls == 0) {
        return 6;
      }

      if (currentGame!.hostSettings.prefersCatchupAssist && currentGame!.players[currentGame!.playerTurn].pieces.where((element) => element.isBased).length == 4) {
        return 6;
      }

      return randomValue;
    } else {
      return randomValue;
    }
  }

  bool getIndexHitDefermentStatus(int index) {
    // return true;

    int dieValue = currentGame!.die.rolledValue;

    if (currentGame!.selectedPiece == null || !doesPlayerOwnPiece(currentGame!.selectedPiece!)) {
      return false;
    } else {
      if (!currentGame!.selectedPiece!.isBased) {
        List<int> highLightedIndices = [];
        int playerNumber = currentGame!.selectedPiece!.owner;
        int positionIndex = Player.getPlayerValidIndices(playerNumber).indexWhere((element) => element == currentGame!.selectedPiece!.position);

        if (positionIndex + (dieValue) < Player.getPlayerValidIndices(playerNumber).length) {
          highLightedIndices.add(Player.getPlayerValidIndices(playerNumber)[positionIndex + dieValue]);
        }
        if (positionIndex - (dieValue) >= 0) {
          highLightedIndices.add(Player.getPlayerValidIndices(playerNumber)[positionIndex - dieValue]);
        }
        if (positionIndex - (dieValue) < 0) {
          //  if (currentGame!.die.rolledValue != 1) {
          if (Player.getPlayerStartBackKickIndices(currentGame!.playerTurn)[(positionIndex - currentGame!.die.rolledValue).abs() - 1] == index) {
            if (doesIndexHaveEnemyPiece(index)) {
              highLightedIndices.add(index);
            }
          }
          //  }
        }

        validMoveIndices = [...highLightedIndices];

        if (highLightedIndices.contains(index)) {
          if (doesIndexHaveEnemyPiece(index)) {
            return true;
          } else {
            //   print('here');
            return false;
          }
        } else {
          return false;
        }
      } else {
        if (dieValue == 6) {
          if (Player.getPlayerStartIndex(playerNumber) == index) {
            validMoveIndices = [Player.getPlayerStartIndex(playerNumber)];

            if (doesIndexHaveEnemyPiece(index)) {
              return true;
            } else {
              return false;
            }
          } else {
            return false;
          }
        } else {
          return false;
        }
      }
    }
  }

  bool doesIndexHaveEnemyPiece(int index) {
    bool doesIndexHaveEnemyPiece = false;
    for (int i = 0; i < currentGame!.players.length; i++) {
      for (int j = 0; j < currentGame!.players[i].pieces.length; j++) {
        if ((validMoveIndices.contains(currentGame!.players[i].pieces[j].position) ||
                Player.getPlayerStartBackKickIndices(currentGame!.playerTurn).contains(currentGame!.players[i].pieces[j].position)) &&
            currentGame!.players[i].pieces[j].owner != playerNumber) {
          if (currentGame!.players[i].pieces[j].position == index) {
            doesIndexHaveEnemyPiece = true;
          }
        }
      }
    }
    return doesIndexHaveEnemyPiece;
  }

  bool isPlayerTurn() {
    return currentGame!.playerTurn == playerNumber;
  }

  bool checkIfPlayerCanMove() {
    return currentGame!.playerTurn == playerNumber && !currentGame!.die.isRolling && currentGame!.die.rolledValue != 0;
  }

  bool isOnlyOnePlayerLeft() {
    return currentGame!.players.where((element) => !element.hasLeft || !currentGame!.kickedPlayers.contains(element.id)).length == 1;
  }

  bool checkIfAllHumanPlayersAreDone() {
    List<Player> humanPlayers = currentGame!.players.where((element) => !element.isAIPlayer).toList();

    for (var i = 0; i < humanPlayers.length; i++) {
      if (humanPlayers[i].pieces.where((element) => element.isHome).length != 4) {
        return false;
      }
    }

    return true;
  }

  bool checkIfGameHasEnded() {
    if (!currentGame!.hasSessionEnded) {
      bool areAllPiecesHome = true;

      for (int i = 0; i < currentGame!.players.length; i++) {
        if (!currentGame!.players[i].hasLeft || currentGame!.kickedPlayers.contains(currentGame!.players[i].id)) {
          for (int j = 0; j < currentGame!.players[i].pieces.length; j++) {
            if (!currentGame!.players[i].pieces[j].isHome) {
              areAllPiecesHome = false;
            }
          }
        }
      }

      return areAllPiecesHome || checkIfAllHumanPlayersAreDone() || currentGame!.players.where((element) => !element.hasLeft).length - currentGame!.finishedPlayers.length == 1;
    }

    return false;
  }

  bool wasPreviousRollNotASix() {
    return currentGame!.die.rolledValue != 6;
  }

  bool doesIndexContainFriendlyPiece(int index) {
    for (int i = 0; i < currentGame!.players.length; i++) {
      for (int j = 0; j < currentGame!.players[i].pieces.length; j++) {
        if (currentGame!.players[i].pieces[j].position == index) {
          if (currentGame!.players[i].pieces[j].owner == currentGame!.playerTurn) {
            return true;
          }
        }
      }
    }

    return false;
  }

  bool doesIndexContainEnemyPiece(int index) {
    for (int i = 0; i < currentGame!.players.length; i++) {
      for (int j = 0; j < currentGame!.players[i].pieces.length; j++) {
        if (currentGame!.players[i].pieces[j].position == index) {
          if (currentGame!.players[i].pieces[j].owner != currentGame!.playerTurn) {
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

  bool isPieceSelected(Piece piece) {
    if (currentGame!.selectedPiece == null) {
      return false;
    } else {
      return currentGame!.selectedPiece!.owner == piece.owner && currentGame!.selectedPiece!.pieceNumber == piece.pieceNumber;
    }
  }

  bool isMovePlayerPossible() {
    for (int j = 0; j < currentGame!.players[currentGame!.playerTurn].pieces.length; j++) {
      if (!currentGame!.players[currentGame!.playerTurn].pieces[j].isBased && !currentGame!.players[currentGame!.playerTurn].pieces[j].isHome) {
        List<int> validIndices = Player.getPlayerValidIndices(currentGame!.playerTurn);
        int piecePosition = validIndices.indexWhere((element) => element == currentGame!.players[currentGame!.playerTurn].pieces[j].position);

        // if forward move is possible
        if (validIndices.asMap().containsKey(piecePosition + currentGame!.die.rolledValue)) {
          if (!doesIndexContainFriendlyPiece(validIndices[piecePosition + currentGame!.die.rolledValue])) {
            return true;
          }
        }

        // if backward move is possible
        if (validIndices.asMap().containsKey(piecePosition - currentGame!.die.rolledValue)) {
          if (!doesIndexContainFriendlyPiece(validIndices[piecePosition - currentGame!.die.rolledValue])) {
            return true;
          }
        } else {
          if (!doesIndexContainFriendlyPiece(Player.getPlayerStartBackKickIndices(currentGame!.playerTurn)[(piecePosition - currentGame!.die.rolledValue).abs() - 1])) {
            if (doesIndexContainEnemyPiece(Player.getPlayerStartBackKickIndices(currentGame!.playerTurn)[(piecePosition - currentGame!.die.rolledValue).abs() - 1])) {
              return true;
            }
          }
        }
      }
    }

    return false;
  }

  bool canPlayerKick() {
    if (isMovePlayerPossible()) {
      for (int i = 0; i < currentGame!.players[currentGame!.playerTurn].pieces.length; i++) {
        // if the piece is not home
        if (!currentGame!.players[currentGame!.playerTurn].pieces[i].isHome) {
          // first check if based pieces can kick by checking if the user has a 6
          if (currentGame!.players[currentGame!.playerTurn].pieces[i].isBased) {
            if (currentGame!.die.rolledValue == 6) {
              if (doesIndexContainEnemyPiece(Player.getPlayerStartIndex(currentGame!.playerTurn))) {
                return true;
              }
            }
          } else {
            // check pieces in play
            List<int> validIndices = Player.getPlayerValidIndices(currentGame!.playerTurn);
            int piecePosition = validIndices.indexWhere((element) => element == currentGame!.players[currentGame!.playerTurn].pieces[i].position);

            // does forwards index exist?
            if (validIndices.asMap().containsKey(piecePosition + currentGame!.die.rolledValue)) {
              if (doesIndexContainEnemyPiece(validIndices[piecePosition + currentGame!.die.rolledValue])) {
                return true;
              }
            }

            // does backwards index exist?
            if (validIndices.asMap().containsKey(piecePosition - currentGame!.die.rolledValue)) {
              if (doesIndexContainEnemyPiece(validIndices[piecePosition - currentGame!.die.rolledValue])) {
                return true;
              }
            } else {
              if (!doesIndexContainFriendlyPiece(Player.getPlayerStartBackKickIndices(currentGame!.playerTurn)[(piecePosition - currentGame!.die.rolledValue).abs() - 1])) {
                if (doesIndexContainEnemyPiece(Player.getPlayerStartBackKickIndices(currentGame!.playerTurn)[(piecePosition - currentGame!.die.rolledValue).abs() - 1])) {
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

  Game incrementCouldHaveBeenKicked(index) {
    int playerNumber = 1000;

    for (var i = 0; i < currentGame!.players.length; i++) {
      for (var j = 0; j < currentGame!.players[i].pieces.length; j++) {
        if (currentGame!.players[i].pieces[j].position == index) {
          playerNumber = i;
        }
      }
    }

    if (currentGame!.players[playerNumber].isAIPlayer) {
      currentGame!.players[playerNumber].setReputationValue(currentGame!.players[playerNumber].reputationValue + 1);
    }
    return currentGame!;
  }

  Game incrementKickStats(int kickerIndex, int kickedIndex) {
    currentGame!.players[kickedIndex].numberOfTimesKickedInSession++;
    currentGame!.players[kickerIndex].numberOfTimesKickerInSession++;

    return currentGame!;
  }

  Game resetGamePiecesToDefaultAfterPlayerLeaves(Game game, String id) {
    game.players[game.players.indexWhere((element) => element.id == id)].pieces = [...Piece.getDefaultPieces(game.players.indexWhere((element) => element.id == id))];
    return game;
  }

  Game resetKickStats() {
    for (Player player in currentGame!.players) {
      player.numberOfTimesKickedInSession = 0;
      player.numberOfTimesKickerInSession = 0;
    }
    return currentGame!;
  }

  Future<void> hostGame(Users user, Uuid uuid, AppProvider appProvider, bool isOffline) async {
    appProvider.setLoading(true, true);

    try {
      Game newGame = await DatabaseService.createGame(user, uuid, isOffline);
      Thread newThread = await DatabaseService.createThread(user, newGame.id);

      initialiseGame(newGame, newThread, user.id);
      appProvider.setLoading(false, true);
      NavigationService.goToGameScreen();
    } catch (e) {
      appProvider.setLoading(false, true);
      Utils.showToast(DialogueService.genericErrorText.tr);
      debugPrint(e.toString());
    }
  }

  Future<void> reJoinGame(Game game, Users user, AppProvider appProvider) async {
    appProvider.setLoading(true, true);

    try {
      Game? newGame = await DatabaseService.getGame(game.id);

      if (newGame == null) {
        appProvider.setLoading(false, true);
        Utils.showToast(DialogueService.gameDeletedToastText.tr);
        return;
      } else {
        if (doesGameVersionMatch(user.appVersion, newGame.hostAppVersion)) {
          int playerNumber = newGame.playerIds.indexWhere((element) => element == user.id);

          newGame.players[playerNumber].hasLeft = false;
          newGame.players[playerNumber].isPresent = true;

          await DatabaseService.updateGame(newGame, false, shouldSyncWithFirestore: true);

          initialiseGame(newGame, (await DatabaseService.getThread(newGame.id))!, user.id);
          appProvider.setLoading(false, true);
          NavigationService.goToGameScreen();
        } else {
          NavigationService.goToUpgradeScreen();
        }
      }
    } catch (e) {
      appProvider.setLoading(false, true);
      Utils.showToast(DialogueService.genericErrorText.tr);
      debugPrint(e.toString());
    }
  }

  Future<void> joinGameWithCode(Users user, AppProvider appProvider) async {
    if (isJoinGameCodeValidLength()) {
      appProvider.setLoading(true, true);

      try {
        Game? newGame = await DatabaseService.getGame(joinGameController.text.trim());

        clearJoinGameController();

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
            reJoinGame(newGame, user, appProvider);
            return;
          } else if (newGame.players.length == newGame.maxPlayers) {
            // full
            Utils.showToast(DialogueService.gameFullText.tr);
            appProvider.setLoading(false, true);
            return;
          }

          if (doesGameVersionMatch(user.appVersion, newGame.hostAppVersion)) {
            // add new player
            await DatabaseService.addNewHumanPlayerToGame(newGame, user);
            newGame = await DatabaseService.getGame(newGame.id);
            initialiseGame(newGame!, (await DatabaseService.getThread(newGame.id))!, user.id);
            appProvider.setLoading(false, true);
            NavigationService.goToGameScreen();
          } else {
            NavigationService.goToUpgradeScreen();
          }
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

      if (!currentGame!.hostSettings.prefersProfanity && Utils.isStringProfane(value)) {
        Utils.showToast(DialogueService.profaneMessageText.tr);
        return;
      }
      soundProvider.playSound(GameStatusService.newMessageSent);
      DatabaseService.sendGameChat(id, currentGame!.id, value);
    }

    gameChatController.clear();
    Utils.dismissKeyboard();
  }

  Future<void> handleGameChatReadStatus(VisibilityInfo visibilityInfo, String id, int index) async {
    if (visibilityInfo.visibleFraction == 1) {
      if (!currentThread!.messages[index].seenBy.contains(id)) {
        currentThread!.messages[index].seenBy.add(id);

        await DatabaseService.updateThread(currentThread!);
      }
    }
  }

  Future<void> togglePlayerBanFromChat(Player player, BuildContext context) async {
    if (currentGame!.bannedPlayers.contains(player.id)) {
      currentGame!.bannedPlayers.remove(player.id);
      Utils.showToast(player.psuedonym + DialogueService.playerUnBannedText.tr);
    } else {
      showBanPlayerDialog(player, context);
    }

    await DatabaseService.updateGame(currentGame!, true);
  }

  Future<void> kickPlayerFromGame(Player player) async {
    currentGame!.kickedPlayers.add(player.id);
    currentGame = resetGamePiecesToDefaultAfterPlayerLeaves(currentGame!, player.id);
    currentGame!.players[currentGame!.players.indexWhere((element) => element.id == player.id)].hasLeft = true;
    removePlayerMessages(player.id);
    Utils.showToast(player.psuedonym + DialogueService.playerKickedFromGameText.tr);

    await DatabaseService.updateGame(currentGame!, true, shouldSyncWithFirestore: true);

    if (!currentGame!.hasStarted || currentGame!.hasSessionEnded) {
      Future.delayed(const Duration(seconds: 1), () async {
        await removePlayerFromGame(currentGame!, player.id);
      });
    }
  }

  Future<void> leaveGame(Game game, String id, Users user) async {
    if (game.hostId == id) {
      await DatabaseService.deleteGame(game.id, user);
    } else {
      if (Get.currentRoute != GameScreenWrapper.routeName) {
        initialiseGame(game, (await DatabaseService.getThread(game.id))!, id);
      }

      game.players[game.players.indexWhere((element) => element.id == id)].hasLeft = true;
      removePlayerMessages(id);
      game = resetGamePiecesToDefaultAfterPlayerLeaves(game, id);
      if (isOnlyOnePlayerLeft()) {
        await DatabaseService.deleteGame(game.id, user);
      } else {
        if (!game.hasStarted) {
          await removePlayerFromGame(game, id);
          return;
        }
        if (game.playerTurn == game.players[game.players.indexWhere((element) => element.id == id)].playerColor) {
          await incrementTurn(game, user);
        }
        game.reaction = Reaction.parseGameStatus(GameStatusService.playerLeft);
        await DatabaseService.updateGame(game, true, shouldSyncWithFirestore: true);
      }

      if (Get.currentRoute == GameScreenWrapper.routeName) {
        NavigationService.goToBackToHomeScreen();
      }
    }
  }

  Future<void> removePlayerFromGame(Game game, String id) async {
    game.players.removeWhere((element) => element.id == id);
    game.playerIds.remove(id);

    for (int i = 0; i < game.players.length; i++) {
      game.players[i].pieces = Piece.getDefaultPieces(i);
      game.players[i].playerColor = i;
    }

    await DatabaseService.updateGame(game, true, shouldSyncWithFirestore: true);
  }

  Future<void> incrementTurn(Game game, Users user) async {
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
      if (!checkIfGameHasEnded()) {
        // calculate player distance to home
        for (Player player in game.players) {
          player.distanceToHome = Player.calculateTotalDistanceToHome(player);
        }
        // calculate player distance to home

        // determine target player for each AI player
        for (Player player in game.players
            .where((element) => element.isAIPlayer)
            .toList()
            .where((element) => Player.getPlayerReputation(element.reputationValue) != PlayerConstants.pacifist)
            .toList()) {
          player.targetPlayerNumber = getTargetNumberForAIPlayer(game, player.playerColor);
        }
        // determine target player for each AI player

        game.canPass = false;

        if (game.playerTurn + 1 >= game.players.length) {
          // if previous value was 6
          if (wasPreviousRollNotASix()) {
            game.playerTurn = 0;
          }
        } else {
          // if previous value was 6
          if (wasPreviousRollNotASix()) {
            game.playerTurn++;
          }
        }

        if (isPlayerNotPlaying(game, game.players[game.playerTurn])) {
          await incrementTurn(game, user);
        } else if (game.players[game.playerTurn].isAIPlayer) {
          await rollDieForAIPlayer(game, user);
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

  Future<void> rollDieForAIPlayer(Game game, Users user) async {
    if (!game.hasSessionEnded) {
      Future.delayed(Duration(milliseconds: game.hostSettings.preferredSpeed), () async {
        await rollDie(game.players[currentGame!.playerTurn].id, user);
      });
    }
  }

  Future<void> rollDie(String userId, Users user) async {
    if (!currentGame!.hasSessionEnded) {
      bool areAllPiecesBased = true;

      currentGame!.players[currentGame!.playerTurn].isPresent = true;

      currentGame!.die.isRolling = true;
      currentGame!.die.lastRolledBy = userId;
      currentGame!.die.rolledValue = 0;
      currentGame!.players[currentGame!.playerTurn].numberOfDieRolls++;
      currentGame!.selectedPiece = null;
      currentGame!.hasRestarted = false;
      currentGame!.canPass = false;

      await DatabaseService.updateGame(currentGame!, true);

      Future.delayed(const Duration(milliseconds: 1000), () async {
        currentGame!.die.isRolling = false;
        currentGame!.die.lastRolledBy = userId;
        currentGame!.reaction = Reaction.parseGameStatus(GameStatusService.playerRoll);
        currentGame!.die.rolledValue = determineDieValue();

        await DatabaseService.updateGame(currentGame!, true);

        // check if user has no valid moves
        Future.delayed(Duration(milliseconds: currentGame!.hostSettings.preferredSpeed), () async {
          for (int i = 0; i < currentGame!.players[currentGame!.playerTurn].pieces.length; i++) {
            if (!currentGame!.players[currentGame!.playerTurn].pieces[i].isBased) {
              areAllPiecesBased = false;
            }
          }

          if (currentGame!.die.rolledValue != 6 && areAllPiecesBased) {
            currentGame!.reaction = Reaction.parseGameStatus(GameStatusService.blank);
            await incrementTurn(currentGame!, user);
          } else {
            if (currentGame!.players[currentGame!.playerTurn].isAIPlayer) {
              handleAIPlayerGameLogic(user);
            } else {
              Game tempGame = Game.fromJson(currentGame!.toJson());
              tempGame.canPass = true;
              tempGame.canPlay = true;
              await DatabaseService.updateGame(tempGame, true);
            }
          }
        });
      });
    }
  }

  Future<void> handleAIPlayerGameLogic(Users user) async {
    if (!currentGame!.hasSessionEnded) {
      Future.delayed(Duration(milliseconds: currentGame!.hostSettings.preferredSpeed), () async {
        try {
          // determine valid moves
          Move move = getValidMove();
          currentGame!.selectedPiece = move.piece;

          if (currentGame!.selectedPiece == null) {
            await passTurn(user);
          } else {
            await movePiece(move.destinationIndex!, move.piece, user);
          }
        } catch (e) {
          await passTurn(user);
          Utils.showToast(DialogueService.genericErrorText.tr);
        }
      });
    }
  }

  Future<void> passTurn(Users user) async {
    if (!currentGame!.hasSessionEnded) {
      currentGame!.selectedPiece = null;
      await incrementTurn(currentGame!, user);
    }
  }

  Future<void> movePiece(int destinationIndex, Piece? selectedPiece, Users user) async {
    if (!currentGame!.hasSessionEnded) {
      currentGame!.canPass = false;

      // AI REPUTATION
      if (currentGame!.hasAdaptiveAI) {
        for (int i = 0; i < currentGame!.players[currentGame!.playerTurn].pieces.length; i++) {
          // if the piece is not home
          if (!currentGame!.players[currentGame!.playerTurn].pieces[i].isHome) {
            // first check if based pieces can kick by checking if the user has a 6
            if (currentGame!.players[currentGame!.playerTurn].pieces[i].isBased) {
              if (currentGame!.die.rolledValue == 6) {
                if (doesIndexContainEnemyPiece(Player.getPlayerStartIndex(currentGame!.playerTurn))) {
                  currentGame = incrementCouldHaveBeenKicked(Player.getPlayerStartIndex(currentGame!.playerTurn));
                }
              }
            } else {
              // check pieces in play
              List<int> validIndices = Player.getPlayerValidIndices(currentGame!.playerTurn);
              int piecePosition = validIndices.indexWhere((element) => element == currentGame!.players[currentGame!.playerTurn].pieces[i].position);

              // does forwards index exist?
              if (validIndices.asMap().containsKey(piecePosition + currentGame!.die.rolledValue)) {
                if (doesIndexContainEnemyPiece(validIndices[piecePosition + currentGame!.die.rolledValue])) {
                  currentGame = incrementCouldHaveBeenKicked(validIndices[piecePosition + currentGame!.die.rolledValue]);
                }
              }

              // does backwards index exist?
              if (validIndices.asMap().containsKey(piecePosition - currentGame!.die.rolledValue)) {
                if (doesIndexContainEnemyPiece(validIndices[piecePosition - currentGame!.die.rolledValue])) {
                  currentGame = incrementCouldHaveBeenKicked(validIndices[piecePosition - currentGame!.die.rolledValue]);
                }
              } else {
                if (Player.getPlayerStartBackKickIndices(currentGame!.playerTurn).asMap().containsKey((piecePosition - currentGame!.die.rolledValue).abs() - 1)) {
                  if (doesIndexContainEnemyPiece(Player.getPlayerStartBackKickIndices(currentGame!.playerTurn)[(piecePosition - currentGame!.die.rolledValue).abs() - 1])) {
                    currentGame =
                        incrementCouldHaveBeenKicked(Player.getPlayerStartBackKickIndices(currentGame!.playerTurn)[(piecePosition - currentGame!.die.rolledValue).abs() - 1]);
                  }
                }
              }
            }
          }
        }
      }

      // HUMAN REPUTATION
      if (canPlayerKick()) {
        // if player is human, check if a kick is possible and update reputation
        if (!currentGame!.players[currentGame!.playerTurn].isAIPlayer) {
          currentGame!.players[currentGame!.playerTurn].setReputationValue(currentGame!.players[currentGame!.playerTurn].reputationValue + 1);
          await updateUserCouldKick(currentGame!, user);
        }
      }

      for (int i = 0; i < currentGame!.players.length; i++) {
        for (int j = 0; j < currentGame!.players[i].pieces.length; j++) {
          if (currentGame!.players[i].pieces[j].position == destinationIndex) {
            if (currentGame!.players[i].pieces[j].owner != currentGame!.playerTurn) {
              // kick player
              currentGame!.players[i].pieces[j].isBased = true;
              currentGame!.players[i].pieces[j].isHome = false;
              currentGame!.players[i].pieces[j].position =
                  Piece.determineInitialPiecePosition(currentGame!.players[i].pieces[j].owner, currentGame!.players[i].pieces[j].pieceNumber);

              currentGame = incrementKickStats(currentGame!.playerTurn, currentGame!.players[i].pieces[j].owner);

              // handle adaptive ai - increment kick
              if (currentGame!.hasAdaptiveAI && currentGame!.players[i].isAIPlayer) {
                currentGame!.players[i].setReputationValue(currentGame!.players[i].reputationValue - 2);
              }

              // update user kick stats
              if (!currentGame!.players[currentGame!.playerTurn].isAIPlayer) {
                currentGame!.players[currentGame!.playerTurn].setReputationValue(currentGame!.players[currentGame!.playerTurn].reputationValue - 2);
                // await updateUserKicked(currentGame!);
                updateUserKicked(currentGame!, user);
              }

              // set currentGame! status
              currentGame!.reaction = Reaction.parseGameStatus(GameStatusService.playerKick);
              // make the move
              await incrementPlayerPosition(destinationIndex, false, selectedPiece!.isBased, user);
              return;
            } else {
              if (currentGame!.players[i].pieces[j].isHome) {
                await incrementPlayerPosition(destinationIndex, false, false, user);
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

      if (Player.getPlayerHomeIndex(currentGame!.playerTurn) == destinationIndex) {
        currentGame!.reaction = Reaction.parseGameStatus(GameStatusService.playerHome);
        // go home
        await incrementPlayerPosition(destinationIndex, true, false, user);
      } else if (selectedPiece!.isBased) {
        // coming out of base
        await incrementPlayerPosition(destinationIndex, false, true, user);
      } else {
        // make normal move
        await incrementPlayerPosition(destinationIndex, false, false, user);
      }
    }
  }

  Future<void> updateUserCouldKick(Game game, Users user) async {
    String id = game.players[game.playerTurn].id;
    int reputationValue = game.players[game.playerTurn].reputationValue;

    if (id == user.id) {
      user.setReputationValue(reputationValue);
      LocalStorageService.setUser(user);
    }

    await DatabaseService.updateUserCouldKick(id, reputationValue);
  }

  Future<void> updateUserKicked(Game game, Users user) async {
    String id = game.players[game.playerTurn].id;
    int reputationValue = game.players[game.playerTurn].reputationValue;

    if (id == user.id) {
      user.setReputationValue(reputationValue);
      LocalStorageService.setUser(user);
    }

    await DatabaseService.updateUserKicked(id, reputationValue);
  }

  Future<void> incrementPlayerPosition(int destinationIndex, bool isGoingHome, bool isLeavingBase, Users user) async {
    if (!currentGame!.hasSessionEnded) {
      int selectedPieceNumber = currentGame!.players[currentGame!.playerTurn].pieces.indexWhere((element) => element.pieceNumber == currentGame!.selectedPiece!.pieceNumber);

      // SET PIECE DESTINATION
      currentGame!.players[currentGame!.playerTurn].pieces[selectedPieceNumber].position = destinationIndex;

      if (isGoingHome) {
        currentGame!.players[currentGame!.playerTurn].pieces[selectedPieceNumber].isHome = true;
        currentGame!.players[currentGame!.playerTurn].pieces[selectedPieceNumber].isBased = true;
        currentGame!.players[currentGame!.playerTurn].pieces[selectedPieceNumber].position = Piece.determineInitialPiecePosition(
            currentGame!.players[currentGame!.playerTurn].pieces[selectedPieceNumber].owner, currentGame!.players[currentGame!.playerTurn].pieces[selectedPieceNumber].pieceNumber);
      }

      if (isLeavingBase) {
        currentGame!.players[currentGame!.playerTurn].pieces[selectedPieceNumber].isHome = false;
        currentGame!.players[currentGame!.playerTurn].pieces[selectedPieceNumber].isBased = false;
      }

      currentGame!.selectedPiece = null;

      await incrementTurn(currentGame!, user);
    }
  }

  Future<void> handleMovePieceTap(int index, Users user) async {
    if (currentGame!.canPlay && checkIfPlayerCanMove()) {
      if (currentGame!.selectedPiece != null) {
        if (validMoveIndices.contains(index)) {
          currentGame!.canPlay = false;
          notifyListeners();
          await movePiece(index, currentGame!.selectedPiece, user);
        }
      }
    }
  }

  Future<void> selectPiece(Piece piece) async {
    if (isPlayerTurn() && checkIfPlayerCanMove() && currentGame!.canPass) {
      if (!piece.isHome && doesPlayerOwnPiece(piece)) {
        currentGame!.selectedPiece = Piece.fromJson(piece.toJson());
        notifyListeners();
        await DatabaseService.updateGame(currentGame!, true);
      }
    }
  }

  Future<void> scrollToBoardTab() async {
    NavProvider navProvider = Get.context!.read<NavProvider>();

    if (navProvider.gameScreenTabController.index != 1) {
      navProvider.gameScreenTabController.animateTo(1);
    }
  }

  Future<void> forceStartGame(Users user) async {
    currentGame!.hasStarted = true;
    currentGame!.canPlay = true;
    currentGame!.maxPlayers = currentGame!.players.length;
    currentGame!.reaction = Reaction.parseGameStatus(GameStatusService.gameStart);

    scrollToBoardTab();

    await DatabaseService.updateGame(currentGame!, true, shouldSyncWithFirestore: true);

    // get ai player to start game
    if (currentGame!.players[0].isAIPlayer) {
      await rollDie(currentGame!.players[0].id, user);
    }
  }

  Future<void> restartGame(Users user) async {
    currentGame!.hasFinished = false;
    currentGame!.hasSessionEnded = false;
    currentGame!.hasStarted = true;
    currentGame!.hasRestarted = true;
    currentGame!.canPlay = true;
    currentGame!.playerTurn = 0;
    currentGame!.finishedPlayers = [];
    currentGame!.reaction = Reaction.parseGameStatus(GameStatusService.blank);
    currentGame!.die = Die.getDefaultDie();
    currentGame!.selectedPiece = null;

    for (int i = 0; i < currentGame!.players.length; i++) {
      currentGame!.players[i].pieces = Piece.getDefaultPieces(i);
      currentGame!.players[i].hasFinished = false;
      currentGame!.players[i].numberOfDieRolls = 0;
    }

    currentGame = resetKickStats();

    Utils.showToast(DialogueService.yourGameHasBeenRestartedText.tr);

    scrollToBoardTab();

    await DatabaseService.updateGame(currentGame!, true);

    notifyListeners();

    // get ai player to start currentGame!
    if (currentGame!.players[0].isAIPlayer) {
      await rollDie(currentGame!.players[0].id, user);
    }
  }

  Future<void> reorderPlayerList(int oldIndex, int newIndex) async {
    if (newIndex > oldIndex) {
      newIndex = newIndex - 1;
    }

    String id = currentGame!.playerIds.removeAt(oldIndex);
    Player player = currentGame!.players.removeAt(oldIndex);

    currentGame!.playerIds.insert(newIndex, id);
    currentGame!.players.insert(newIndex, player);

    for (int i = 0; i < currentGame!.players.length; i++) {
      currentGame!.players[i].pieces = Piece.getDefaultPieces(i);
      currentGame!.players[i].playerColor = i;
    }

    await DatabaseService.updateGame(currentGame!, true, shouldSyncWithFirestore: true);
  }

  Future<void> setGamePresence(bool value) async {
    currentGame!.players[playerNumber].isPresent = value;
    await DatabaseService.updateGame(currentGame!, false);
  }

  Future<void> handleGameAppLifecycleChange(bool value, Users user) async {
    if (currentGame != null) {
      await setGamePresence(value);
    }
  }

  Future<void> handleGamePopupSelection(int value, Users user, BuildContext context) async {
    switch (value) {
      case 0:
        currentGame!.hasSessionEnded ? restartGame(user) : showRestartGameDialog(context, user);
        break;
      case 1:
        if (!currentGame!.hasStarted && isPlayerHost(user.id) && currentGame!.players.length > 1) {
          forceStartGame(user);
        } else {
          endSession(currentGame!);
        }
        break;
      case 2:
        showLeaveOrDeleteGameDialog(currentGame!, user, context);
        break;
      case 3:
        copyGameID();
        break;
    }
  }

  Future<void> endSession(Game game) async {
    game.hasFinished = false;
    game.hasStarted = true;
    game.hasSessionEnded = true;
    game.reaction = Reaction.parseGameStatus(GameStatusService.gameFinish);

    await DatabaseService.updateGame(game, true);

    scrollToBoardTab();
  }

  Future<void> deleteGame(Game game, Users user) async {
    Utils.showToast(DialogueService.gameDeletedToastText.tr);
    DatabaseService.deleteGame(game.id, user);
  }

  showBanPlayerDialog(Player player, BuildContext context) {
    return showChoiceDialog(
      titleMessage: DialogueService.banPlayerDialogTitleText.tr,
      contentMessage: DialogueService.banPlayerDialogContentText.tr,
      yesMessage: DialogueService.banPlayerDialogYesText.tr,
      noMessage: DialogueService.banPlayerDialogNoText.tr,
      onYes: () {
        currentGame!.bannedPlayers.add(player.id);
        removePlayerMessages(player.id);
        Utils.showToast(player.psuedonym + DialogueService.playerBannedText.tr);
      },
      onNo: () {},
      context: context,
    );
  }

  showKickPlayerDialog(Player player, BuildContext context) {
    return showChoiceDialog(
      titleMessage: DialogueService.kickPlayerDialogTitleText.tr,
      contentMessage: DialogueService.kickPlayerDialogContentText.tr,
      yesMessage: DialogueService.kickPlayerDialogYesText.tr,
      noMessage: DialogueService.kickPlayerDialogNoText.tr,
      onYes: () {
        kickPlayerFromGame(player);
      },
      onNo: () {},
      context: context,
    );
  }

  showRestartGameDialog(BuildContext context, Users user) {
    return showChoiceDialog(
        context: context,
        titleMessage: DialogueService.restartGameDialogTitleText.tr,
        contentMessage: DialogueService.restartGameDialogContentText.tr,
        yesMessage: DialogueService.restartGameDialogYesText.tr,
        noMessage: DialogueService.restartGameDialogNoText.tr,
        onYes: () async {
          await restartGame(user);
        },
        onNo: () {});
  }

  Future<void> showRejoinGameDialog(Game game, Users user, BuildContext context) async {
    showChoiceDialog(
      titleMessage: DialogueService.rejoinGameDialogTitleText.tr,
      contentMessage: DialogueService.rejoinGameDialogContentText.tr,
      yesMessage: DialogueService.rejoinGameDialogYesText.tr,
      noMessage: DialogueService.rejoinGameDialogNoText.tr,
      onYes: () {
        reJoinGame(game, user, context.read<AppProvider>());
      },
      onNo: () {},
      context: context,
    );
  }

  Future<void> showLeaveOrDeleteGameDialog(Game game, Users user, BuildContext context) async {
    if (user.id == game.hostId) {
      // delete game
      showChoiceDialog(
        titleMessage: DialogueService.deleteGameDialogTitleText.tr,
        contentMessage: DialogueService.deleteGameDialogContentText.tr,
        yesMessage: DialogueService.deleteGameDialogYesText.tr,
        noMessage: DialogueService.deleteGameDialogNoText.tr,
        onYes: () {
          deleteGame(game, user);
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
          await leaveGame(game, user.id, user);
        },
        onNo: () {},
        context: context,
      );
    }
  }
}
