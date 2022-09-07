import 'package:flutter/material.dart';

class AppConstants {
  static const String appNameEnglish = '6-Me-Ludo';

  static const int maxPseudonymLength = 30;
}

class FirestoreConstants {
  static const String userCollection = 'user-data';
  static const String gamesCollection = 'games';
  static const String threadCollection = 'game-threads';
  static const String statsCollection = 'stats';
  static const String legalCollection = 'legal';
  static const String appDataCollection = 'app-data';
  static const String tokenDocument = 'tokens';
  static const String errorDocument = 'errors';
  static const String versionDocument = 'versions';
}

class AppIcons {
  // ai personality
  static const IconData pacifistIcon = Icons.abc;
  static const IconData averageJoeIcon = Icons.abc;
  static const IconData viciousIcon = Icons.abc;
  static const IconData randomIcon = Icons.abc;
}
