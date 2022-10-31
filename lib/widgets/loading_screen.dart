import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:six_me_ludo_android/services/translations/dialogue_service.dart';
import 'package:six_me_ludo_android/widgets/app_bar_title_widget.dart';
import 'package:six_me_ludo_android/widgets/custom_appbar.dart';
import 'package:six_me_ludo_android/widgets/loading_widget.dart';

class LoadingScreen extends StatelessWidget {
  const LoadingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: CustomAppBarWidget(
          title: AppBarTitleWidget(text: DialogueService.loadingText.tr),
          centerTitle: true,
        ),
        body: LoadingWidget(
          color: Theme.of(context).primaryColor,
        ),
      ),
    );
  }
}
