import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:six_me_ludo_android/providers/user_provider.dart';
import 'package:six_me_ludo_android/services/translations/dialogue_service.dart';
import 'package:six_me_ludo_android/widgets/custom_textfield_widget.dart';

import '../constants/app_constants.dart';
import '../constants/textstyle_constants.dart';
import 'custom_elevated_button.dart';

showChangePsuedonymDialog({
  required BuildContext context,
}) {
  return showDialog(
    context: context,
    barrierDismissible: true,
    builder: (BuildContext context) {
      UserProvider userProvider = context.watch<UserProvider>();

      return AlertDialog(
        shape: AppConstants.appShape,
        title: Text(
          DialogueService.changePseudonymText.tr,
          style: TextStyles.dialogTitleStyle(Theme.of(context).colorScheme.onSurface),
          textAlign: TextAlign.center,
        ),
        content: CustomTextFieldWidget(
          controller: userProvider.pseudonymController,
          hint: DialogueService.changePseudonymHintText.tr,
          maxLength: AppConstants.maxPseudonymLength,
        ),
        actions: [
          CustomElevatedButton(
            onPressed: () {
              userProvider.setUserPseudonym();
            },
            text: DialogueService.savePseudonymDialogText.tr,
          ),
        ],
      );
    },
  );
}
