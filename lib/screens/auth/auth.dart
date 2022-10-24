import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:six_me_ludo_android/constants/textstyle_constants.dart';
import 'package:six_me_ludo_android/providers/app_provider.dart';
import 'package:six_me_ludo_android/widgets/loading_screen.dart';

import '../../constants/app_constants.dart';
import '../../constants/icon_constants.dart';
import '../../services/authentication_service.dart';
import '../../services/translations/dialogue_service.dart';
import '../../widgets/custom_elevated_button.dart';
import '../../widgets/legal_text.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    AppProvider appProvider = context.watch<AppProvider>();

    return appProvider.isLoading
        ? const LoadingScreen()
        : Scaffold(
            body: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Spacer(),
                  Container(
                    width: Get.width * 1 / 2,
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: FittedBox(
                      fit: BoxFit.fitWidth,
                      child: Text(
                        DialogueService.welcomeEmojiText.tr,
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.onSurface,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Text(
                      DialogueService.welcomeSubtileText.tr,
                      style: TextStyles.legalTextStyleBold(Theme.of(context).colorScheme.onSurface),
                    ),
                  ),
                  // const Spacer(),
                  Lottie.asset(
                    AppConstants.authLottieAssetPath,
                    repeat: true,
                    fit: BoxFit.cover,
                  ),
                  //  const Spacer(),
                  SizedBox(
                    width: Get.width * 2 / 3,
                    child: CustomElevatedButton(
                      iconData: AppIcons.googleIcon,
                      onPressed: () {
                        AuthenticationService.signInWithGoogle(context);
                      },
                      text: DialogueService.signInGoogleText.tr,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(
                      child: Text(
                        DialogueService.orButtonText.tr,
                        style: TextStyles.legalTextStyleBold(Theme.of(context).colorScheme.onSurface),
                      ),
                    ),
                  ),
                  Column(
                    children: [
                      SizedBox(
                        width: Get.width * 2 / 3,
                        child: CustomElevatedButton(
                          iconData: AppIcons.anonIcon,
                          onPressed: () {
                            AuthenticationService.signInAnon(context);
                          },
                          text: DialogueService.signInAnonText.tr,
                        ),
                      ),
                      Text(
                        DialogueService.anonWarningText.tr,
                        style: TextStyles.legalTextStyleBold(
                          Theme.of(context).colorScheme.primary,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                  const Spacer(),
                  const LegalText(),
                ],
              ),
            ),
          );
  }
}
