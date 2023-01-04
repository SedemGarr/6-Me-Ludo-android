import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:six_me_ludo_android/constants/textstyle_constants.dart';
import 'package:six_me_ludo_android/screens/stats/leaderboard_tab/leaderboard_tab_view.dart';
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
                text: DialogueService.leaderboardTabText.tr,
              ),
            ],
            labelStyle: TextStyles.appTextStyle,
            unselectedLabelStyle: TextStyles.appTextStyle,
            indicatorColor: Get.isDarkMode ? Theme.of(context).colorScheme.primary : null,
          ),
          size: AppConstants.customAppbarWithTabbarHeight,
        ),
        body: const TabBarView(
          children: [
            StatsTabView(),
            LeaderboardTabView(),
          ],
        ),
      ),
    );
  }
}
