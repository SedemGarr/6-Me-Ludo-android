import 'package:cloud_firestore/cloud_firestore.dart';

import '../constants/constants.dart';
import '../models/token.dart';

class DatabaseService {
  static Future<Token> fetchTokens() async {
    return Token.fromJson((await FirebaseFirestore.instance.collection(FirestoreConstants.appDataCollection).doc(FirestoreConstants.tokenDocument).get()).data()!);
  }
}
