import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AppConstants {
  static const String appNameEnglish = '6-Me-Ludo';
  static const String lottieAnimationAuthor = 'Abdul Latif';
  static const String defaultCountryCode = 'GH';
  static const String wayyyOutLottieAssetPath = 'assets/lottie/wayyyout3.json';
  static const String wayyyOutLottieAssetPage = 'https://lottiefiles.com/68789-cute-mascot-astronaut-in-rocket';

  static const int maxPseudonymLength = 30;

  static const int animationDurationValue = 250;
  static const double appBorderRadiusValue = 4.0;
  static const Duration animationDuration = Duration(milliseconds: animationDurationValue);
  static BorderRadius appBorderRadius = BorderRadius.circular(appBorderRadiusValue);
  static const Curve animationCurve = Curves.fastOutSlowIn;
  static RoundedRectangleBorder appShape = RoundedRectangleBorder(
    borderRadius: appBorderRadius,
  );
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

class RealTimeDatabaseConstants {
  static const String userNode = 'users';
}

class AppIcons {
  // ai personality
  static const IconData pacifistIcon = Icons.abc;
  static const IconData averageJoeIcon = Icons.abc;
  static const IconData viciousIcon = Icons.abc;
  static const IconData randomIcon = Icons.abc;
  //
  static const IconData googleIcon = FontAwesomeIcons.google;
  //
  static const IconData infoIcon = FontAwesomeIcons.circleInfo;
  //
  static const IconData newGameIcon = FontAwesomeIcons.a;
  static const IconData joinGameIcon = FontAwesomeIcons.a;
}

class TextStyles {
  static TextStyle appBarTitleStyle(Color color) {
    return TextStyle(
      fontWeight: FontWeight.bold,
      color: color,
    );
  }

  static TextStyle appBarBottomOrStyle(Color color) {
    return TextStyle(
      color: color,
    );
  }

  static TextStyle noGamesStyle(Color color) {
    return TextStyle(
      color: color,
    );
  }

  static TextStyle dialogTitleStyle(Color color) {
    return TextStyle(
      color: color,
      fontWeight: FontWeight.bold,
    );
  }

  static TextStyle dialogContentStyle(Color color) {
    return TextStyle(
      color: color,
    );
  }

  static TextStyle dialogContentStyleBold(Color color) {
    return TextStyle(
      color: color,
      fontWeight: FontWeight.bold,
    );
  }

  static TextStyle elevatedButtonStyle(Color color) {
    return TextStyle(
      color: color,
      fontWeight: FontWeight.bold,
    );
  }

  static TextStyle textButtonStyle(Color color) {
    return TextStyle(
      color: color,
      fontWeight: FontWeight.bold,
    );
  }
}
