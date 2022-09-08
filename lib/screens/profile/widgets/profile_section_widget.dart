import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:six_me_ludo_android/screens/profile/widgets/profile_avatar_widget.dart';
import 'package:six_me_ludo_android/screens/profile/widgets/profile_reputation_widget.dart';
import 'package:six_me_ludo_android/screens/profile/widgets/profile_title_widget.dart';
import 'package:six_me_ludo_android/widgets/edit_profile_widget.dart';
import 'package:six_me_ludo_android/widgets/reputation_widget.dart';

import '../../../providers/user_provider.dart';

class ProfileSectionWidget extends StatelessWidget {
  const ProfileSectionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    UserProvider userProvider = context.watch<UserProvider>();

    return Container(
      color: Get.isDarkMode ? null : Theme.of(context).primaryColor,
      height: Get.height * 1 / 4,
      child: Center(
        child: Column(
          children: [
            const ProfileAvatarWidget(),
            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: const EditProfileButton(),
              title: const ProfilePseudonymWidget(),
              subtitle: const ProfileReputationWidget(),
              trailing: ReputationWidget(
                value: userProvider.getUserReputationValue(),
                color: Get.isDarkMode ? Theme.of(context).colorScheme.onSurface : Theme.of(context).colorScheme.onPrimary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
