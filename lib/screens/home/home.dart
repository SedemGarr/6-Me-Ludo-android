import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:six_me_ludo_android/providers/app_provider.dart';
import 'package:six_me_ludo_android/providers/user_provider.dart';
import 'package:six_me_ludo_android/screens/home/widgets/on_going_games/ongoing_games_list.dart';
import 'package:six_me_ludo_android/screens/new_game/widgets/new_game_button.dart';
import 'package:six_me_ludo_android/utils/utils.dart';
import 'package:six_me_ludo_android/widgets/app_bar_title_widget.dart';
import 'package:six_me_ludo_android/widgets/custom_sliver_appbar_widget.dart';
import 'package:six_me_ludo_android/widgets/join_game_textfield_widget.dart';

import '../../constants/app_constants.dart';
import '../../services/translations/dialogue_service.dart';
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
              body: CustomScrollView(
                slivers: [
                  CustomSliverAppbarWidget(
                    actions: const [NewGameButton()],
                    centerTitle: false,
                    // leading: Icon(
                    //   AppIcons.appIcon,
                    //   color: Get.isDarkMode ? Theme.of(context).colorScheme.onSurface : Theme.of(context).colorScheme.onPrimary,
                    // ),
                    title: AppBarTitleWidget(
                      text: DialogueService.welcomeText.tr + userProvider.getUserPseudonym(),
                    ),
                    bottom: const PreferredSize(preferredSize: Size.fromHeight(AppConstants.standardTabbarHeight), child: JoinGameTextFieldWidget()),
                  ),
                  const SliverToBoxAdapter(
                    child: OngoingGamesListWidget(),
                  )
                ],
              ),
            ),
    );
  }
}
