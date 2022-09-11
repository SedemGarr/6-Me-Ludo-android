import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:six_me_ludo_android/providers/user_provider.dart';
import 'package:six_me_ludo_android/screens/home/widgets/on_going_games/ongoing_games_list.dart';
import 'package:six_me_ludo_android/widgets/app_bar_avatar_widget.dart';
import 'package:six_me_ludo_android/widgets/app_bar_title_widget.dart';

import '../../services/translations/dialogue_service.dart';
import '../../widgets/custom_appbar.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    UserProvider userProvider = context.watch<UserProvider>();

    return Scaffold(
      appBar: CustomAppBarWidget(
        leading: const AppBarAvatarWidget(),
        centerTitle: true,
        title: AppBarTitleWidget(
          text: DialogueService.welcomeText.tr + userProvider.getUserPseudonym(),
        ),
      ),
      body: const OngoingGamesListWidget(),
    );
  }
}
