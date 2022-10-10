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
import 'game_status_service.dart';

class DatabaseService {
  // users

  static Future<Users?> getUser(String id) async {
    try {
      return Users.fromJson((await FirebaseFirestore.instance.collection(FirestoreConstants.userCollection).doc(id).get()).data()!);
    } catch (e) {
      return null;
    }
  }

  static Future<Users?> createUser(User user, bool isAnon) async {
    try {
      // check if user already exits in db
      Users? newUser = isAnon ? null : await getUser(user.uid);

      newUser ??= await Users.getDefaultUser(user.uid, user.email!, isAnon);

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

    for (var i = 0; i < user.onGoingGameIDs.length; i++) {
      await deleteGame(user.onGoingGameIDs[i], user);
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
  static Stream<Game> getCurrentGameStream(String gameId) {
    return FirebaseDatabase.instance.ref('games/$gameId').onValue.map((event) => Game.fromJson(Map<String, dynamic>.from(jsonDecode(jsonEncode(event.snapshot.value)))));
  }

  static Stream<Thread> getCurrentThreadStream(String gameId) {
    return FirebaseFirestore.instance.collection(FirestoreConstants.threadCollection).doc(gameId).snapshots().map((snapshot) => Thread.fromJson(snapshot.data()!));
  }

  static Future<Game?> getGame(String id) async {
    try {
      return Game.fromJson((Map<String, dynamic>.from(jsonDecode(jsonEncode((await FirebaseDatabase.instance.ref('games/$id').get()).value)))));
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

  static Future<Game> createGame(Users user, Uuid uuid, bool isOffline) async {
    DatabaseReference gameRef = FirebaseDatabase.instance.ref('games');

    Game game = Game.getDefaultGame(user, gameRef.push().key!, isOffline);

    if (user.settings.prefersAddAI) {
      game = Game.autoFillWithAIPlayers(game, user, uuid);
      game.maxPlayers = 4;
    }

    await updateGame(game, true, shouldCreate: true);

    await user.addOngoingGameIDToList(game.id);

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

    await user.addOngoingGameIDToList(game.id);

    await updateGame(newGame, true);
  }

  static Future<void> updateOngoingGamesAfterUserChange(Users user) async {
    for (String element in user.onGoingGameIDs) {
      Game game = (await getGame(element))!;
      game.players[game.players.indexWhere((element) => element.id == user.id)].avatar = user.avatar;
      game.players[game.players.indexWhere((element) => element.id == user.id)].psuedonym = user.psuedonym;
      await updateGame(game, false);
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

  static Future<void> updateGame(Game game, bool shouldUpdateDate, {bool? shouldCreate}) async {
    Map<String, dynamic> jsonGame = game.toJson();

    try {
      if (shouldUpdateDate) {
        jsonGame['lastUpdatedAt'] = Utils.getServerTimestamp();
      }

      if (shouldCreate != null && shouldCreate) {
        await FirebaseDatabase.instance.ref('games/${game.id}').set(jsonGame);
      } else {
        await FirebaseDatabase.instance.ref('games/${game.id}').set(jsonGame);
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  static Future<void> deleteGame(String gameID, Users user) async {
    GameProvider gameProvider = Get.context!.read<GameProvider>();

    try {
      await user.removeOngoingGameIDFromList(gameID);

      Game game = (await getGame(gameID))!;

      for (Player player in game.players) {
        if (!player.isAIPlayer && player.id != user.id) {
          Users user = (await getUser(player.id))!;
          user.onGoingGameIDs.remove(gameID);
          updateUserData(user);
        }
      }

      if (gameProvider.currentGame!.id == gameID) {
        gameProvider.currentGame = null;
        gameProvider.currentGameStream = null;
        gameProvider.currentThread = null;
        gameProvider.currentThreadStream = null;
      }

      await FirebaseDatabase.instance.ref('games/$gameID').set(null);
      await deleteThread(gameID);
    } catch (e) {
      Utils.showToast(DialogueService.genericErrorText.tr);
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
