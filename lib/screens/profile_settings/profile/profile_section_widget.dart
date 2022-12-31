import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:six_me_ludo_android/screens/profile_settings/profile/profile_avatar_widget.dart';
import 'package:six_me_ludo_android/screens/profile_settings/profile/profile_title_widget.dart';
import 'package:six_me_ludo_android/screens/profile_settings/profile/stats/number_of_games.dart';
import 'package:six_me_ludo_android/screens/profile_settings/profile/stats/percentage_finished.dart';
import 'package:six_me_ludo_android/screens/profile_settings/profile/stats/percentage_won.dart';
import 'package:six_me_ludo_android/screens/profile_settings/profile/stats/widgets/see_more_stats.dart';

import '../../../constants/app_constants.dart';
import '../../../providers/user_provider.dart';
import '../../../services/translations/dialogue_service.dart';
import '../../../widgets/general/custom_card_widget.dart';
import '../../../widgets/user/reputation_widget.dart';
import '../settings/widgets/settings_header.dart';
import 'profile_reputation_widget.dart';

class ProfileSectionWidget extends StatelessWidget {
  const ProfileSectionWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    UserProvider userProvider = context.watch<UserProvider>();

    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SettingsHeaderWidget(text: DialogueService.profileText.tr),
          CustomCardWidget(
            child: Theme(
              data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
              child: ClipRRect(
                borderRadius: AppConstants.appBorderRadius,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: AppConstants.appBorderRadius,
                  ),
                  child: ExpansionTile(
                    leading: const ProfileAvatarWidget(),
                    title: const ProfilePseudonymWidget(),
                    subtitle: const ProfileStatusWidget(),
                    trailing: ReputationWidget(
                      value: userProvider.getUserReputationValue(),
                      color: Theme.of(context).colorScheme.secondary,
                      shouldPad: false,
                    ),
                    childrenPadding: const EdgeInsets.symmetric(horizontal: 8.0),
                    children: const [
                      NumberOfGames(),
                      PercentageFinished(),
                      PercentageWon(),
                      SeeMoreStatsButton(),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
