import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:six_me_ludo_android/providers/user_provider.dart';
import 'package:six_me_ludo_android/screens/profile_settings/profile/stats/widgets/stats_tile_widget.dart';
import 'package:six_me_ludo_android/services/translations/dialogue_service.dart';

import '../../../../models/user.dart';

class PercentageVicious extends StatelessWidget {
  const PercentageVicious({super.key});

  @override
  Widget build(BuildContext context) {
    UserProvider userProvider = context.read<UserProvider>();
    Users user = userProvider.getUser();

    double percentageVicious = user.stats.numberOfGames == 0 ? 0 : (user.stats.numberOfTimesBeingViciousPlayer / user.stats.numberOfGames) * 100;

    return StatsTileWidget(
      titleText: DialogueService.percentageViciousTitleText.tr,
      subTitleText: userProvider.parsePercentageViciousText(percentageVicious),
      trailingText: '${percentageVicious.toStringAsFixed(1)}%',
    );
  }
}
