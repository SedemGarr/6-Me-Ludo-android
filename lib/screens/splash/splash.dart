import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/app_provider.dart';
import '../../providers/user_provider.dart';
import 'widgets/intro_animation.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late UserProvider userProvider;
  late AppProvider appProvider;

  Future<void> init(BuildContext context) async {
    appProvider.getPackageInfo();
    await userProvider.initUser(context);
  }

  @override
  void initState() {
    super.initState();
    userProvider = context.read<UserProvider>();
    appProvider = context.read<AppProvider>();
    init(context);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: const Scaffold(
        body: IntroAnimation(),
      ),
    );
  }
}
