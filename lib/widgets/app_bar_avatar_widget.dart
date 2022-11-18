import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:provider/provider.dart';
import 'package:six_me_ludo_android/widgets/user_avatar_widget.dart';

import '../providers/user_provider.dart';

class AppBarAvatarWidget extends StatelessWidget {
  const AppBarAvatarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    UserProvider userProvider = context.watch<UserProvider>();

    return Padding(
      padding: const EdgeInsets.only(
        right: 8.0,
      ),
      child: UserAvatarWidget(
        avatar: userProvider.getUserAvatar(),
        backgroundColor: Get.isDarkMode ? Theme.of(context).primaryColor : Theme.of(context).colorScheme.onPrimary,
        borderColor: Theme.of(context).colorScheme.onBackground,
        id: userProvider.getUserID(),
        hasLeftGame: false,
      ),
    );
  }
}
