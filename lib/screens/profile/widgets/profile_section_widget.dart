import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:six_me_ludo_android/constants/app_constants.dart';
import 'package:six_me_ludo_android/screens/profile/widgets/profile_avatar_widget.dart';
import 'package:six_me_ludo_android/screens/profile/widgets/profile_reputation_widget.dart';
import 'package:six_me_ludo_android/screens/profile/widgets/profile_title_widget.dart';
import 'package:six_me_ludo_android/widgets/custom_animated_crossfade.dart';
import 'package:six_me_ludo_android/widgets/edit_profile_widget.dart';
import 'package:six_me_ludo_android/widgets/reputation_widget.dart';

import '../../../providers/user_provider.dart';
import '../../../services/translations/dialogue_service.dart';
import '../../../widgets/custom_list_tile.dart';
import '../../../widgets/custom_textfield_widget.dart';

class ProfileSectionWidget extends StatelessWidget {
  const ProfileSectionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    UserProvider userProvider = context.watch<UserProvider>();

    return SizedBox(
      height: AppConstants.customAppbarHeight,
      child: Center(
        child: Column(
          children: [
            const ProfileAvatarWidget(),
            CustomListTileWidget(
              contentPadding: userProvider.isEditingProfile ? const EdgeInsets.only(left: 16) : EdgeInsets.zero,
              leading: userProvider.isEditingProfile
                  ? null
                  : Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ReputationWidget(
                          value: userProvider.getUserReputationValue(),
                          color: Get.isDarkMode ? Theme.of(context).colorScheme.onBackground : Theme.of(context).colorScheme.onPrimary,
                          shouldPad: true,
                        ),
                      ],
                    ),
              title: CustomAnimatedCrossFade(
                  firstChild: Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: CustomTextFieldWidget(
                      controller: userProvider.pseudonymController,
                      hint: DialogueService.changePseudonymHintText.tr,
                      maxLength: AppConstants.maxPseudonymLength,
                    ),
                  ),
                  secondChild: const ProfilePseudonymWidget(),
                  condition: userProvider.isEditingProfile),
              subtitle: userProvider.isEditingProfile ? null : const ProfileStatusWidget(),
              trailing: const EditProfileButton(),
            ),
          ],
        ),
      ),
    );
  }
}
