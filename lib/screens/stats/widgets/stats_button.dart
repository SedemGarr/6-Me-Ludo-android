import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:six_me_ludo_android/constants/icon_constants.dart';
import 'package:six_me_ludo_android/services/navigation_service.dart';

class StatsButton extends StatelessWidget {
  const StatsButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        NavigationService.goToStatsScreen();
      },
      icon: Icon(
        AppIcons.statsIcon,
        color: Get.isDarkMode ? Theme.of(context).colorScheme.primary : Theme.of(context).colorScheme.onPrimary,
      ),
    );
  }
}
