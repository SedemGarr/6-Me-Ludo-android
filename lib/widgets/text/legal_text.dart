import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:six_me_ludo_android/constants/app_constants.dart';

import '../../constants/textstyle_constants.dart';
import '../../services/translations/dialogue_service.dart';

class LegalText extends StatelessWidget {
  const LegalText({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.only(top: 8.0),
        child: RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
            text: DialogueService.signUpLegalese.tr,
            style: TextStyles.legalTextStyleNormal(
              Theme.of(context).colorScheme.onBackground.withOpacity(AppConstants.appOpacity),
            ),
            children: [
              TextSpan(
                  text: DialogueService.termsText.tr,
                  style: TextStyles.legalTextStyleBold(
                    Theme.of(context).primaryColorLight,
                  ),
                  recognizer: TapGestureRecognizer()..onTap = () {}),
              const TextSpan(
                text: ' ',
              ),
              TextSpan(
                text: DialogueService.andText.tr,
              ),
              const TextSpan(
                text: ' ',
              ),
              TextSpan(
                text: DialogueService.privacyText.tr,
                style: TextStyles.legalTextStyleBold(
                  Theme.of(context).primaryColorLight,
                ),
                recognizer: TapGestureRecognizer()..onTap = () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
