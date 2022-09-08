import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:six_me_ludo_android/constants/app_constants.dart';
import 'package:six_me_ludo_android/constants/textstyle_constants.dart';
import 'package:six_me_ludo_android/services/translations/dialogue_service.dart';

class NewGameFAB extends StatelessWidget {
  const NewGameFAB({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.extended(
      elevation: 0,
      shape: AppConstants.appShape,
      onPressed: () {},
      label: Text(
        DialogueService.newGameText.tr,
        style: TextStyles.fabStyle(Theme.of(context).colorScheme.onPrimaryContainer),
      ),
    );
  }
}
