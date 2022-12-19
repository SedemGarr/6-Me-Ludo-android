import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:six_me_ludo_android/providers/dynamic_link_provider.dart';
import 'package:six_me_ludo_android/providers/nav_provider.dart';
import 'package:six_me_ludo_android/providers/user_provider.dart';
import 'package:six_me_ludo_android/screens/home/widgets/local_games/local_game_widget.dart';

import 'package:six_me_ludo_android/screens/home/widgets/on_going_games/ongoing_games_list.dart';
import 'package:six_me_ludo_android/screens/home/widgets/drawer_button_widget.dart';
import 'package:six_me_ludo_android/screens/home/widgets/home_drawer.dart';
import 'package:six_me_ludo_android/services/translations/dialogue_service.dart';
import 'package:six_me_ludo_android/widgets/app_bar_avatar_widget.dart';
import 'package:six_me_ludo_android/widgets/banner_widget.dart';
import 'package:six_me_ludo_android/widgets/custom_animated_crossfade.dart';

import '../../providers/app_provider.dart';
import '../../services/local_storage_service.dart';
import '../../widgets/custom_appbar.dart';
import '../../widgets/loading_screen.dart';
import '../../widgets/welcome_appbar_text_widget.dart';

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

    return WillPopScope(
      onWillPop: () async {
        navProvider.handleHomeWrapperBackPress(context);
        return false;
      },
      child: appProvider.isLoading
          ? const LoadingScreen()
          : Scaffold(
              drawer: const HomeDrawerWidget(),
              appBar: const CustomAppBarWidget(
                leading: DrawerButtonWidget(),
                title: WelcomeAppbarTitleText(),
                actions: [AppBarAvatarWidget()],
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
                      mainAxisAlignment: LocalStorageService.isThereLocalGame() ? MainAxisAlignment.start : MainAxisAlignment.center,
                      children: [
                        userProvider.getUserIsOffline() ? const LocalGameWidget() : const OngoingGamesListWidget(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
