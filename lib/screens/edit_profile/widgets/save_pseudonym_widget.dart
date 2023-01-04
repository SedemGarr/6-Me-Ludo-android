import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import 'package:six_me_ludo_android/providers/user_provider.dart';
import 'package:six_me_ludo_android/services/translations/dialogue_service.dart';

import '../../../widgets/buttons/custom_elevated_button.dart';
import '../../../widgets/general/custom_animated_crossfade.dart';

class SavePseudonymButton extends StatelessWidget {
  const SavePseudonymButton({super.key});

  @override
  Widget build(BuildContext context) {
    UserProvider userProvider = context.watch<UserProvider>();

    return CustomAnimatedCrossFade(
      firstChild: Container(
        width: Get.width,
        padding: const EdgeInsets.only(
          left: 8.0,
          right: 8.0,
          bottom: 8.0,
        ),
        child: CustomElevatedButton(
          onPressed: () {
            userProvider.setUserPseudonym();
          },
          text: DialogueService.savePseudonymText.tr,
        ),
      ),
      secondChild: const SizedBox.shrink(),
      condition: userProvider.hasUserPseudonymChanged(),
    );
  }
}
