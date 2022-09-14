import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:six_me_ludo_android/constants/app_constants.dart';
import 'package:six_me_ludo_android/utils/utils.dart';
import 'package:six_me_ludo_android/widgets/change_avatar_dialog.dart';

import '../../../providers/user_provider.dart';
import '../../../widgets/multiavatar_widget.dart';

class ProfileAvatarWidget extends StatelessWidget {
  const ProfileAvatarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    UserProvider userProvider = context.watch<UserProvider>();

    return Flexible(
      child: GestureDetector(
        onTap: () {
          showChangeAvatarDialog(
            context: context,
            avatarList: Utils.generateAvatarSelectionCodes(userProvider.getUserAvatar()),
          );
        },
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: Get.isDarkMode ? Theme.of(context).primaryColor : Theme.of(context).colorScheme.onPrimary,
            ),
            shape: BoxShape.circle,
            color: Get.isDarkMode ? Theme.of(context).primaryColor : Theme.of(context).colorScheme.onPrimary,
          ),
          child: Padding(
            padding: AppConstants.userAvatarPadding,
            child: MultiAvatarWidget(avatar: userProvider.getUserAvatar(), isBackgroundTransparent: true),
          ),
        ),
      ),
    );
  }
}
