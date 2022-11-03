import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:six_me_ludo_android/providers/user_provider.dart';
import 'package:six_me_ludo_android/widgets/custom_card_widget.dart';

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
      child: CustomCardWidget(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16.0),
          child: TextFormField(
            autofocus: true,
            controller: userProvider.pseudonymController,
            maxLength: AppConstants.maxPseudonymLength,
            decoration: InputDecoration(
              hintText: DialogueService.changePseudonymHintText.tr,
              filled: false,
              hintStyle: TextStyles.listSubtitleStyle(Theme.of(context).colorScheme.tertiary),
              counterStyle: TextStyles.listSubtitleStyle(
                Theme.of(context).colorScheme.primaryContainer,
              ),
            ),
            style: TextStyles.listTitleStyle(
              Theme.of(context).colorScheme.onBackground,
            ),
            cursorColor: Theme.of(context).primaryColor,
            keyboardType: TextInputType.text,
            onChanged: (value) {
              userProvider.setPseudonymControllerValue(value, true);
            },
          ),
        ),
      ),
    );
  }
}
