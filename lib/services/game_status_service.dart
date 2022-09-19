import 'dart:math';

import '../models/game.dart';

class GameStatusService {
  static const String playerRoll = 'playerRoll';
  static const String playerMove = 'playerMove';
  static const String playerKick = 'playerKick';
  static const String playerHome = 'playerHome';
  static const String playerFinish = 'playerFinish';
  static const String playerJoined = 'playerJoined';
  static const String playerLeft = 'playerLeft';
  static const String gameWaiting = 'gameWaiting';
  static const String gameStart = 'gameStart';
  static const String gameFinish = 'gameFinish';
  static const String newMessageReceived = 'newMessageReceived';
  static const String newMessageSent = 'newMessageSent';

  static const String blank = '';

  static const List<String> playerKickGifList = [
    'assets/gifs/k1.gif',
    'assets/gifs/k2.gif',
    'assets/gifs/k3.gif',
    'assets/gifs/k4.gif',
  ];
  static const List<String> playerHomeGifList = [
    'assets/gifs/ph1.gif',
    'assets/gifs/ph2.gif',
    'assets/gifs/ph3.gif',
    'assets/gifs/ph4.gif',
    'assets/gifs/ph5.gif',
  ];
  static const List<String> playerFinishGifList = [
    'assets/gifs/pf1.gif',
    'assets/gifs/pf2.gif',
    'assets/gifs/pf3.gif',
    'assets/gifs/pf4.gif',
  ];
  static const List<String> playerJoinedGifList = [
    'assets/gifs/pj1.gif',
    'assets/gifs/pj2.gif',
    'assets/gifs/pj3.gif',
    'assets/gifs/pj4.gif',
    'assets/gifs/pj5.gif',
  ];
  static const List<String> playerLeftList = [
    'assets/gifs/pl1.gif',
    'assets/gifs/pl2.gif',
    'assets/gifs/pl3.gif',
    'assets/gifs/pl4.gif',
    'assets/gifs/pl5.gif',
    'assets/gifs/pl6.gif',
  ];
  static const List<String> gameWaitingList = [
    'assets/gifs/gw1.gif',
    'assets/gifs/gw2.gif',
    'assets/gifs/gw3.gif',
    'assets/gifs/gw4.gif',
    'assets/gifs/gw5.gif',
  ];
  static const List<String> gameStartList = [
    'assets/gifs/gs1.gif',
    'assets/gifs/gs2.gif',
    'assets/gifs/gs3.gif',
    'assets/gifs/gs5.gif',
    'assets/gifs/gs6.gif',
    'assets/gifs/gs7.gif',
  ];
  static const List<String> gameFinishList = [
    'assets/gifs/gf1.gif',
    'assets/gifs/gf2.gif',
    'assets/gifs/gf3.gif',
    'assets/gifs/gf4.gif',
  ];

  static String getPlayerKickGif() {
    return playerKickGifList[Random().nextInt(playerKickGifList.length)];
  }

  static String getPlayerHomeGif() {
    return playerHomeGifList[Random().nextInt(playerHomeGifList.length)];
  }

  static String getPlayerFinishGif() {
    return playerFinishGifList[Random().nextInt(playerFinishGifList.length)];
  }

  static String getPlayerJoinedGif() {
    return playerJoinedGifList[Random().nextInt(playerJoinedGifList.length)];
  }

  static String getPlayerLeftGif() {
    return playerLeftList[Random().nextInt(playerLeftList.length)];
  }

  static String getGameWaitingGif() {
    return gameWaitingList[Random().nextInt(gameWaitingList.length)];
  }

  static String getGameStartGif() {
    return gameStartList[Random().nextInt(gameStartList.length)];
  }

  static String getGameFinishGif() {
    return gameFinishList[Random().nextInt(gameFinishList.length)];
  }

  static String getGameCommentary(Game game) {
    return '';
  }
}
