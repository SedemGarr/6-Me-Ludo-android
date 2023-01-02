import 'package:css_colors/css_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppConstants {
  static const String appNameEnglish = '6-Me-Ludo!';
  static const String lottieAnimationAuthor = 'Pierre Blavette';
  static const String defaultCountryCode = 'GH';
  static const String wayyyOutLottieAssetPath = 'assets/lottie/wayyyout1.json';
  static const String appLogoAssetPath = 'assets/logo/app_logo.png';
  static const String wayyyOutLottieAssetPage = 'https://lottiefiles.com/45722-rocket-loader';
  static const String playStoreURL = 'https://play.google.com/store/apps/details?id=com.wayyyoutgames.six.me.ludo';
  static const String privacyURL = 'https://sites.google.com/view/6-me-ludo-terms/home';
  static const String termsURL = 'https://sites.google.com/view/6-me-ludo-terms/home';
  static const String appPackageName = 'com.wayyyoutgames.six.me.ludo';
  static const String appLinkPrefix = 'https://wayyyoutgames.page.link';

  static const int maxPlayerLowerLimit = 1;
  static const int maxPlayerUpperLimit = 4;
  static const int minPseudonymLength = 3;
  static const int maxPseudonymLength = 25;
  static const int maxOngoingGamesNumber = 50;
  static const int maxLeaderboardNumber = 100;
  static const int joinGameCodeLength = 20;
  static const int animationDurationValue = 250;
  static const int gameThreadMessageLimit = 500;
  static const int vibrationDuration = 125;

  static const double appOpacity = 0.25;
  static const double panelHeader = 0.8;

  static const double lottieAnimationCutoffPoint = 1.0;

  static const double standardAppbarHeight = kToolbarHeight + 4;
  static const double standardTabbarHeight = kTextTabBarHeight;

  static double customAppbarHeight = Get.height * 1 / 4;
  static double customAppbarWithTabbarHeight = standardAppbarHeight + standardTabbarHeight;
  static double homeAppBarHeight = customAppbarWithTabbarHeight + 30;
  static double profileAppbarHeight = customAppbarHeight + kToolbarHeight;
  static double changeAvatarGridviewHeight = Get.height * 1 / 2;
  static const double appBorderRadiusValue = 4.0;

  static const Duration animationDuration = Duration(milliseconds: animationDurationValue);
  static const Duration listScrollDuration = Duration(milliseconds: 500);
  static const Duration lottieDuration = Duration(seconds: 6);
  static const Duration confettiDuration = Duration(seconds: 20);
  static const Duration carouselDuration = Duration(seconds: 5);
  static const Duration snackBarDuration = Duration(seconds: 5);
  static const Duration snackBarLongDuration = Duration(seconds: 10);
  static const Duration newtworkTimeoutDuration = Duration(seconds: 30);

  static BorderRadius appBorderRadius = BorderRadius.circular(appBorderRadiusValue);

  static const Curve animationCurve = Curves.fastOutSlowIn;

  static RoundedRectangleBorder appShape = RoundedRectangleBorder(borderRadius: appBorderRadius);

  static const EdgeInsets listViewPadding = EdgeInsets.all(8.0);
  static const EdgeInsets modalTitlePadding = EdgeInsets.all(24.0);
  static const EdgeInsets dialogTitlePadding = EdgeInsets.only(left: 24.0, top: 24.0, right: 24.0, bottom: 0.0);
  static const EdgeInsets dialogActionsPadding = EdgeInsets.only(left: 0.0, top: 0.0, right: 24.0, bottom: 24.0);
  static const EdgeInsets userAvatarPadding = EdgeInsets.all(4.0);
  static const EdgeInsets userAvatarAppBarPadding = EdgeInsets.all(2.0);
  static const EdgeInsets bannerPadding = EdgeInsets.all(16.0);
  static const EdgeInsets cardMarginPadding = EdgeInsets.symmetric(vertical: 4.0);

  static LinearGradient getLinearGradient(List<Color> colors) {
    return LinearGradient(
      colors: colors,
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    );
  }

  //
  static const Color blackColor = CSSColors.black;
  static const Color whiteColor = CSSColors.white;
}
