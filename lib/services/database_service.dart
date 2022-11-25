import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:six_me_ludo_android/models/game.dart';
import 'package:six_me_ludo_android/providers/game_provider.dart';
import 'package:six_me_ludo_android/services/translations/dialogue_service.dart';
import 'package:six_me_ludo_android/services/user_state_service.dart';
import 'package:six_me_ludo_android/utils/utils.dart';
import 'package:uuid/uuid.dart';

import '../constants/database_constants.dart';
import '../models/message.dart';
import '../models/player.dart';
import '../models/reaction.dart';
import '../models/thread.dart';
import '../models/user.dart';
import '../models/version.dart';
import '../providers/dynamic_link_provider.dart';
import 'game_status_service.dart';

class DatabaseService {
  static Future<AppVersion?> getAppVersion() async {
    try {
      return AppVersion.fromJson(
          (Map<String, dynamic>.from(jsonDecode(jsonEncode((await FirebaseDatabase.instance.ref(RealTimeDatabaseConstants.appVersionReference).get()).value)))));
    } catch (e) {
      return null;
    }

    // try {
    //   return AppVersion.fromJson((await FirebaseFirestore.instance.collection(FirestoreConstants.appDataCollection).doc(FirestoreConstants.versionDocument).get()).data()!);
    // } catch (e) {
    //   return null;
    // }
  }

  // users

  static Future<Users?> getUser(String id) async {
    try {
      return Users.fromJson((await FirebaseFirestore.instance.collection(FirestoreConstants.userCollection).doc(id).get()).data()!);
    } catch (e) {
      return null;
    }
  }

  static Stream<Users> getUserStream(String id) {
    return FirebaseFirestore.instance.collection(FirestoreConstants.userCollection).doc(id).snapshots().map((snapshot) => Users.fromJson(snapshot.data()!));
  }

  static Future<Users?> createUser(User user, bool isAnon, String appVersion, int buildNumber) async {
    try {
      // check if user already exits in db
      Users? newUser;

      if (isAnon) {
        newUser = await Users.getDefaultUser(user.uid, user.email ?? '', isAnon, appVersion, buildNumber);
      } else {
        Users? tempUser = await getUser(user.uid);
        if (tempUser == null) {
          newUser = await Users.getDefaultUser(user.uid, user.email!, isAnon, appVersion, buildNumber);
        } else {
          newUser = tempUser;
        }
      }

      UserStateUpdateService.updateUser(newUser, true);
      return newUser;
    } catch (e) {
      Utils.showToast(DialogueService.genericErrorText.tr);
      debugPrint(e.toString());
      return null;
    }
  }

  static Future<void> deleteUserData(Users user) async {
    // delete all games

    List<Game> games = await getOngoingGames(user.id);

    for (var i = 0; i < games.length; i++) {
      await deleteGame(games[i].id, user);
    }

    // delete user document
    deleteUserDocument(user);
  }

  static Future<void> deleteUserDocument(Users user) async {
    await FirebaseFirestore.instance.collection(FirestoreConstants.userCollection).doc(user.id).delete();
  }

  static Future<void> updateUserData(Users user) async {
    try {
      await FirebaseFirestore.instance.collection(FirestoreConstants.userCollection).doc(user.id).set(user.toJson(), SetOptions(merge: true));
    } catch (e) {
      Utils.showToast(DialogueService.genericErrorText.tr);
      debugPrint(e.toString());
    }
  }

  static Future<void> updateUserCouldKick(String id, int reputationValue) async {
    try {
      await FirebaseFirestore.instance.collection(FirestoreConstants.userCollection).doc(id).update({'reputationValue': reputationValue});
    } catch (e) {
      Utils.showToast(DialogueService.genericErrorText.tr);
      debugPrint(e.toString());
    }
  }

  static Future<void> updateUserKicked(String id, int reputationValue) async {
    try {
      await FirebaseFirestore.instance.collection(FirestoreConstants.userCollection).doc(id).update({'reputationValue': reputationValue});
    } catch (e) {
      Utils.showToast(DialogueService.genericErrorText.tr);
      debugPrint(e.toString());
    }
  }

