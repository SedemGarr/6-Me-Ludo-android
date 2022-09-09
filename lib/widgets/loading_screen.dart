import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:six_me_ludo_android/widgets/loading_widget.dart';

class LoadingScreen extends StatelessWidget {
  const LoadingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        backgroundColor: Get.isDarkMode ? Theme.of(context).scaffoldBackgroundColor : Theme.of(context).primaryColor,
        body: LoadingWidget(
          color: Get.isDarkMode ? null : Theme.of(context).colorScheme.onPrimary,
        ),
      ),
    );
  }
}
