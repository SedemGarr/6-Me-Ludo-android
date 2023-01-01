import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:six_me_ludo_android/providers/user_provider.dart';
import 'package:six_me_ludo_android/screens/profile_settings/profile/stats/widgets/stats_tile_widget.dart';
import 'package:six_me_ludo_android/services/translations/dialogue_service.dart';

import '../../../../models/user.dart';
import '../../../../providers/app_provider.dart';

class KickerKickedRatio extends StatelessWidget {
  const KickerKickedRatio({super.key});

  @override
  Widget build(BuildContext context) {
    UserProvider userProvider = context.read<UserProvider>();
    Users user = userProvider.getUser();

    int numberOfKicks = user.stats.numberOfKicks;
    int numberOfTimesBeingKicked = user.stats.numberOfTimesBeingKicked;

    return StatsTileWidget(
      titleText: DialogueService.kickerRatioTitleText.tr,
      subTitleText: DialogueService.kickerRatioSubtitleText.tr,
      trailingText: '$numberOfKicks / $numberOfTimesBeingKicked',
        onTap: () {
        AppProvider.showToast(DialogueService.kickerRatioSubtitleText.tr);
      },
    );
  }
}
