import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:six_me_ludo_android/screens/profile/widgets/profile_avatar_widget.dart';
import 'package:six_me_ludo_android/screens/profile/widgets/profile_reputation_widget.dart';
import 'package:six_me_ludo_android/screens/profile/widgets/profile_title_widget.dart';
import 'package:six_me_ludo_android/screens/profile/widgets/settings/widgets/settings_header.dart';
import 'package:six_me_ludo_android/services/navigation_service.dart';
import 'package:six_me_ludo_android/widgets/reputation_widget.dart';

import '../../../providers/user_provider.dart';
import '../../../services/translations/dialogue_service.dart';
import '../../../widgets/custom_card_widget.dart';
import '../../../widgets/custom_list_tile.dart';

class ProfileSectionWidget extends StatelessWidget {
  const ProfileSectionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    UserProvider userProvider = context.watch<UserProvider>();

    return CustomCardWidget(
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SettingsHeaderWidget(text: DialogueService.profileText.tr),
            CustomListTileWidget(
              onTap: () {
                NavigationService.goToEditPseudonymScreen();
              },
              leading: const ProfileAvatarWidget(),
              title: const ProfilePseudonymWidget(),
              subtitle: const ProfileStatusWidget(),
              trailing: ReputationWidget(
                value: userProvider.getUserReputationValue(),
                color: Theme.of(context).colorScheme.onBackground,
                shouldPad: false,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
