import 'package:flutter/material.dart';

class AppLifeCycleManager extends StatefulWidget {
  final Widget child;

  const AppLifeCycleManager({Key? key, required this.child}) : super(key: key);

  @override
  AppLifeCycleManagerState createState() => AppLifeCycleManagerState();
}

class AppLifeCycleManagerState extends State<AppLifeCycleManager> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);

    switch (state) {
      case AppLifecycleState.paused:
        break;
      case AppLifecycleState.detached:
        break;
      case AppLifecycleState.resumed:
        break;
      case AppLifecycleState.inactive:
        break;
      default:
    }
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
