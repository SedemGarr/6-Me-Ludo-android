import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:six_me_ludo_android/providers/app_provider.dart';
import 'package:six_me_ludo_android/providers/user_provider.dart';
import 'package:six_me_ludo_android/screens/home/widgets/on_going_games/ongoing_games_list.dart';
import 'package:six_me_ludo_android/screens/new_game/widgets/new_game_button.dart';
import 'package:six_me_ludo_android/utils/utils.dart';
import 'package:six_me_ludo_android/widgets/app_bar_avatar_widget.dart';
import 'package:six_me_ludo_android/widgets/app_bar_title_widget.dart';
import 'package:six_me_ludo_android/widgets/join_game_textfield_widget.dart';

import '../../constants/app_constants.dart';
import '../../services/translations/dialogue_service.dart';
import '../../widgets/custom_appbar.dart';
import '../../widgets/loading_screen.dart';

class HomeScreen extends StatelessWidget {
  static int routeIndex = 0;

  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    UserProvider userProvider = context.watch<UserProvider>();
    AppProvider appProvider = context.watch<AppProvider>();

    return GestureDetector(
      onTap: () {
        Utils.dismissKeyboard();
      },
      child: appProvider.isLoading
          ? const LoadingScreen()
          : Scaffold(
              appBar: CustomAppBarWidget(
                actions: const [NewGameButton()],
                leading: const AppBarAvatarWidget(),
                title: AppBarTitleWidget(
                  text: DialogueService.welcomeText.tr + userProvider.getUserPseudonym(),
                ),
                bottom: PreferredSize(preferredSize: Size.fromHeight(AppConstants.homeAppBarHeight), child: const JoinGameTextFieldWidget()),
                size: AppConstants.homeAppBarHeight,
              ),
              body: const OngoingGamesListWidget(),
            ),
    );
  }
}
