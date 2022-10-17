import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:six_me_ludo_android/constants/icon_constants.dart';
import 'package:six_me_ludo_android/providers/user_provider.dart';
import 'package:six_me_ludo_android/widgets/custom_animated_crossfade.dart';

class EditProfileButton extends StatelessWidget {
  const EditProfileButton({super.key});

  @override
  Widget build(BuildContext context) {
    UserProvider userProvider = context.watch<UserProvider>();

    return IconButton(
      onPressed: () {
        if (!userProvider.isEditingProfile) {
          userProvider.setPseudonymControllerValue(userProvider.getUserPseudonym());
        }
        userProvider.toggleIsEditingProfile(!userProvider.isEditingProfile);
      },
      icon: CustomAnimatedCrossFade(
          firstChild: Icon(
            AppIcons.editProfileIcon,
            color: Get.isDarkMode ? Theme.of(context).primaryColor : Theme.of(context).colorScheme.onPrimary,
          ),
          secondChild: Icon(
            AppIcons.editDoneProfileIcon,
            color: Get.isDarkMode ? Theme.of(context).primaryColor : Theme.of(context).colorScheme.onPrimary,
          ),
          condition: !userProvider.isEditingProfile),
    );
  }
}
