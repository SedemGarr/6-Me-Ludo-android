import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:six_me_ludo_android/models/game.dart';
import 'package:six_me_ludo_android/services/translations/dialogue_service.dart';
import 'package:six_me_ludo_android/services/user_state_service.dart';
import 'package:six_me_ludo_android/utils/utils.dart';
import 'package:uuid/uuid.dart';

import '../constants/database_constants.dart';
import '../models/message.dart';
import '../models/player.dart';
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

      newUser ??= await Users.getDefaultUser(user.uid, isAnon);

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

    List<Game> userGames = await getOngoingGamesList(user.id);

    for (var i = 0; i < userGames.length; i++) {
      await deleteGame(userGames[i]);
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
    return FirebaseFirestore.instance.collection(FirestoreConstants.gamesCollection).doc(gameId).snapshots().map((snapshot) => Game.fromJson(snapshot.data()!));
  }

  static Stream<List<Game>> getOngoingGames(Users user) {
    return FirebaseFirestore.instance
        .collection(FirestoreConstants.gamesCollection)
        .where('playerIds', arrayContains: user.id)
        .snapshots()
        .map((snapShot) => snapShot.docs.map((document) => Game.fromJson(document.data())).toList());
  }

  static Future<List<Game>> getOngoingGamesList(String id) async {
    List<Game> mpGames = [];

    QuerySnapshot<Map<String, dynamic>> docs = await FirebaseFirestore.instance.collection(FirestoreConstants.gamesCollection).where('hostId', isEqualTo: id).get();

    for (var element in docs.docs) {
      mpGames.add(Game.fromJson(element.data()));
    }

    return mpGames;
  }

  static Future<Game?> getGame(String id) async {
    try {
      return Game.fromJson((await FirebaseFirestore.instance.collection(FirestoreConstants.gamesCollection).doc(id).get()).data()!);
    } catch (e) {
      return null;
    }
  }

  static Future<Game> createGame(Users user, Uuid uuid) async {
    CollectionReference gameRef = FirebaseFirestore.instance.collection(FirestoreConstants.gamesCollection);

    Game game = Game.getDefaultGame(user, gameRef.doc().id);

    if (user.settings.prefersAddAI) {
      game = Game.autoFillWithAIPlayers(game, user, uuid);
      game.maxPlayers = 4;
    }

    await updateGame(game, true, shouldCreate: true);

    return game;
  }

  static Future<void> addNewHumanPlayerToGame(Game game, Users user) async {
    await FirebaseFirestore.instance.collection(FirestoreConstants.gamesCollection).doc(game.id).update({
      "gameStatus": GameStatusService.playerJoined,
      "players": FieldValue.arrayUnion([Player.getJoiningPlayer(user, game).toJson()]),
      "playerIds": FieldValue.arrayUnion([user.id]),
    });
  }

  static Future<void> updateOngoingGamesAfterUserChange(Users user) async {
    QuerySnapshot<Map<String, dynamic>> res = await FirebaseFirestore.instance.collection(FirestoreConstants.gamesCollection).where('playerIds', arrayContains: user.id).get();

    for (int i = 0; i < res.docs.length; i++) {
      Game game = Game.fromJson(res.docs[i].data());
      game.players[game.players.indexWhere((element) => element.id == user.id)].avatar = user.avatar;
      game.players[game.players.indexWhere((element) => element.id == user.id)].psuedonym = user.psuedonym;
      await updateGame(game, false);
    }
  }

  static Future<void> sendGameChat(String id, String gameId, String message) async {
    try {
      Message messageObject = Message(body: message, createdById: id, createdAt: '', seenBy: [id], isDeleted: false);

      Map<String, dynamic> jsonMessage = messageObject.toJson();

      await FirebaseFirestore.instance.collection(FirestoreConstants.gamesCollection).doc(gameId).update({
        "thread": FieldValue.arrayUnion([jsonMessage]),
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
        await FirebaseFirestore.instance.collection(FirestoreConstants.gamesCollection).doc(game.id).set(jsonGame);
      }

      await FirebaseFirestore.instance.collection(FirestoreConstants.gamesCollection).doc(game.id).update(jsonGame);
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  static Future<void> deleteGame(Game game) async {
    await FirebaseFirestore.instance.collection(FirestoreConstants.gamesCollection).doc(game.id).delete();
  }
}
