import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:six_me_ludo_android/providers/analytics_provider.dart';
import 'package:six_me_ludo_android/providers/dynamic_link_provider.dart';
import 'package:six_me_ludo_android/providers/nav_provider.dart';
import 'package:six_me_ludo_android/providers/sound_provider.dart';
import 'package:six_me_ludo_android/widgets/app.dart';

import 'providers/app_provider.dart';
import 'providers/game_provider.dart';
import 'providers/theme_provider.dart';
import 'providers/user_provider.dart';

Future<void> main() async {
  await AppProvider.initApp();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]).then(
    (_) {
      runApp(
        MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (_) => UserProvider()),
            ChangeNotifierProvider(create: (_) => ThemeProvider()),
            ChangeNotifierProvider(create: (_) => AppProvider()),
            ChangeNotifierProvider(create: (_) => GameProvider()),
            ChangeNotifierProvider(create: (_) => NavProvider()),
            ChangeNotifierProvider(create: (_) => SoundProvider()),
            ChangeNotifierProvider(create: (_) => DynamicLinkProvider()),
            ChangeNotifierProvider(create: (_) => AnalyticsProvider()),
          ],
          child: const SixMeLudo(),
        ),
      );
    },
  );
}
