import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:six_me_ludo_android/services/navigation_service.dart';
import 'package:six_me_ludo_android/services/translations/dialogue_service.dart';

import '../../../../../widgets/buttons/custom_outlined_button.dart';

class SeeMoreStatsButton extends StatelessWidget {
  const SeeMoreStatsButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width,
      padding: const EdgeInsets.only(bottom: 8.0),
      child: CustomOutlinedButton(
        onPressed: () {
          NavigationService.goToStatsScreen();
        },
        color: Theme.of(context).colorScheme.onPrimaryContainer,
        text: DialogueService.seeMoreStatsButtonText.tr,
      ),
    );
  }
}
