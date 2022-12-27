import 'dart:math';

import 'package:flutter/material.dart';
import 'package:assets_audio_player/assets_audio_player.dart';
import '../services/game_status_service.dart';

class SoundProvider with ChangeNotifier {
  late bool prefersAudio = true;

  Random random = Random();
  final AssetsAudioPlayer assetsAudioPlayer = AssetsAudioPlayer();

  static const AudioFocusStrategy audioFocusStrategy = AudioFocusStrategy.request(
    resumeAfterInterruption: true,
    resumeOthersPlayersAfterDone: true,
  );
  static const HeadPhoneStrategy headPhoneStrategy = HeadPhoneStrategy.none;

  List<String> dieRollURLs = [
    'assets/sounds/dice.mp3',
  ];

  List<String> playerMoveURLs = [];

  List<String> playerKickMeURLs = [
    // temp
    'assets/sounds/player_finish.mp3',
  ];

  List<String> playerKickOtherURLs = [
    // temp
    'assets/sounds/player_finish.mp3',
  ];

  List<String> playerHomeURLs = [
    // temp
    'assets/sounds/player_finish.mp3',
  ];

  List<String> playerFinishURLs = [
    'assets/sounds/player_finish.mp3',
  ];

  List<String> playerJoinedURLs = [
    // temp
    'assets/sounds/player_finish.mp3',
  ];

  List<String> playerLeftURLs = [
    // temp
    'assets/sounds/player_finish.mp3',
  ];

  List<String> gameFinishURLs = [
    // temp
    'assets/sounds/player_finish.mp3',
  ];

  List<String> gameWonURLs = [
    // temp
    'assets/sounds/player_finish.mp3',
  ];

  List<String> gameLostURLs = [
    // temp
    'assets/sounds/player_finish.mp3',
  ];

  String newMessageReceivedPath = 'assets/sounds/receive.mp3';

  String newMessageSentPath = 'assets/sounds/send.mp3';

  void setPrefersSound(bool value) {
    prefersAudio = value;
  }

  void playSound(String sound) {
    if (prefersAudio) {
      print('Sound played: $sound');
      switch (sound) {
        case GameStatusService.playerRoll:
          playSpecificSound(dieRollURLs[random.nextInt(dieRollURLs.length)]);
          break;
        case GameStatusService.playerMove:
          playSpecificSound(playerMoveURLs[random.nextInt(playerMoveURLs.length)]);
          break;
        case GameStatusService.playerKickMe:
          playSpecificSound(playerKickMeURLs[random.nextInt(playerKickMeURLs.length)]);
          break;
        case GameStatusService.playerKickOther:
          playSpecificSound(playerKickOtherURLs[random.nextInt(playerKickOtherURLs.length)]);
          break;
        case GameStatusService.playerHome:
          playSpecificSound(playerHomeURLs[random.nextInt(playerHomeURLs.length)]);
          break;
        case GameStatusService.playerFinish:
          playSpecificSound(playerFinishURLs[random.nextInt(playerFinishURLs.length)]);
          break;
        case GameStatusService.playerJoined:
          playSpecificSound(playerJoinedURLs[random.nextInt(playerJoinedURLs.length)]);
          break;
        case GameStatusService.playerLeft:
          playSpecificSound(playerLeftURLs[random.nextInt(playerLeftURLs.length)]);
          break;
        case GameStatusService.gameFinish:
          playSpecificSound(gameFinishURLs[random.nextInt(gameFinishURLs.length)]);
          break;
        case GameStatusService.gameWon:
          playSpecificSound(gameWonURLs[random.nextInt(gameFinishURLs.length)]);
          break;
        case GameStatusService.gameLost:
          playSpecificSound(gameLostURLs[random.nextInt(gameFinishURLs.length)]);
          break;
        case GameStatusService.newMessageReceived:
          playSpecificSound(newMessageReceivedPath);
          break;
        case GameStatusService.newMessageSent:
          playSpecificSound(newMessageSentPath);
          break;
        default:
      }
    }
  }

  void playSpecificSound(String path) async {
    try {
      await assetsAudioPlayer.open(
        Audio(path),
        audioFocusStrategy: audioFocusStrategy,
        headPhoneStrategy: headPhoneStrategy,
      );
      assetsAudioPlayer.play();
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