  // games
  static Stream<List<Game>> getOngoingGamesStream(String id) {
    return FirebaseFirestore.instance.collection(FirestoreConstants.gamesCollection).where('playerIds', arrayContains: id).snapshots().map((snapShot) => snapShot.docs
        .map((document) => Game.fromJson(document.data()))
        .toList()
        .where((element) => !element.players[element.players.indexWhere((element) => element.id == id)].hasLeft && !(element.kickedPlayers.contains(id)))
        .toList());
  }

  static Stream<Game> getCurrentGameStream(String gameId) {
    return FirebaseDatabase.instance
        .ref('${RealTimeDatabaseConstants.gamesReference}/$gameId')
        .onValue
        .map((event) => Game.fromJson(Map<String, dynamic>.from(jsonDecode(jsonEncode(event.snapshot.value)))));
  }

  static Stream<Thread> getCurrentThreadStream(String gameId) {
    return FirebaseFirestore.instance.collection(FirestoreConstants.threadCollection).doc(gameId).snapshots().map((snapshot) => Thread.fromJson(snapshot.data()!));
  }

  static Future<List<Game>> getOngoingGames(String id) async {
    List<Game> games = [];

    try {
      QuerySnapshot<Map<String, dynamic>> res = await FirebaseFirestore.instance.collection(FirestoreConstants.gamesCollection).where('playerIds', arrayContains: id).get();

      for (var element in res.docs) {
        Game game = Game.fromJson(element.data());

        if (!game.kickedPlayers.contains(id) && !game.players[game.playerIds.indexWhere((element) => element == id)].hasLeft) {
          games.add(game);
        }
      }
    } catch (e) {
      debugPrint(e.toString());
    }

    return games;
  }

  static Future<Game?> getGame(String id) async {
    try {
      return Game.fromJson(
          (Map<String, dynamic>.from(jsonDecode(jsonEncode((await FirebaseDatabase.instance.ref('${RealTimeDatabaseConstants.gamesReference}/$id').get()).value)))));
    } catch (e) {
      return null;
    }
  }

  static Future<Thread?> getThread(String id) async {
    try {
      return Thread.fromJson((await FirebaseFirestore.instance.collection(FirestoreConstants.threadCollection).doc(id).get()).data()!);
    } catch (e) {
      return null;
    }
  }

  static Future<Game> createGame(Users user, Uuid uuid, bool isOffline, BuildContext context) async {
    DynamicLinkProvider dynamicLinkProvider = context.read<DynamicLinkProvider>();
    DatabaseReference gameRef = FirebaseDatabase.instance.ref(RealTimeDatabaseConstants.gamesReference);

    Game game = Game.getDefaultGame(user, gameRef.push().key!, isOffline);

    if (user.settings.prefersAddAI) {
      game = Game.autoFillWithAIPlayers(game, user, uuid);
      game.maxPlayers = 4;
    }

    if (!game.isOffline) {
      game.deepLinkUrl = await dynamicLinkProvider.createDynamicLink(game.id);
    }

    await updateGame(game, true, shouldCreate: true, shouldSyncWithFirestore: true);

    return game;
  }

  static Future<Thread> createThread(Users user, String id) async {
    Thread thread = Thread.getDefaultThread(user, id);

    await FirebaseFirestore.instance.collection(FirestoreConstants.threadCollection).doc(id).set(thread.toJson());

    return thread;
  }

  static Future<void> addNewHumanPlayerToGame(Game game, Users user) async {
    Game newGame = (await getGame(game.id))!;

    newGame.reaction = Reaction.parseGameStatus(GameStatusService.playerJoined);
    newGame.players.add(Player.getJoiningPlayer(user, game));
    newGame.playerIds.add(user.id);
    newGame.isOffline = GameProvider.isGameOffline(newGame);

    await updateGame(newGame, true, shouldSyncWithFirestore: true);
  }

  static Future<void> updateOngoingGamesAfterUserChange(Users user) async {
    List<Game> games = await getOngoingGames(user.id);

    for (Game game in games) {
      game.players[game.players.indexWhere((element) => element.id == user.id)].avatar = user.avatar;
      game.players[game.players.indexWhere((element) => element.id == user.id)].psuedonym = user.psuedonym;
      await updateGame(game, false, shouldSyncWithFirestore: true);
    }
  }

