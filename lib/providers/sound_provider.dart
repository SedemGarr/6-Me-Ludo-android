import 'package:flutter/material.dart';
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:six_me_ludo_android/providers/game_provider.dart';
import '../models/game.dart';
import '../services/game_status_service.dart';

class SoundProvider with ChangeNotifier {
  late bool prefersAudio = true;
  late bool prefersMusic = true;

  // players
  final AssetsAudioPlayer gameLoopPlayer = AssetsAudioPlayer();
  final AssetsAudioPlayer dieRollPlayer = AssetsAudioPlayer();
  final AssetsAudioPlayer playerMovePlayer = AssetsAudioPlayer();
  final AssetsAudioPlayer playerKickMePlayer = AssetsAudioPlayer();
  final AssetsAudioPlayer playerKickOtherPlayer = AssetsAudioPlayer();
  final AssetsAudioPlayer playerHomePlayer = AssetsAudioPlayer();
  final AssetsAudioPlayer playerFinishPlayer = AssetsAudioPlayer();
  final AssetsAudioPlayer playerJoinedPlayer = AssetsAudioPlayer();
  final AssetsAudioPlayer playerLeftPlayer = AssetsAudioPlayer();
  final AssetsAudioPlayer gameFinishPlayer = AssetsAudioPlayer();
  final AssetsAudioPlayer gameWonPlayer = AssetsAudioPlayer();
  final AssetsAudioPlayer gameLostPlayer = AssetsAudioPlayer();
  final AssetsAudioPlayer newMessageReceivedPlayer = AssetsAudioPlayer();
  final AssetsAudioPlayer newMessageSentPlayer = AssetsAudioPlayer();

  static const AudioFocusStrategy gameSoundsAudioFocusStrategy = AudioFocusStrategy.request(
    resumeAfterInterruption: true,
    resumeOthersPlayersAfterDone: true,
  );

  static const AudioFocusStrategy gameLoopAudioFocusStrategy = AudioFocusStrategy.request(
    resumeAfterInterruption: true,
    resumeOthersPlayersAfterDone: false,
  );

  static const HeadPhoneStrategy headPhoneStrategy = HeadPhoneStrategy.none;

  String dieRollPath = 'assets/sounds/die_roll.mp3';

  String playerMovePath = '';

  String playerKickMePath = 'assets/sounds/player_kick_me.mp3';

  String playerKickOtherPath = 'assets/sounds/player_kick_other.mp3';

  String playerHomePath = 'assets/sounds/player_home.mp3';

  String playerFinishPath = 'assets/sounds/player_finish.mp3';

  String playerJoinedPath = 'assets/sounds/player_join.mp3';

  String playerLeftPath = 'assets/sounds/player_left.mp3';

  String gameFinishPath = 'assets/sounds/game_finish.mp3';

  String gameWonPath = 'assets/sounds/game_won.mp3';

  String gameLostPath = 'assets/sounds/game_loss.mp3';

  String newMessageReceivedPath = 'assets/sounds/message_receive.mp3';

  String newMessageSentPath = 'assets/sounds/message_send.mp3';

  String gameLoopPath = 'assets/sounds/game_loop.mp3';

  void setPrefersSound(bool value) {
    prefersAudio = value;
  }

  void setPrefersMusic(bool value) {
    prefersMusic = value;
  }

