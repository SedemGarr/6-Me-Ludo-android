import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:six_me_ludo_android/providers/analytics_provider.dart';

import 'constants/app_constants.dart';
import 'providers/theme_provider.dart';
import 'providers/user_provider.dart';
import 'screens/splash/splash.dart';
import 'services/translations/dialogue_service.dart';
import 'widgets/wrappers/app_lifecycle_manager.dart';

class SixMeLudo extends StatelessWidget {
  const SixMeLudo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    UserProvider userProvider = context.watch<UserProvider>();
    ThemeProvider themeProvider = context.watch<ThemeProvider>();
    AnalyticsProvider analyticsProvider = context.watch<AnalyticsProvider>();

    return AppLifeCycleManager(
      child: GetMaterialApp(
        title: DialogueService.appName.tr,
        transitionDuration: AppConstants.animationDuration,
        theme: themeProvider.getLightTheme(),
        darkTheme: themeProvider.getDarkTheme(),
        themeMode: themeProvider.getThemeMode(),
        locale: userProvider.getLocale(),
        translations: DialogueService(),
        fallbackLocale: DialogueService.englishUS,
        defaultTransition: Transition.native,
        debugShowCheckedModeBanner: false,
        navigatorObservers: [FirebaseAnalyticsObserver(analytics: analyticsProvider.firebaseAnalytics)],
        home: const SplashScreen(),
      ),
    );
  }
}