  static Future<void> sendGameChat(String id, String gameId, String message) async {
    try {
      Message messageObject = Message(body: message, createdById: id, createdAt: '', seenBy: [id], isDeleted: false);

      Map<String, dynamic> jsonMessage = messageObject.toJson();

      await FirebaseFirestore.instance.collection(FirestoreConstants.threadCollection).doc(gameId).update({
        "messages": FieldValue.arrayUnion([jsonMessage]),
      });
    } catch (e) {
      Utils.showToast(DialogueService.genericErrorText.tr);
      debugPrint(e.toString());
    }
  }

  static Future<void> updateGame(Game game, bool shouldUpdateDate, {bool? shouldCreate, bool? shouldSyncWithFirestore}) async {
    Map<String, dynamic> jsonGame = game.toJson();

    try {
      if (shouldUpdateDate) {
        jsonGame['lastUpdatedAt'] = Utils.getRTDBServerTimestamp();
      }

      if (shouldCreate != null && shouldCreate) {
        await FirebaseDatabase.instance.ref('${RealTimeDatabaseConstants.gamesReference}/${game.id}').set(jsonGame);
      } else {
        await FirebaseDatabase.instance.ref('${RealTimeDatabaseConstants.gamesReference}/${game.id}').update(jsonGame);
      }

      if (shouldSyncWithFirestore != null && shouldSyncWithFirestore) {
        if (shouldUpdateDate) {
          jsonGame['lastUpdatedAt'] = Utils.getFireStoreServerTimestamp();
        }

        if (shouldCreate != null && shouldCreate) {
          jsonGame['createdAt'] = Utils.getFireStoreServerTimestamp();
          await FirebaseFirestore.instance.collection(FirestoreConstants.gamesCollection).doc(game.id).set(jsonGame);
        } else {
          await FirebaseFirestore.instance.collection(FirestoreConstants.gamesCollection).doc(game.id).update(jsonGame);
        }
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  static Future<void> updateGameSessionStartDate(Game game) async {
    try {
      Map<String, dynamic> jsonGame = game.toJson();

      // RTDB
      jsonGame['sessionStartedAt'] = Utils.getRTDBServerTimestamp();
      await FirebaseDatabase.instance.ref('${RealTimeDatabaseConstants.gamesReference}/${game.id}').update(jsonGame);
      // FIRESTORE
      jsonGame['sessionStartedAt'] = Utils.getFireStoreServerTimestamp();
      FirebaseFirestore.instance.collection(FirestoreConstants.gamesCollection).doc(game.id).update(jsonGame);
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  static Future<void> updateGameSessionEndDate(Game game) async {
    try {
      Map<String, dynamic> jsonGame = game.toJson();

      // RTDB
      jsonGame['sessionEndedAt'] = Utils.getRTDBServerTimestamp();
      await FirebaseDatabase.instance.ref('${RealTimeDatabaseConstants.gamesReference}/${game.id}').update(jsonGame);
      // FIRESTORE
      jsonGame['sessionEndedAt'] = Utils.getFireStoreServerTimestamp();
      FirebaseFirestore.instance.collection(FirestoreConstants.gamesCollection).doc(game.id).update(jsonGame);
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  static Future<void> deleteGame(String gameID, Users user) async {
    GameProvider gameProvider = Get.context!.read<GameProvider>();

    try {
      if (gameProvider.currentGame != null) {
        if (gameProvider.currentGame!.id == gameID) {
          gameProvider.currentGame = null;
          gameProvider.currentGameStream = null;
          gameProvider.currentThread = null;
          gameProvider.currentThreadStream = null;
        }
      }

      await FirebaseDatabase.instance.ref('${RealTimeDatabaseConstants.gamesReference}/$gameID').set(null);
      await FirebaseFirestore.instance.collection(FirestoreConstants.gamesCollection).doc(gameID).delete();
      await deleteThread(gameID);
    } catch (e) {
      Utils.showToast(DialogueService.genericErrorText.tr);
      debugPrint(e.toString());
    }
  }

  static Future<void> updateThread(Thread thread) async {
    try {
      await FirebaseFirestore.instance.collection(FirestoreConstants.threadCollection).doc(thread.id).update(thread.toJson());
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  static Future<void> deleteThread(String id) async {
    try {
      await FirebaseFirestore.instance.collection(FirestoreConstants.threadCollection).doc(id).delete();
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
