import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:six_me_ludo_android/providers/user_provider.dart';

import '../../../constants/icon_constants.dart';

class RefreshAvatarListButton extends StatelessWidget {
  const RefreshAvatarListButton({super.key});

  @override
  Widget build(BuildContext context) {
    UserProvider userProvider = context.watch<UserProvider>();

    return IconButton(
      onPressed: () {
        userProvider.intialiseAvatarList(true);
      },
      icon: Icon(
        AppIcons.refreshAvatarListIcon,
        color: Get.isDarkMode ? Theme.of(context).primaryColor : Theme.of(context).colorScheme.onPrimary,
      ),
    );
  }
}
