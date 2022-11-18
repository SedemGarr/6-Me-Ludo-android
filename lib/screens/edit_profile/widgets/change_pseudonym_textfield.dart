import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:six_me_ludo_android/providers/user_provider.dart';

import '../../../constants/app_constants.dart';
import '../../../constants/textstyle_constants.dart';
import '../../../services/translations/dialogue_service.dart';

class ChangePseudonymTextField extends StatelessWidget {
  const ChangePseudonymTextField({super.key});

  @override
  Widget build(BuildContext context) {
    UserProvider userProvider = context.watch<UserProvider>();

    return Padding(
      padding: const EdgeInsets.only(top: 4.0),
      child: Padding(
        padding: AppConstants.listViewPadding,
        child: TextFormField(
          autofocus: true,
          controller: userProvider.pseudonymController,
          maxLength: AppConstants.maxPseudonymLength,
          keyboardType: TextInputType.text,
          textCapitalization: TextCapitalization.sentences,
          decoration: InputDecoration(
            hintText: DialogueService.changePseudonymHintText.tr,
            filled: false,
            border: UnderlineInputBorder(borderSide: BorderSide(color: Theme.of(context).colorScheme.primaryContainer)),
            errorBorder: InputBorder.none,
            enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Theme.of(context).colorScheme.primaryContainer)),
            disabledBorder: InputBorder.none,
            focusedErrorBorder: InputBorder.none,
            focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Theme.of(context).primaryColor)),
            hintStyle: TextStyles.textFieldStyle(Theme.of(context).colorScheme.onBackground.withOpacity(0.5)),
            counterStyle: TextStyles.listSubtitleStyle(
              Theme.of(context).colorScheme.primaryContainer,
            ),
          ),
          style: TextStyles.textFieldStyle(Theme.of(context).colorScheme.onBackground),
          cursorColor: Theme.of(context).primaryColor,
          onChanged: (value) {
            userProvider.setPseudonymControllerValue(value, true);
          },
        ),
      ),
    );
  }
}
