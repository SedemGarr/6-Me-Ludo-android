import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../constants/app_constants.dart';
import '../providers/theme_provider.dart';
import '../providers/user_provider.dart';
import '../screens/splash/splash.dart';
import '../services/translations/dialogue_service.dart';
import 'app_lifecycle_manager.dart';

class SixMeLudo extends StatelessWidget {
  const SixMeLudo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    UserProvider userProvider = context.watch<UserProvider>();
    ThemeProvider themeProvider = context.watch<ThemeProvider>();

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
        home: const SplashScreen(),
      ),
    );
  }
}
