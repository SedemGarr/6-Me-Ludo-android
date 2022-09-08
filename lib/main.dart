import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:provider/provider.dart';

import 'providers/app_provider.dart';
import 'providers/game_provider.dart';
import 'providers/theme_provider.dart';
import 'providers/user_provider.dart';
import 'screens/splash/splash.dart';
import 'services/translations/dialogue_service.dart';
import 'utils/utils.dart';
import 'widgets/app_lifecycle_manager.dart';
import 'widgets/loading_widget.dart';

Future<void> main() async {
  await Utils.initApp();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]).then(
    (_) {
      runApp(
        MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (_) => UserProvider()),
            ChangeNotifierProvider(create: (_) => ThemeProvider()),
            ChangeNotifierProvider(create: (_) => AppProvider()),
            ChangeNotifierProvider(create: (_) => GameProvider()),
          ],
          child: const MyApp(),
        ),
      );
    },
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    UserProvider userProvider = context.watch<UserProvider>();
    ThemeProvider themeProvider = context.watch<ThemeProvider>();

    return AppLifeCycleManager(
      child: GlobalLoaderOverlay(
        disableBackButton: true,
        useDefaultLoading: false,
        overlayWidget: const LoadingWidget(),
        overlayColor: Theme.of(context).colorScheme.onSurface,
        child: GetMaterialApp(
          title: DialogueService.appName.tr,
          theme: themeProvider.getLightTheme(),
          darkTheme: themeProvider.getDarkTheme(),
          // themeMode: ThemeMode.dark,
          themeMode: themeProvider.getThemeMode(),
          locale: userProvider.getLocale(),
          translations: DialogueService(),
          fallbackLocale: DialogueService.englishUS,
          defaultTransition: Transition.downToUp,
          debugShowCheckedModeBanner: false,
          home: const SplashScreen(),
        ),
      ),
    );
  }
}
