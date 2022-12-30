import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:six_me_ludo_android/screens/profile/widgets/profile_avatar_widget.dart';
import 'package:six_me_ludo_android/screens/profile/widgets/profile_reputation_widget.dart';
import 'package:six_me_ludo_android/screens/profile/widgets/profile_title_widget.dart';
import 'package:six_me_ludo_android/screens/profile/widgets/settings/widgets/settings_header.dart';
import 'package:six_me_ludo_android/services/navigation_service.dart';

import '../../../providers/user_provider.dart';
import '../../../services/translations/dialogue_service.dart';
import '../../../widgets/general/custom_card_widget.dart';
import '../../../widgets/general/custom_list_tile.dart';
import '../../../widgets/user/reputation_widget.dart';

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
            child: CustomListTileWidget(
              onTap: () {
                NavigationService.goToEditPseudonymScreen();
              },
              leading: const ProfileAvatarWidget(),
              title: const ProfilePseudonymWidget(),
              subtitle: const ProfileStatusWidget(),
              trailing: ReputationWidget(
                value: userProvider.getUserReputationValue(),
                color: Theme.of(context).colorScheme.secondary,
                shouldPad: false,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
