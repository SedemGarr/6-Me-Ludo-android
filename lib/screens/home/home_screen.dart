import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:six_me_ludo_android/constants/app_constants.dart';
import 'package:six_me_ludo_android/providers/dynamic_link_provider.dart';
import 'package:six_me_ludo_android/providers/game_provider.dart';
import 'package:six_me_ludo_android/providers/nav_provider.dart';
import 'package:six_me_ludo_android/providers/user_provider.dart';
import 'package:six_me_ludo_android/screens/home/panel.dart';
import 'package:six_me_ludo_android/screens/home/widgets/local_games/local_game_widget.dart';

import 'package:six_me_ludo_android/screens/home/widgets/on_going_games/ongoing_games_list.dart';
import 'package:six_me_ludo_android/services/translations/dialogue_service.dart';

import 'package:six_me_ludo_android/widgets/buttons/settings_button.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

import '../../providers/app_provider.dart';
import '../../widgets/appbar/app_bar_avatar_widget.dart';
import '../../widgets/appbar/custom_appbar.dart';
import '../../widgets/general/custom_animated_crossfade.dart';
import '../../widgets/loading/loading_screen.dart';
import '../../widgets/appbar/welcome_appbar_text_widget.dart';
import '../../widgets/text/banner_widget.dart';

class HomeScreen extends StatefulWidget {
  static String routeName = '/HomeScreen';

  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late DynamicLinkProvider dynamicLinkProvider;

  @override
  void initState() {
    super.initState();
    dynamicLinkProvider = context.read();
    dynamicLinkProvider.handleDynamicLinks();
  }

  @override
  Widget build(BuildContext context) {
    NavProvider navProvider = context.watch<NavProvider>();
    AppProvider appProvider = context.watch<AppProvider>();
    UserProvider userProvider = context.watch<UserProvider>();

    bool shouldPanelHide = userProvider.getUserIsOffline() && GameProvider.isThereLocalGame();
    bool shouldPanelHaveHalfHeight = userProvider.getUserIsOffline() && !GameProvider.isThereLocalGame();

    return WillPopScope(
      onWillPop: () async {
        navProvider.handleHomeWrapperBackPress(context);
        return false;
      },
      child: appProvider.isLoading
          ? const LoadingScreen()
          : Scaffold(
              appBar: const CustomAppBarWidget(
                title: WelcomeAppbarTitleText(),
                leading: AppBarAvatarWidget(),
                actions: [SettingsButton()],
              ),
              body: SlidingUpPanel(
                body: Column(
                  children: [
                    CustomAnimatedCrossFade(
                      firstChild: BannerWidget(text: DialogueService.offlineText.tr),
                      secondChild: const SizedBox.shrink(),
                      condition: userProvider.getUserIsOffline(),
                    ),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: GameProvider.isThereLocalGame() ? MainAxisAlignment.start : MainAxisAlignment.center,
                        children: [
                          userProvider.getUserIsOffline() ? const LocalGameWidget() : const OngoingGamesListWidget(),
                        ],
                      ),
                    ),
                  ],
                ),
                panelBuilder: (sc) {
                  return shouldPanelHide ? const SizedBox.shrink() : const GameOptionsPanel();
                },
                panelSnapping: true,
                backdropEnabled: true,
                backdropTapClosesPanel: true,
                backdropOpacity: 0.0,
                minHeight: shouldPanelHide
                    ? 0
                    : shouldPanelHaveHalfHeight
                        ? Get.height * 0.05
                        : Get.height * 0.05,
                maxHeight: shouldPanelHide
                    ? 0
                    : shouldPanelHaveHalfHeight
                        ? (Get.height * 0.17) / 1.5
                        : Get.height * 0.17,
                color: Theme.of(context).scaffoldBackgroundColor,
                borderRadius: AppConstants.appBorderRadius,
              ),
            ),
    );
  }
}
