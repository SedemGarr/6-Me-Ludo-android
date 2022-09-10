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
    'https://firebasestorage.googleapis.com/v0/b/flutter-ludo.appspot.com/o/gifs%2Fk1.gif?alt=media&token=fbd6d8b5-1fe3-49a0-9838-7a37f0595b46',
    'https://firebasestorage.googleapis.com/v0/b/flutter-ludo.appspot.com/o/gifs%2Fk2.gif?alt=media&token=914af95e-3ca8-47e4-b2f5-9c324c76aa8d',
    'https://firebasestorage.googleapis.com/v0/b/flutter-ludo.appspot.com/o/gifs%2Fk3.gif?alt=media&token=1ea61361-2b80-4a89-ad14-3343d6f441a4',
    'https://firebasestorage.googleapis.com/v0/b/flutter-ludo.appspot.com/o/gifs%2Fk4.gif?alt=media&token=1199ae48-338e-4cd4-a6d4-7fe046c03d04',
  ];
  static const List<String> playerHomeGifList = [
    'https://firebasestorage.googleapis.com/v0/b/flutter-ludo.appspot.com/o/gifs%2Fph1.gif?alt=media&token=9161e560-c2af-408c-8c19-7ca100534770',
    'https://firebasestorage.googleapis.com/v0/b/flutter-ludo.appspot.com/o/gifs%2Fph2.gif?alt=media&token=4a3775b4-446c-4067-9e95-0c4b5de78877',
    'https://firebasestorage.googleapis.com/v0/b/flutter-ludo.appspot.com/o/gifs%2Fpj3.gif?alt=media&token=5d3e4744-9a47-47cd-8cc7-9ade94eebb9f',
    'https://firebasestorage.googleapis.com/v0/b/flutter-ludo.appspot.com/o/gifs%2Fph4.gif?alt=media&token=508067a0-985f-4a3f-aa8f-9358340084de',
    'https://firebasestorage.googleapis.com/v0/b/flutter-ludo.appspot.com/o/gifs%2Fph5.gif?alt=media&token=accafc8c-84d9-4ebb-85b6-c23496458bc7',
  ];
  static const List<String> playerFinishGifList = [
    'https://firebasestorage.googleapis.com/v0/b/flutter-ludo.appspot.com/o/gifs%2Fph1.gif?alt=media&token=9161e560-c2af-408c-8c19-7ca100534770',
    'https://firebasestorage.googleapis.com/v0/b/flutter-ludo.appspot.com/o/gifs%2Fph2.gif?alt=media&token=4a3775b4-446c-4067-9e95-0c4b5de78877',
    'https://firebasestorage.googleapis.com/v0/b/flutter-ludo.appspot.com/o/gifs%2Fpj3.gif?alt=media&token=5d3e4744-9a47-47cd-8cc7-9ade94eebb9f',
    'https://firebasestorage.googleapis.com/v0/b/flutter-ludo.appspot.com/o/gifs%2Fph4.gif?alt=media&token=508067a0-985f-4a3f-aa8f-9358340084de',
    'https://firebasestorage.googleapis.com/v0/b/flutter-ludo.appspot.com/o/gifs%2Fph5.gif?alt=media&token=accafc8c-84d9-4ebb-85b6-c23496458bc7',
  ];
  static const List<String> playerJoinedGifList = [
    'https://firebasestorage.googleapis.com/v0/b/flutter-ludo.appspot.com/o/gifs%2Fpj1.gif?alt=media&token=5158ac9c-cc23-4a1e-a2ff-8084954ec4be',
    'https://firebasestorage.googleapis.com/v0/b/flutter-ludo.appspot.com/o/gifs%2Fpj2.gif?alt=media&token=c73c58ce-f8a1-46ed-b7a5-4efd1ed2f7ec',
    'https://firebasestorage.googleapis.com/v0/b/flutter-ludo.appspot.com/o/gifs%2Fpj3.gif?alt=media&token=5d3e4744-9a47-47cd-8cc7-9ade94eebb9f',
    'https://firebasestorage.googleapis.com/v0/b/flutter-ludo.appspot.com/o/gifs%2Fpj4.gif?alt=media&token=3c33fa6f-7210-4b5a-9d75-eac53eb49c3a',
    'https://firebasestorage.googleapis.com/v0/b/flutter-ludo.appspot.com/o/gifs%2Fpj5.gif?alt=media&token=c626e02d-3708-4ce4-a8bf-233f6de6bd2b',
  ];
  static const List<String> playerLeftList = [
    'https://firebasestorage.googleapis.com/v0/b/flutter-ludo.appspot.com/o/gifs%2Fpl1.gif?alt=media&token=81012c10-babd-4660-9df8-fdbf07fc6875',
    'https://firebasestorage.googleapis.com/v0/b/flutter-ludo.appspot.com/o/gifs%2Fpl2.gif?alt=media&token=7c464cd3-d4fa-419f-a6b1-9cf0cbb800ab',
    'https://firebasestorage.googleapis.com/v0/b/flutter-ludo.appspot.com/o/gifs%2Fpl3.gif?alt=media&token=cc6f7064-7551-440e-a695-a73463c29587',
    'https://firebasestorage.googleapis.com/v0/b/flutter-ludo.appspot.com/o/gifs%2Fpl4.gif?alt=media&token=ab531e13-f91a-4634-98b9-a5d6f6553ee1',
    'https://firebasestorage.googleapis.com/v0/b/flutter-ludo.appspot.com/o/gifs%2Fpl5.gif?alt=media&token=f624d283-5711-4622-a22f-fbefbcd7f2cd',
    'https://firebasestorage.googleapis.com/v0/b/flutter-ludo.appspot.com/o/gifs%2Fpl6.gif?alt=media&token=c9049187-485d-44cc-8af5-dd18f6434fc2',
  ];
  static const List<String> gameWaitingList = [
    'https://firebasestorage.googleapis.com/v0/b/flutter-ludo.appspot.com/o/gifs%2Fgw1.gif?alt=media&token=51455d4a-58a4-4abd-94a8-9204757730b6',
    'https://firebasestorage.googleapis.com/v0/b/flutter-ludo.appspot.com/o/gifs%2Fgw2.gif?alt=media&token=27858309-28ff-4f30-b2d4-7e080a3599d2',
    'https://firebasestorage.googleapis.com/v0/b/flutter-ludo.appspot.com/o/gifs%2Fgw3.gif?alt=media&token=b9fd651e-175f-420f-b31b-92c4a1d25bb7',
    'https://firebasestorage.googleapis.com/v0/b/flutter-ludo.appspot.com/o/gifs%2Fgw4.gif?alt=media&token=d3206fa9-d760-42fe-a343-180a5c54b2e5',
    'https://firebasestorage.googleapis.com/v0/b/flutter-ludo.appspot.com/o/gifs%2Fgw5.gif?alt=media&token=548a83fa-5c64-4d97-be4d-7388b341f3f2',
  ];
  static const List<String> gameStartList = [
    'https://firebasestorage.googleapis.com/v0/b/flutter-ludo.appspot.com/o/gifs%2Fgs7.gif?alt=media&token=7bf556eb-7a3a-4fd0-92a5-480e6738f00e',
    'https://firebasestorage.googleapis.com/v0/b/flutter-ludo.appspot.com/o/gifs%2Fgs6.gif?alt=media&token=285af4d3-f980-4422-979f-3c5e412a6203',
    'https://firebasestorage.googleapis.com/v0/b/flutter-ludo.appspot.com/o/gifs%2Fgs3.gif?alt=media&token=3071731a-b755-43a8-a1e2-bce2a08394df',
    'https://firebasestorage.googleapis.com/v0/b/flutter-ludo.appspot.com/o/gifs%2Fgs2.gif?alt=media&token=b24e3948-1446-4b35-8e39-eb34bd14cb66',
    'https://firebasestorage.googleapis.com/v0/b/flutter-ludo.appspot.com/o/gifs%2Fgs1.gif?alt=media&token=69561dd3-0a87-4056-957a-3bc9069b449e',
    'https://firebasestorage.googleapis.com/v0/b/flutter-ludo.appspot.com/o/gifs%2Fgs5.gif?alt=media&token=d55fd173-857b-46f9-afff-2f2f211d208f',
    'https://firebasestorage.googleapis.com/v0/b/flutter-ludo.appspot.com/o/gifs%2Fgs4.gif?alt=media&token=df1c38ff-0aa8-45e1-9668-1d9de6231621',
  ];
  static const List<String> gameFinishList = [
    'https://firebasestorage.googleapis.com/v0/b/flutter-ludo.appspot.com/o/gifs%2Fgf4.gif?alt=media&token=32a4f4e1-7396-4404-8fa5-0ddcdb57aef0',
    'https://firebasestorage.googleapis.com/v0/b/flutter-ludo.appspot.com/o/gifs%2Fgf1.gif?alt=media&token=5dc40277-5fd2-4717-a759-85716c5b8a1c',
    'https://firebasestorage.googleapis.com/v0/b/flutter-ludo.appspot.com/o/gifs%2Fgf2.gif?alt=media&token=8e1a7b89-2a37-476f-b35d-55d7eaf271ec',
    'https://firebasestorage.googleapis.com/v0/b/flutter-ludo.appspot.com/o/gifs%2Fgf3.gif?alt=media&token=d1f8f879-70c5-4c77-a976-8662f276a447',
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
