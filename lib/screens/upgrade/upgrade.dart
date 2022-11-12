import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:six_me_ludo_android/constants/app_constants.dart';
import 'package:six_me_ludo_android/constants/textstyle_constants.dart';
import 'package:six_me_ludo_android/services/translations/dialogue_service.dart';
import 'package:six_me_ludo_android/utils/utils.dart';
import 'package:six_me_ludo_android/widgets/app_bar_title_widget.dart';
import 'package:six_me_ludo_android/widgets/custom_appbar.dart';
import 'package:six_me_ludo_android/widgets/custom_elevated_button.dart';

import '../../widgets/custom_outlined_button.dart';
import '../../widgets/title_widget.dart';

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
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TitleWidget(
                      width: MediaQuery.of(context).size.width * 0.25,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      DialogueService.updatePromptText.tr,
                      textAlign: TextAlign.center,
                      style: TextStyles.listTitleStyle(Theme.of(context).colorScheme.onBackground),
                    ),
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                CustomOutlinedButton(
                  onPressed: () {
                    Utils.showExitDialog(context);
                  },
                  text: DialogueService.exitAppDialogYesText.tr,
                  color: Theme.of(context).colorScheme.primary,
                ),
                CustomElevatedButton(
                  onPressed: () {
                    Utils.openURL(AppConstants.playStoreURL);
                  },
                  text: DialogueService.updateButtonText.tr,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
