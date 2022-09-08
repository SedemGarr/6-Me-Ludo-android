import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:six_me_ludo_android/providers/user_provider.dart';
import 'package:six_me_ludo_android/screens/home/widgets/new_game_fab.dart';
import 'package:six_me_ludo_android/screens/home/widgets/on_going_games/ongoing_games_list.dart';
import 'package:six_me_ludo_android/widgets/app_bar_avatar_widget.dart';
import 'package:six_me_ludo_android/widgets/app_bar_title_widget.dart';

import '../../utils/utils.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    UserProvider userProvider = context.watch<UserProvider>();

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
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(8),
            child: Container(),
          ),
        ),
        body: const OngoingGamesListWidget(),
        floatingActionButton: userProvider.hasReachedOngoingGamesLimit() ? null : const NewGameFAB(),
      ),
    );
  }
}
