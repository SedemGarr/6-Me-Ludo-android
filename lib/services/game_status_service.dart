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
    // 'https://firebasestorage.googleapis.com/v0/b/flutter-ludo-38529.appspot.com/o/gifs%2Fk1.gif?alt=media&token=68575149-4bbf-4351-b4d4-e21931d14c39',
    // 'https://firebasestorage.googleapis.com/v0/b/flutter-ludo-38529.appspot.com/o/gifs%2Fk2.gif?alt=media&token=586700c2-d562-412a-800e-9d74a4579bfd',
    // 'https://firebasestorage.googleapis.com/v0/b/flutter-ludo-38529.appspot.com/o/gifs%2Fk3.gif?alt=media&token=87147c46-6d0d-4802-95d0-8693746cc5e1',
    // 'https://firebasestorage.googleapis.com/v0/b/flutter-ludo-38529.appspot.com/o/gifs%2Fk4.gif?alt=media&token=f6d7b3d9-5bd3-4e7e-b894-b7c6671c1b08',

    'assets/gifs/k1.gif',
    'assets/gifs/k2.gif',
    'assets/gifs/k3.gif',
    'assets/gifs/k4.gif',
  ];
  static const List<String> playerHomeGifList = [
    // 'https://firebasestorage.googleapis.com/v0/b/flutter-ludo-38529.appspot.com/o/gifs%2Fph1.gif?alt=media&token=e8da325c-9cd4-40ed-86e5-8865a4e41cdc',
    // 'https://firebasestorage.googleapis.com/v0/b/flutter-ludo-38529.appspot.com/o/gifs%2Fph2.gif?alt=media&token=77c6b440-fd4a-4d62-a607-b51fc34eabc4',
    // 'https://firebasestorage.googleapis.com/v0/b/flutter-ludo-38529.appspot.com/o/gifs%2Fph3.gif?alt=media&token=a50739d8-9374-47cf-ad0a-fe658196320e',
    // 'https://firebasestorage.googleapis.com/v0/b/flutter-ludo-38529.appspot.com/o/gifs%2Fph4.gif?alt=media&token=76ab0ef2-2f67-43e5-95c0-dd3ab07af705',
    // 'https://firebasestorage.googleapis.com/v0/b/flutter-ludo-38529.appspot.com/o/gifs%2Fph5.gif?alt=media&token=4fa763d4-2ce8-40a7-89b5-814ab165dc09',

    'assets/gifs/ph1.gif',
    'assets/gifs/ph2.gif',
    'assets/gifs/ph3.gif',
    'assets/gifs/ph4.gif',
    'assets/gifs/ph5.gif',
  ];
  static const List<String> playerFinishGifList = [
    // 'https://firebasestorage.googleapis.com/v0/b/flutter-ludo-38529.appspot.com/o/gifs%2Fpf1.gif?alt=media&token=0a1a3122-4a58-4479-b680-eace53511e93',
    // 'https://firebasestorage.googleapis.com/v0/b/flutter-ludo-38529.appspot.com/o/gifs%2Fpf2.gif?alt=media&token=c6136b55-834b-4e1b-ac3b-32df3df498c0',
    // 'https://firebasestorage.googleapis.com/v0/b/flutter-ludo-38529.appspot.com/o/gifs%2Fpf3.gif?alt=media&token=ba7aaca1-92e6-4eb0-b9c0-7785032ad46b',
    // 'https://firebasestorage.googleapis.com/v0/b/flutter-ludo-38529.appspot.com/o/gifs%2Fpf4.gif?alt=media&token=8c7a4e88-e225-471b-8905-3f1f7c496d38',

    'assets/gifs/pf1.gif',
    'assets/gifs/pf2.gif',
    'assets/gifs/pf3.gif',
    'assets/gifs/pf4.gif',
  ];
  static const List<String> playerJoinedGifList = [
    // 'https://firebasestorage.googleapis.com/v0/b/flutter-ludo-38529.appspot.com/o/gifs%2Fpj1.gif?alt=media&token=a17d548f-42ae-49de-8942-e2bffc19e9e6',
    // 'https://firebasestorage.googleapis.com/v0/b/flutter-ludo-38529.appspot.com/o/gifs%2Fpj2.gif?alt=media&token=94e2a944-9235-4bb7-bed6-40ca2a379321',
    // 'https://firebasestorage.googleapis.com/v0/b/flutter-ludo-38529.appspot.com/o/gifs%2Fpj3.gif?alt=media&token=5869330c-e759-4e2b-94c3-f17717fb9aa9',
    // 'https://firebasestorage.googleapis.com/v0/b/flutter-ludo-38529.appspot.com/o/gifs%2Fpj4.gif?alt=media&token=7d8c24ff-8150-4e60-b19e-c1d7a04c436e',
    // 'https://firebasestorage.googleapis.com/v0/b/flutter-ludo-38529.appspot.com/o/gifs%2Fpj5.gif?alt=media&token=cca6d900-7b58-4c66-bdbd-9b775ff15097',

    'assets/gifs/pj1.gif',
    'assets/gifs/pj2.gif',
    'assets/gifs/pj3.gif',
    'assets/gifs/pj4.gif',
    'assets/gifs/pj5.gif',
  ];
  static const List<String> playerLeftList = [
    // 'https://firebasestorage.googleapis.com/v0/b/flutter-ludo-38529.appspot.com/o/gifs%2Fpl1.gif?alt=media&token=2f3330bd-8376-4343-9e87-6d0c0af1e7b6',
    // 'https://firebasestorage.googleapis.com/v0/b/flutter-ludo-38529.appspot.com/o/gifs%2Fpl2.gif?alt=media&token=30db3ba6-1b77-4744-8576-bc1bd18322f6',
    // 'https://firebasestorage.googleapis.com/v0/b/flutter-ludo-38529.appspot.com/o/gifs%2Fpl3.gif?alt=media&token=2e9fd746-8b32-435a-9e53-f1ead590df29',
    // 'https://firebasestorage.googleapis.com/v0/b/flutter-ludo-38529.appspot.com/o/gifs%2Fpl4.gif?alt=media&token=3138f99a-6371-46c8-af5d-040ccdacde00',
    // 'https://firebasestorage.googleapis.com/v0/b/flutter-ludo-38529.appspot.com/o/gifs%2Fpl5.gif?alt=media&token=649b07b1-4bbe-438c-be38-83cd56add3a6',
    // 'https://firebasestorage.googleapis.com/v0/b/flutter-ludo-38529.appspot.com/o/gifs%2Fpl6.gif?alt=media&token=4b82ad17-0f2d-4198-931a-1a289ec87c9a',

    'assets/gifs/pl1.gif',
    'assets/gifs/pl2.gif',
    'assets/gifs/pl3.gif',
    'assets/gifs/pl4.gif',
    'assets/gifs/pl5.gif',
    'assets/gifs/pl6.gif',
  ];
  static const List<String> gameWaitingList = [
    // 'https://firebasestorage.googleapis.com/v0/b/flutter-ludo-38529.appspot.com/o/gifs%2Fgw1.gif?alt=media&token=a7969b70-c7e9-4eb8-a6f2-5c01ab965931',
    // 'https://firebasestorage.googleapis.com/v0/b/flutter-ludo-38529.appspot.com/o/gifs%2Fgw2.gif?alt=media&token=2eba4b0b-d8eb-47ba-9437-2775e49fa065',
    // 'https://firebasestorage.googleapis.com/v0/b/flutter-ludo-38529.appspot.com/o/gifs%2Fgw3.gif?alt=media&token=6306e6c2-4cf2-4ca1-912b-5883145cf6f4',
    // 'https://firebasestorage.googleapis.com/v0/b/flutter-ludo-38529.appspot.com/o/gifs%2Fgw4.gif?alt=media&token=62a58ef6-0f52-4228-8fb8-b26f7cd0acfa',
    // 'https://firebasestorage.googleapis.com/v0/b/flutter-ludo-38529.appspot.com/o/gifs%2Fgw5.gif?alt=media&token=732bed57-c165-4bd5-8a61-98b974f6b013',

    'assets/gifs/gw1.gif',
    'assets/gifs/gw2.gif',
    'assets/gifs/gw3.gif',
    'assets/gifs/gw4.gif',
    'assets/gifs/gw5.gif',
  ];
  static const List<String> gameStartList = [
    // 'https://firebasestorage.googleapis.com/v0/b/flutter-ludo-38529.appspot.com/o/gifs%2Fgs1.gif?alt=media&token=127a3798-d5e8-4221-acf6-9dd5078a3f1b',
    // 'https://firebasestorage.googleapis.com/v0/b/flutter-ludo-38529.appspot.com/o/gifs%2Fgs2.gif?alt=media&token=4c666052-3450-4edc-a30f-e389d35a6457',
    // 'https://firebasestorage.googleapis.com/v0/b/flutter-ludo-38529.appspot.com/o/gifs%2Fgs3.gif?alt=media&token=362f1ede-c6e4-4121-96fc-4d7523393fe2',
    // 'https://firebasestorage.googleapis.com/v0/b/flutter-ludo-38529.appspot.com/o/gifs%2Fgs5.gif?alt=media&token=8d2ce045-6150-4102-b8a7-e5b3fa5269d0',
    // 'https://firebasestorage.googleapis.com/v0/b/flutter-ludo-38529.appspot.com/o/gifs%2Fgs6.gif?alt=media&token=23412d2f-4f88-41db-b57c-01dbe85d38f6',
    // 'https://firebasestorage.googleapis.com/v0/b/flutter-ludo-38529.appspot.com/o/gifs%2Fgs7.gif?alt=media&token=c7d81a93-5a62-467e-b9d6-3336a955cf2f',

    'assets/gifs/gs1.gif',
    'assets/gifs/gs2.gif',
    'assets/gifs/gs3.gif',
    'assets/gifs/gs5.gif',
    'assets/gifs/gs6.gif',
    'assets/gifs/gs7.gif',
  ];
  static const List<String> gameFinishList = [
    // 'https://firebasestorage.googleapis.com/v0/b/flutter-ludo-38529.appspot.com/o/gifs%2Fgf1.gif?alt=media&token=b21694a8-ce98-4bc4-922c-1e8357024a81',
    // 'https://firebasestorage.googleapis.com/v0/b/flutter-ludo-38529.appspot.com/o/gifs%2Fgf2.gif?alt=media&token=787be0b1-e602-42bc-b6e0-0f736c4d6be1',
    // 'https://firebasestorage.googleapis.com/v0/b/flutter-ludo-38529.appspot.com/o/gifs%2Fgf3.gif?alt=media&token=e473809a-d9f9-468f-a607-80a33335951f',
    // 'https://firebasestorage.googleapis.com/v0/b/flutter-ludo-38529.appspot.com/o/gifs%2Fgf4.gif?alt=media&token=092ec96e-cddd-4f18-8257-1b93d3f242c7',

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
