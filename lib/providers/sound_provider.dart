import 'dart:math';

import 'package:flutter/material.dart';
import 'package:assets_audio_player/assets_audio_player.dart';
import '../services/game_status_service.dart';

class SoundProvider with ChangeNotifier {
  late bool prefersAudio = true;

  Random random = Random();
  final AssetsAudioPlayer assetsAudioPlayer = AssetsAudioPlayer();

  static const AudioFocusStrategy audioFocusStrategy = AudioFocusStrategy.request(resumeAfterInterruption: true, resumeOthersPlayersAfterDone: true);
  static const HeadPhoneStrategy headPhoneStrategy = HeadPhoneStrategy.none;

  List<String> dieRollURLs = [];

  List<String> playerMoveURLs = [];

  List<String> playerKickURLs = [];

  List<String> playerHomeURLs = [];

  List<String> playerFinishURLs = [];

  List<String> playerJoinedURLs = [];

  List<String> playerLeftURLs = [];

  List<String> gameFinishURLs = [];

  List<String> newMessageReceivedPaths = ['assets/sounds/receive.mp3'];

  List<String> newMessageSentPaths = ['assets/sounds/send.mp3'];

  void setPrefersSound(bool value) {
    prefersAudio = value;
  }

  void playSound(String sound) {
    if (prefersAudio) {
      switch (sound) {
        case GameStatusService.playerRoll:
          playSpecificSound(dieRollURLs[random.nextInt(dieRollURLs.length)]);
          break;
        case GameStatusService.playerMove:
          playSpecificSound(playerMoveURLs[random.nextInt(playerMoveURLs.length)]);
          break;
        case GameStatusService.playerKick:
          playSpecificSound(playerKickURLs[random.nextInt(playerKickURLs.length)]);
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
        case GameStatusService.newMessageReceived:
          playSpecificSound(newMessageReceivedPaths[0]);
          break;
        case GameStatusService.newMessageSent:
          playSpecificSound(newMessageSentPaths[0]);
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
