import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:six_me_ludo_android/providers/user_provider.dart';
import 'package:six_me_ludo_android/screens/splash/widgets/animation_attribution.dart';

import 'package:six_me_ludo_android/services/authentication_service.dart';
import 'package:six_me_ludo_android/services/translations/dialogue_service.dart';
import 'package:six_me_ludo_android/widgets/custom_animated_crossfade.dart';
import 'package:six_me_ludo_android/widgets/custom_elevated_button.dart';
import 'package:six_me_ludo_android/widgets/legal_text.dart';
import 'package:six_me_ludo_android/widgets/loading_widget.dart';
import '../../../constants/app_constants.dart';
import '../../../constants/icon_constants.dart';
import '../../../widgets/wayout_widget.dart';

class IntroAnimation extends StatefulWidget {
  const IntroAnimation({Key? key}) : super(key: key);

  @override
  State<IntroAnimation> createState() => _IntroAnimationState();
}

class _IntroAnimationState extends State<IntroAnimation> {
  bool isLoaded = false;

  @override
  Widget build(BuildContext context) {
    UserProvider userProvider = context.watch<UserProvider>();

    return Center(
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.8,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(width: 1, color: Theme.of(context).primaryColor),
                  color: Theme.of(context).primaryColor,
                  borderRadius: AppConstants.appBorderRadius,
                ),
                child: CustomAnimatedCrossFade(
                  firstChild: Lottie.asset(
                    AppConstants.wayyyOutLottieAssetPath,
                    onLoaded: (p0) {
                      setState(() {
                        isLoaded = true;
                      });
                    },
                    repeat: true,
                    fit: BoxFit.cover,
                  ),
                  secondChild: const SizedBox(),
                  condition: isLoaded,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: WayOutWidget(width: MediaQuery.of(context).size.width * 0.8),
            ),
            Expanded(
                child: CustomAnimatedCrossFade(
                    firstChild: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CustomElevatedButton(
                          iconData: AppIcons.googleIcon,
                          onPressed: () {
                            userProvider.setDoesUserNeedToSignIn(false);
                            AuthenticationService.signInWithGoogle(context);
                          },
                          text: DialogueService.signInText.tr,
                        ),
                        const LegalText()
                      ],
                    ),
                    secondChild: const LoadingWidget(),
                    condition: userProvider.doesUserNeedToSignIn)),
            const AnimationAttributionWidget()
          ],
        ),
      ),
    );
  }
}
