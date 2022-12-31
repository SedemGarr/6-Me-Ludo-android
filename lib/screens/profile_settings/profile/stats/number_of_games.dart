import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:six_me_ludo_android/providers/user_provider.dart';
import 'package:six_me_ludo_android/screens/profile_settings/profile/stats/widgets/stats_tile_widget.dart';
import 'package:six_me_ludo_android/services/translations/dialogue_service.dart';

import '../../../../models/user.dart';

class NumberOfGames extends StatelessWidget {
  const NumberOfGames({super.key});

  @override
  Widget build(BuildContext context) {
    UserProvider userProvider = context.read<UserProvider>();
    Users user = userProvider.getUser();
    int numberOfGames = user.stats.numberOfGames;

    return StatsTileWidget(
      titleText: DialogueService.numberOfGamesText.tr,
      subTitleText: userProvider.parseNumberOfGamesText(numberOfGames),
      trailingText: numberOfGames.toString(),
    );
  }
}
