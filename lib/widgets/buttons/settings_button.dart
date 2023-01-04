import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:six_me_ludo_android/constants/icon_constants.dart';
import 'package:six_me_ludo_android/services/navigation_service.dart';

class SettingsButton extends StatelessWidget {
  const SettingsButton({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        NavigationService.goToProfileScreen();
      },
      icon: Icon(
        AppIcons.settingsIcon,
        color: Get.isDarkMode ? Theme.of(context).primaryColor : Theme.of(context).colorScheme.onPrimary,
      ),
    );
  }
}
