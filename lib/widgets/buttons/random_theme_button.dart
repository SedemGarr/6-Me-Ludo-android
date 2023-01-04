import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../../providers/user_provider.dart';
import '../../services/translations/dialogue_service.dart';
import 'custom_elevated_button.dart';

class RandomThemeButtonWidget extends StatelessWidget {
  const RandomThemeButtonWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    UserProvider userProvider = context.watch<UserProvider>();

    return Container(
      width: Get.width,
      padding: const EdgeInsets.all(8.0),
      child: CustomElevatedButton(
        onPressed: () {
          userProvider.setThemeToRandom(context);
        },
        text: DialogueService.randomiseThemeText.tr,
      ),
    );
  }
}
