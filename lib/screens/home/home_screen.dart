import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:six_me_ludo_android/providers/dynamic_link_provider.dart';
import 'package:six_me_ludo_android/providers/nav_provider.dart';

import 'package:six_me_ludo_android/screens/home/widgets/on_going_games/ongoing_games_list.dart';
import 'package:six_me_ludo_android/screens/home/widgets/drawer_button_widget.dart';
import 'package:six_me_ludo_android/screens/home/widgets/home_drawer.dart';
import 'package:six_me_ludo_android/widgets/app_bar_avatar_widget.dart';

import '../../providers/app_provider.dart';
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

    return WillPopScope(
      onWillPop: () async {
        navProvider.handleHomeWrapperBackPress(context);
        return false;
      },
      child: appProvider.isLoading
          ? const LoadingScreen()
          : const Scaffold(
              drawer: HomeDrawerWidget(),
              appBar: CustomAppBarWidget(
                leading: DrawerButtonWidget(),
                title: WelcomeAppbarTitleText(),
                actions: [AppBarAvatarWidget()],
              ),
              body: OngoingGamesListWidget(),
            ),
    );
  }
}
