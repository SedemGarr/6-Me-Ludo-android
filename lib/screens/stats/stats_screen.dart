import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:six_me_ludo_android/screens/stats/achievements_tab/achievements_tab_view.dart';
import 'package:six_me_ludo_android/screens/stats/stats_tab/stats_tab_view.dart';
import 'package:six_me_ludo_android/services/navigation_service.dart';
import 'package:six_me_ludo_android/services/translations/dialogue_service.dart';
import 'package:six_me_ludo_android/widgets/appbar/app_bar_title_widget.dart';
import 'package:six_me_ludo_android/widgets/appbar/custom_appbar.dart';
import 'package:six_me_ludo_android/widgets/buttons/back_button_widget.dart';

import '../../constants/app_constants.dart';

class StatsScreen extends StatelessWidget {
  const StatsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: CustomAppBarWidget(
          leading: BackButtonWidget(
            onPressed: () {
              NavigationService.genericGoBack();
            },
          ),
          title: AppBarTitleWidget(text: DialogueService.statsAppBarTitleText.tr),
          bottom: TabBar(
            tabs: [
              Tab(
                text: DialogueService.statsTabText.tr,
              ),
              Tab(
                text: DialogueService.achievementsTabText.tr,
              ),
            ],
            // unselectedLabelColor: Theme.of(context).,
            // labelColor: ThemeProvider.getContrastingColor(gameProvider.playerColor),
            indicatorColor: Get.isDarkMode ? Theme.of(context).colorScheme.secondary : null,
          ),
          size: AppConstants.customAppbarWithTabbarHeight,
        ),
        body: const TabBarView(
          children: [
            StatsTabView(),
            AchievementsTabView(),
          ],
        ),
      ),
    );
  }
}
