import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:six_me_ludo_android/constants/textstyle_constants.dart';
import 'package:six_me_ludo_android/providers/app_provider.dart';

import '../../../constants/app_constants.dart';
import '../../../services/translations/dialogue_service.dart';

class AnimationAttributionWidget extends StatelessWidget {
  const AnimationAttributionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: RichText(
        text: TextSpan(
          style: TextStyles.legalTextStyleNormal(Theme.of(context).colorScheme.onBackground),
          children: [
            TextSpan(
              text: DialogueService.animationByText.tr,
              style: TextStyles.legalTextStyleNormal(Theme.of(context).colorScheme.onBackground),
            ),
            TextSpan(
              text: AppConstants.lottieAnimationAuthor,
              style: TextStyles.legalTextStyleNormal(
                Theme.of(context).primaryColor,
              ),
              recognizer: TapGestureRecognizer()..onTap = () => AppProvider.openURL(AppConstants.wayyyOutLottieAssetPage),
            ),
          ],
        ),
      ),
    );
  }
}
