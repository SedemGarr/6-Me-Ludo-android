import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:six_me_ludo_android/services/translations/dialogue_service.dart';
import 'package:six_me_ludo_android/utils/utils.dart';

import '../../providers/app_provider.dart';
import '../../providers/user_provider.dart';
import '../home/home.dart';
import 'widgets/intro_animation.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late UserProvider userProvider;
  late AppProvider appProvider;

  Future<void> load(BuildContext context) async {
    await init(context);
  }

  Future<void> init(BuildContext context) async {
    await getUser(context);
  }

  Future<void> getUser(BuildContext context) async {
    // await appProvider.getPackageInfo();
    // await userProvider.initUser();

    // if (userProvider.hasUser()) {
    //   Future.delayed(const Duration(seconds: 3), () async {
    //     Get.offAll(() => const HomeScreen());
    //   });
    // } else {
    //   Utils.showToast(DialogueService.genericErrorText.tr);
    // }
  }

  @override
  void initState() {
    super.initState();
    userProvider = context.read<UserProvider>();
    appProvider = context.read<AppProvider>();
    load(context);
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
