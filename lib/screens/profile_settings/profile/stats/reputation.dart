import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:six_me_ludo_android/providers/user_provider.dart';
import 'package:six_me_ludo_android/screens/profile_settings/profile/stats/widgets/stats_tile_widget.dart';
import 'package:six_me_ludo_android/services/translations/dialogue_service.dart';

class ReputationStat extends StatelessWidget {
  const ReputationStat({super.key});

  @override
  Widget build(BuildContext context) {
    UserProvider userProvider = context.read<UserProvider>();

    return StatsTileWidget(
      titleText: DialogueService.reputationTitleText.tr,
      subTitleText: userProvider.getUserReputationValueAsString(),
      trailingText: userProvider.getUserReputationValue().toStringAsFixed(1),
    );
  }
}
