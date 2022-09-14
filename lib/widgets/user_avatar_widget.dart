import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:six_me_ludo_android/providers/user_provider.dart';
import 'package:six_me_ludo_android/widgets/multiavatar_widget.dart';

import '../constants/app_constants.dart';
import '../models/user.dart';

class UserAvatarWidget extends StatelessWidget {
  final Users user;
  final bool isBackgroundTransparent;

  const UserAvatarWidget({super.key, required this.user, required this.isBackgroundTransparent});

  @override
  Widget build(BuildContext context) {
    UserProvider userProvider = context.watch<UserProvider>();

    return GestureDetector(
      onTap: () {
        userProvider.handleUserAvatarOnTap(user.id, context);
      },
      child: CircleAvatar(
        backgroundColor: Get.isDarkMode ? Theme.of(context).colorScheme.onSurface : Theme.of(context).colorScheme.onPrimary,
        child: Padding(
          padding: AppConstants.userAvatarAppBarPadding,
          child: MultiAvatarWidget(avatar: user.avatar, isBackgroundTransparent: isBackgroundTransparent),
        ),
      ),
    );
  }
}
