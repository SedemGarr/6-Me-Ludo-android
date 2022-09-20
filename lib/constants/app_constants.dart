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
  static const int minPseudonymLength = 3;
  static const int maxPseudonymLength = 25;
  static const int maxOngoingGamesNumber = 50;
  static const int joinGameCodeLength = 20;
  static const int animationDurationValue = 250;
  static const int gameThreadMessageLimit = 500;

  static const double standardAppbarHeight = kToolbarHeight + 4;
  static const double standardTabbarHeight = kTextTabBarHeight;

  static double customAppbarHeight = Get.height * 1 / 4;
  static double customAppbarWithTabbarHeight = standardAppbarHeight + standardTabbarHeight;
  static double profileAppbarHeight = customAppbarHeight + kToolbarHeight;
  static double changeAvatarGridviewHeight = Get.height * 1 / 2;
  static const double appBorderRadiusValue = 4.0;

  static const Duration animationDuration = Duration(milliseconds: animationDurationValue);
  static const Duration confettiDuration = Duration(seconds: 5);

  static BorderRadius appBorderRadius = BorderRadius.circular(appBorderRadiusValue);

  static const Curve animationCurve = Curves.fastOutSlowIn;

  static RoundedRectangleBorder appShape = RoundedRectangleBorder(borderRadius: appBorderRadius);

  static EdgeInsets listViewPadding = EdgeInsets.only(top: 8, bottom: Get.height * 0.25);
  static const EdgeInsets userAvatarPadding = EdgeInsets.all(4.0);
  static const EdgeInsets userAvatarAppBarPadding = EdgeInsets.all(2.0);
  static const EdgeInsets bannerPadding = EdgeInsets.all(16.0);
}
