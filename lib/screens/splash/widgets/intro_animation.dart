import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:six_me_ludo_android/providers/app_provider.dart';
import 'package:six_me_ludo_android/screens/splash/widgets/animation_attribution.dart';
import 'package:six_me_ludo_android/services/translations/dialogue_service.dart';
import 'package:six_me_ludo_android/widgets/auth_bottom_sheet.dart';

import 'package:six_me_ludo_android/widgets/custom_animated_crossfade.dart';
import 'package:six_me_ludo_android/widgets/custom_elevated_button.dart';
import 'package:six_me_ludo_android/widgets/loading_screen.dart';
import '../../../constants/app_constants.dart';
import '../../../widgets/wayout_widget.dart';

class IntroAnimation extends StatelessWidget {
  const IntroAnimation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AppProvider appProvider = context.watch<AppProvider>();

    return appProvider.isLoading
        ? const LoadingScreen()
        : Center(
            child: SizedBox(
              width: MediaQuery.of(context).size.width * 0.8,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Spacer(),
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: AppConstants.appBorderRadius,
                        color: Theme.of(context).primaryColor,
                      ),
                      child: CustomAnimatedCrossFade(
                        firstChild: Lottie.asset(
                          AppConstants.wayyyOutLottieAssetPath,
                          onLoaded: (p0) {
                            appProvider.setSplashScreenLoaded(true);
                          },
                          repeat: true,
                          fit: BoxFit.cover,
                        ),
                        secondChild: const SizedBox(),
                        condition: appProvider.isSplashScreenLoaded,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: WayOutWidget(width: MediaQuery.of(context).size.width * 0.8),
                  ),
                  Expanded(
                    child: appProvider.shouldShowAuthButton && !appProvider.isLoading
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                width: Get.width * 2 / 4,
                                child: CustomElevatedButton(
                                    onPressed: () {
                                      showAuthBottomSheet(context: context);
                                    },
                                    text: DialogueService.beginText.tr),
                              ),
                            ],
                          )
                        : Container(),
                  ),
                  const AnimationAttributionWidget()
                ],
              ),
            ),
          );
  }
}
