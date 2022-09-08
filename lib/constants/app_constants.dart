import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppConstants {
  static const String appNameEnglish = '6-Me-Ludo';
  static const String lottieAnimationAuthor = 'Abdul Latif';
  static const String defaultCountryCode = 'GH';
  static const String wayyyOutLottieAssetPath = 'assets/lottie/wayyyout3.json';
  static const String wayyyOutLottieAssetPage = 'https://lottiefiles.com/68789-cute-mascot-astronaut-in-rocket';
  static const String privacyURL = 'https://sites.google.com/view/6-me-ludo-terms/home';
  static const String termsURL = 'https://sites.google.com/view/6-me-ludo-terms/home';

  static const int maxPlayerLowerLimit = 1;
  static const int maxPlayerUpperLimit = 4;
  static const int maxPseudonymLength = 30;
  static const int maxOngoingGamesNumber = 15;
  static const int joinGameCodeLength = 20;
  static const int animationDurationValue = 250;

  static const double appBorderRadiusValue = 4.0;
  static const Duration animationDuration = Duration(milliseconds: animationDurationValue);
  static BorderRadius appBorderRadius = BorderRadius.circular(appBorderRadiusValue);
  static const Curve animationCurve = Curves.fastOutSlowIn;
  static RoundedRectangleBorder appShape = RoundedRectangleBorder(borderRadius: appBorderRadius);
  static EdgeInsets listViewBottomPadding = EdgeInsets.only(bottom: Get.height * 0.25);
}
