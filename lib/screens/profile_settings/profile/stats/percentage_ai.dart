import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:six_me_ludo_android/providers/user_provider.dart';
import 'package:six_me_ludo_android/screens/profile_settings/profile/stats/widgets/stats_tile_widget.dart';
import 'package:six_me_ludo_android/services/translations/dialogue_service.dart';

import '../../../../models/user.dart';

class PercentageAI extends StatelessWidget {
  const PercentageAI({super.key});

  @override
  Widget build(BuildContext context) {
    UserProvider userProvider = context.read<UserProvider>();
    Users user = userProvider.getUser();

    double percentageAI = user.stats.numberOfGames == 0 ? 0 : (user.stats.numberOfGamesWithOnlyAI / user.stats.numberOfGames) * 100;

    return StatsTileWidget(
      titleText: DialogueService.percentageAITitleText.tr,
      subTitleText: userProvider.parsePercentageAIText(percentageAI),
      trailingText: '${percentageAI.toStringAsFixed(1)}%',
    );
  }
}
