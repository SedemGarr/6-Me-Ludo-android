import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:six_me_ludo_android/constants/constants.dart';
import 'package:six_me_ludo_android/screens/home/widgets/ongoing_games_list.dart';
import 'package:six_me_ludo_android/services/translations/dialogue_service.dart';
import 'package:six_me_ludo_android/widgets/app_bar_avatar_widget.dart';
import 'package:six_me_ludo_android/widgets/app_bar_title_widget.dart';
import 'package:six_me_ludo_android/widgets/custom_text_button.dart';
import 'package:six_me_ludo_android/widgets/info_button_widget.dart';

import '../../utils/utils.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Utils.showExitDialog(context);
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          leading: const AppBarAvatarWidget(),
          title: const AppBarTitleWidget(),
          actions: const [InfoButtonWidget()],
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(Get.statusBarHeight * 1 / 3),
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  CustomTextButton(
                    onPressed: () {},
                    text: DialogueService.startGameButtonText.tr,
                    color: Get.isDarkMode ? Theme.of(context).colorScheme.onSurface : Theme.of(context).colorScheme.onPrimary,
                  ),
                  Text(
                    DialogueService.orButtonText.tr,
                    style: TextStyles.appBarBottomOrStyle(Get.isDarkMode ? Theme.of(context).colorScheme.onSurface : Theme.of(context).colorScheme.onPrimary),
                  ),
                  CustomTextButton(
                    onPressed: () {},
                    text: DialogueService.joinGameButtonText.tr,
                    color: Get.isDarkMode ? Theme.of(context).colorScheme.onSurface : Theme.of(context).colorScheme.onPrimary,
                  )
                ],
              ),
            ),
          ),
        ),
        body: const OngoingGamesListWidget(),
      ),
    );
  }
}
