import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:six_me_ludo_android/constants/app_constants.dart';
import 'package:six_me_ludo_android/constants/icon_constants.dart';
import 'package:six_me_ludo_android/constants/textstyle_constants.dart';
import 'package:six_me_ludo_android/services/translations/dialogue_service.dart';
import 'package:six_me_ludo_android/utils/utils.dart';
import 'package:six_me_ludo_android/widgets/app_bar_title_widget.dart';
import 'package:six_me_ludo_android/widgets/custom_appbar.dart';
import 'package:six_me_ludo_android/widgets/custom_elevated_button.dart';
import 'package:six_me_ludo_android/widgets/custom_text_button.dart';

class UpgradeScreen extends StatelessWidget {
  const UpgradeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Utils.exitApp();
        return false;
      },
      child: Scaffold(
        appBar: CustomAppBarWidget(
          title: AppBarTitleWidget(text: DialogueService.updateNeededText.tr),
          centerTitle: true,
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Spacer(),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Icon(
                        AppIcons.appIcon,
                        color: Theme.of(context).primaryColor,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          DialogueService.updatePromptText.tr,
                          textAlign: TextAlign.center,
                          style: TextStyles.listTitleStyle(Theme.of(context).colorScheme.onSurface),
                        ),
                      ),
                    ],
                  ),
                ),
                CustomElevatedButton(
                  onPressed: () {
                    Utils.openURL(AppConstants.playStoreURL);
                  },
                  text: DialogueService.updateButtonText.tr,
                ),
                const Spacer(),
                CustomTextButton(
                  onPressed: () {
                    Utils.showExitDialog(context);
                  },
                  text: DialogueService.exitAppDialogYesText.tr,
                  color: Theme.of(context).colorScheme.primary,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
