import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:six_me_ludo_android/providers/app_provider.dart';
import 'package:six_me_ludo_android/providers/nav_provider.dart';
import 'package:six_me_ludo_android/providers/user_provider.dart';
import 'package:six_me_ludo_android/screens/home/widgets/new_game/new_game.dart';
import 'package:six_me_ludo_android/screens/home/widgets/on_going_games/ongoing_games_list.dart';
import 'package:six_me_ludo_android/utils/utils.dart';
import 'package:six_me_ludo_android/widgets/app_bar_avatar_widget.dart';
import 'package:six_me_ludo_android/widgets/app_bar_title_widget.dart';

import '../../constants/app_constants.dart';
import '../../services/translations/dialogue_service.dart';
import '../../widgets/custom_appbar.dart';
import '../../widgets/loading_screen.dart';

class HomeScreen extends StatefulWidget {
  static int routeIndex = 0;

  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  @override
  void initState() {
    super.initState();
    NavProvider navProvider = context.read<NavProvider>();
    navProvider.initialiseHomeScreenTabController(this, 2);
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    UserProvider userProvider = context.watch<UserProvider>();
    AppProvider appProvider = context.watch<AppProvider>();
    NavProvider navProvider = context.watch<NavProvider>();

    return GestureDetector(
      onTap: () {
        Utils.dismissKeyboard();
      },
      child: appProvider.isLoading
          ? const LoadingScreen()
          : Scaffold(
              appBar: CustomAppBarWidget(
                leading: const AppBarAvatarWidget(),
                title: AppBarTitleWidget(
                  text: DialogueService.welcomeText.tr + userProvider.getUserPseudonym(),
                ),
                bottom: PreferredSize(
                  preferredSize: Size.fromHeight(AppConstants.customAppbarWithTabbarHeight),
                  child: TabBar(
                    controller: navProvider.homeScreenTabController,
                    tabs: [
                      Tab(
                        text: DialogueService.ongoingGamesText.tr,
                      ),
                      Tab(
                        text: DialogueService.newGamesText.tr,
                      ),
                    ],
                  ),
                ),
                size: AppConstants.customAppbarWithTabbarHeight,
              ),
              body: TabBarView(controller: navProvider.homeScreenTabController, children: const [OngoingGamesListWidget(), NewGameView()]),
            ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
