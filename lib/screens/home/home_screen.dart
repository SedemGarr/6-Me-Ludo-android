import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:six_me_ludo_android/providers/dynamic_link_provider.dart';
import 'package:six_me_ludo_android/providers/game_provider.dart';
import 'package:six_me_ludo_android/providers/nav_provider.dart';
import 'package:six_me_ludo_android/providers/user_provider.dart';
import 'package:six_me_ludo_android/screens/home/widgets/local_games/local_game_widget.dart';

import 'package:six_me_ludo_android/screens/home/widgets/on_going_games/ongoing_games_list.dart';
import 'package:six_me_ludo_android/services/translations/dialogue_service.dart';

import 'package:six_me_ludo_android/widgets/buttons/settings_button.dart';
import 'package:six_me_ludo_android/widgets/dialogs/new_game_dialog.dart';

import '../../providers/app_provider.dart';
import '../../widgets/appbar/app_bar_avatar_widget.dart';
import '../../widgets/appbar/custom_appbar.dart';
import '../../widgets/buttons/custom_elevated_button.dart';
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
  late UserProvider userProvider;

  @override
  void initState() {
    super.initState();
    dynamicLinkProvider = context.read<DynamicLinkProvider>();
    userProvider = context.read<UserProvider>();
    userProvider.syncUser(false);
    dynamicLinkProvider.handleDynamicLinks();
  }

  @override
  Widget build(BuildContext context) {
    NavProvider navProvider = context.watch<NavProvider>();
    AppProvider appProvider = context.watch<AppProvider>();
    UserProvider userProvider = context.watch<UserProvider>();
    GameProvider gameProvider = context.watch<GameProvider>();

    bool shouldHideNewGameButton = userProvider.getUserIsOffline() && GameProvider.isThereLocalGame();
    // bool shouldPanelHaveHalfHeight = userProvider.getUserIsOffline() && !GameProvider.isThereLocalGame();

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
              bottomSheet: shouldHideNewGameButton
                  ? null
                  : Container(
                      width: Get.width,
                      padding: const EdgeInsets.all(8.0),
                      child: CustomElevatedButton(
                        onPressed: () {
                          showNewGameDialog(
                            context: context,
                            gameProvider: gameProvider,
                            userProvider: userProvider,
                          );
                        },
                        text: DialogueService.newGameText.tr,
                      ),
                    ),
            ),
    );
  }
}
