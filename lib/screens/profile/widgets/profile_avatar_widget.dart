import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

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
          // TODO show change avatar dialog
        },
        child: Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: Get.isDarkMode ? Theme.of(context).primaryColor : Theme.of(context).colorScheme.onPrimary,
              ),
              shape: BoxShape.circle,
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: MultiAvatarWidget(avatar: userProvider.getUserAvatar(), isBackgroundTransparent: true),
            )),
      ),
    );
  }
}
