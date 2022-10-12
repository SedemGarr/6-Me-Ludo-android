import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:six_me_ludo_android/models/user.dart';
import 'package:six_me_ludo_android/providers/game_provider.dart';
import 'package:six_me_ludo_android/providers/user_provider.dart';
import 'package:six_me_ludo_android/screens/game/game_wrapper.dart';

class AppLifeCycleManager extends StatefulWidget {
  final Widget child;

  const AppLifeCycleManager({Key? key, required this.child}) : super(key: key);

  @override
  AppLifeCycleManagerState createState() => AppLifeCycleManagerState();
}

class AppLifeCycleManagerState extends State<AppLifeCycleManager> with WidgetsBindingObserver {
  late GameProvider gameProvider;
  late UserProvider userProvider;

  @override
  void initState() {
    super.initState();
    gameProvider = context.read<GameProvider>();
    userProvider = context.read<UserProvider>();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    super.didChangeAppLifecycleState(state);

    if (userProvider.isUserInitialised()) {
      Users user = userProvider.getUser();

      switch (state) {
        case AppLifecycleState.paused:
          await gameProvider.handleGameAppLifecycleChange(false, user);
          userProvider.handleWakelockLogic(false);
          break;
        case AppLifecycleState.detached:
          userProvider.handleWakelockLogic(false);
          break;
        case AppLifecycleState.resumed:
          await gameProvider.handleGameAppLifecycleChange(true, user);
          if (Get.currentRoute == GameScreenWrapper.routeName) {
            userProvider.handleWakelockLogic(true);
          }
          break;
        case AppLifecycleState.inactive:
          await gameProvider.handleGameAppLifecycleChange(false, user);
          userProvider.handleWakelockLogic(false);
          break;
        default:
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
