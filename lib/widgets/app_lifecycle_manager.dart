import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:six_me_ludo_android/providers/game_provider.dart';

class AppLifeCycleManager extends StatefulWidget {
  final Widget child;

  const AppLifeCycleManager({Key? key, required this.child}) : super(key: key);

  @override
  AppLifeCycleManagerState createState() => AppLifeCycleManagerState();
}

class AppLifeCycleManagerState extends State<AppLifeCycleManager> with WidgetsBindingObserver {
  late GameProvider gameProvider;

  @override
  void initState() {
    super.initState();
    gameProvider = context.read<GameProvider>();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    super.didChangeAppLifecycleState(state);

    switch (state) {
      case AppLifecycleState.paused:
        // set presence to false;
        await gameProvider.handleGameAppLifecycleChange(false);
        break;
      case AppLifecycleState.detached:
        break;
      case AppLifecycleState.resumed:
      await gameProvider.handleGameAppLifecycleChange(true);
        break;
      case AppLifecycleState.inactive:
        // set presence to false;
        await gameProvider.handleGameAppLifecycleChange(false);
        break;
      default:
    }
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
