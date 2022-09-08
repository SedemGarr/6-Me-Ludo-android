import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:six_me_ludo_android/providers/user_provider.dart';

import '../../../constants/textstyle_constants.dart';

class ProfilePseudonymWidget extends StatelessWidget {
  const ProfilePseudonymWidget({super.key});

  @override
  Widget build(BuildContext context) {
    UserProvider userProvider = context.watch<UserProvider>();

    return GestureDetector(
      onTap: () {
        // TODO show change pseudonym dialog
      },
      child: Text(
        userProvider.getUserPseudonym(),
        style: TextStyles.listTitleStyle(
          Get.isDarkMode ? Theme.of(context).colorScheme.onSurface : Theme.of(context).colorScheme.onPrimary,
        ),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}
