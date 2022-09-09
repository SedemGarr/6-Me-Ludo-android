import 'package:flutter/material.dart';
import 'package:six_me_ludo_android/widgets/loading_widget.dart';

class LoadingScreen extends StatelessWidget {
  const LoadingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: const Scaffold(
        body: LoadingWidget(),
      ),
    );
  }
}