  void playSound(String sound) async {
    if (prefersAudio) {
      try {
        switch (sound) {
          case GameStatusService.playerRoll:
            await dieRollPlayer.open(
              Audio(dieRollPath),
              audioFocusStrategy: gameSoundsAudioFocusStrategy,
              headPhoneStrategy: headPhoneStrategy,
            );
            break;
          case GameStatusService.playerMove:
            await playerMovePlayer.open(
              Audio(playerMovePath),
              audioFocusStrategy: gameSoundsAudioFocusStrategy,
              headPhoneStrategy: headPhoneStrategy,
            );
            break;
          case GameStatusService.playerKickMe:
            await playerKickMePlayer.open(
              Audio(playerKickMePath),
              audioFocusStrategy: gameSoundsAudioFocusStrategy,
              headPhoneStrategy: headPhoneStrategy,
            );
            break;
          case GameStatusService.playerKickOther:
            await playerKickOtherPlayer.open(
              Audio(playerKickOtherPath),
              audioFocusStrategy: gameSoundsAudioFocusStrategy,
              headPhoneStrategy: headPhoneStrategy,
            );
            break;
          case GameStatusService.playerHome:
            await playerHomePlayer.open(
              Audio(playerHomePath),
              audioFocusStrategy: gameSoundsAudioFocusStrategy,
              headPhoneStrategy: headPhoneStrategy,
            );
            break;
          case GameStatusService.playerFinish:
            await playerFinishPlayer.open(
              Audio(playerFinishPath),
              audioFocusStrategy: gameSoundsAudioFocusStrategy,
              headPhoneStrategy: headPhoneStrategy,
            );
            break;
          case GameStatusService.playerJoined:
            await playerJoinedPlayer.open(
              Audio(playerJoinedPath),
              audioFocusStrategy: gameSoundsAudioFocusStrategy,
              headPhoneStrategy: headPhoneStrategy,
            );
            break;
          case GameStatusService.playerLeft:
            await playerLeftPlayer.open(
              Audio(playerLeftPath),
              audioFocusStrategy: gameSoundsAudioFocusStrategy,
              headPhoneStrategy: headPhoneStrategy,
            );
            break;
          case GameStatusService.gameFinish:
            await gameFinishPlayer.open(
              Audio(gameFinishPath),
              audioFocusStrategy: gameSoundsAudioFocusStrategy,
              headPhoneStrategy: headPhoneStrategy,
            );
            break;
          case GameStatusService.gameWon:
            await gameWonPlayer.open(
              Audio(gameWonPath),
              audioFocusStrategy: gameSoundsAudioFocusStrategy,
              headPhoneStrategy: headPhoneStrategy,
            );
            break;
          case GameStatusService.gameLost:
            await gameLostPlayer.open(
              Audio(gameLostPath),
              audioFocusStrategy: gameSoundsAudioFocusStrategy,
              headPhoneStrategy: headPhoneStrategy,
            );
            break;
          case GameStatusService.newMessageReceived:
            await newMessageReceivedPlayer.open(
              Audio(newMessageReceivedPath),
              audioFocusStrategy: gameSoundsAudioFocusStrategy,
              headPhoneStrategy: headPhoneStrategy,
            );
            break;
          case GameStatusService.newMessageSent:
            await newMessageSentPlayer.open(
              Audio(newMessageSentPath),
              audioFocusStrategy: gameSoundsAudioFocusStrategy,
              headPhoneStrategy: headPhoneStrategy,
            );
            break;
          default:
        }
      } catch (e) {
        debugPrint(e.toString());
      }
    }
  }

  void startGameLoopSound() async {
    if (prefersMusic) {
      try {
        await gameLoopPlayer.open(
          Audio(gameLoopPath),
          audioFocusStrategy: gameLoopAudioFocusStrategy,
          headPhoneStrategy: headPhoneStrategy,
          loopMode: LoopMode.single,
        );
      } catch (e) {
        debugPrint(e.toString());
      }
    }
  }

  void pauseGameLoopSound() async {
    if (prefersMusic) {
      try {
        gameLoopPlayer.pause();
      } catch (e) {
        debugPrint(e.toString());
      }
    }
  }

  void resumeGameLoopSound() {
    if (prefersMusic) {
      try {
        GameProvider gameProvider = Get.context!.read<GameProvider>();
        Game? game = gameProvider.currentGame;

        if (game != null) {
          if (gameProvider.shouldStartOrResumeGameLoopSound()) {
            gameLoopPlayer.play();
          }
        }
      } catch (e) {
        debugPrint(e.toString());
      }
    }
  }

  void endGameLoopSound() {
    if (prefersMusic) {
      try {
        gameLoopPlayer.stop();
      } catch (e) {
        debugPrint(e.toString());
      }
    }
  }

  void handleSoundLifecycleChanges(bool shouldPause) {
    if (shouldPause) {
      pauseGameLoopSound();
    } else {
      resumeGameLoopSound();
    }
  }
}
