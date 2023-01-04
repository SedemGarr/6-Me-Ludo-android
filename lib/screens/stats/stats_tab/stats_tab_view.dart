import 'package:flutter/material.dart';
import 'package:six_me_ludo_android/constants/app_constants.dart';
import 'package:six_me_ludo_android/screens/profile_settings/profile/stats/cummulative_time.dart';
import 'package:six_me_ludo_android/screens/profile_settings/profile/stats/favourite_color.dart';
import 'package:six_me_ludo_android/screens/profile_settings/profile/stats/kicker_kicked_ratio.dart';
import 'package:six_me_ludo_android/screens/profile_settings/profile/stats/percentage_ai.dart';
import 'package:six_me_ludo_android/screens/profile_settings/profile/stats/percentage_human.dart';
import 'package:six_me_ludo_android/screens/profile_settings/profile/stats/percentage_mixed.dart';
import 'package:six_me_ludo_android/screens/profile_settings/profile/stats/percentage_pb.dart';
import 'package:six_me_ludo_android/screens/profile_settings/profile/stats/percentage_v.dart';
import 'package:six_me_ludo_android/screens/profile_settings/profile/stats/reputation.dart';
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
        CustomCardWidget(child: CummulativeTime()),
        CustomCardWidget(child: NumberOfGames()),
        CustomCardWidget(child: PercentageFinished()),
        CustomCardWidget(child: PercentageWon()),
        CustomCardWidget(child: PercentageHuman()),
        CustomCardWidget(child: PercentageAI()),
        CustomCardWidget(child: PercentageMixed()),
        CustomCardWidget(child: ReputationStat()),
        CustomCardWidget(child: PercentageVicious()),
        CustomCardWidget(child: PercentagePunchingBag()),
        CustomCardWidget(child: KickerKickedRatio()),
        CustomCardWidget(child: FavouriteColour()),
      ],
    );
  }
}
