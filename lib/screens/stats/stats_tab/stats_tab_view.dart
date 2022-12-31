import 'package:flutter/material.dart';
import 'package:six_me_ludo_android/constants/app_constants.dart';
import 'package:six_me_ludo_android/screens/profile_settings/profile/stats/percentage_human.dart';
import 'package:six_me_ludo_android/widgets/general/custom_card_widget.dart';

import '../../profile_settings/profile/stats/number_of_games.dart';
import '../../profile_settings/profile/stats/percentage_finished.dart';
import '../../profile_settings/profile/stats/percentage_won.dart';

class StatsTabView extends StatelessWidget {
  const StatsTabView({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: AppConstants.listViewPadding,
      children: const [
        CustomCardWidget(child: NumberOfGames()),
        CustomCardWidget(child: PercentageFinished()),
        CustomCardWidget(child: PercentageWon()),
        CustomCardWidget(child: PercentageHuman()),
      ],
    );
  }
}
