import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:six_me_ludo_android/services/user_state_service.dart';
import 'package:six_me_ludo_android/utils/utils.dart';

import '../constants/database_constants.dart';
import '../models/token.dart';
import '../models/user.dart';

class DatabaseService {
  static Future<Token> fetchTokens() async {
    return Token.fromJson((await FirebaseFirestore.instance.collection(FirestoreConstants.appDataCollection).doc(FirestoreConstants.tokenDocument).get()).data()!);
  }

  static Future<Users?> getUser(String id) async {
    try {
      return Users.fromJson((await FirebaseFirestore.instance.collection(FirestoreConstants.userCollection).doc(id).get()).data()!);
    } catch (e) {
      return null;
    }
  }

  static Future<Users?> createUser(User user) async {
    try {
      // check if user already exits in db
      Users? newUser = await getUser(user.uid);

      newUser ??= await Users.getDefaultUser(user.uid);

      UserStateUpdateService.updateUser(newUser, true);
      return newUser;
    } catch (e) {
      Utils.showToast(e.toString());
      return null;
    }
  }

  static Future<void> updateUserData(Users user) async {
    try {
      await FirebaseFirestore.instance.collection(FirestoreConstants.userCollection).doc(user.id).set(user.toJson(), SetOptions(merge: true));
    } catch (e) {
      Utils.showToast(e.toString());
    }
  }
}
