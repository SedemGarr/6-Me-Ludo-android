import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:six_me_ludo_android/providers/user_provider.dart';

import '../constants/icon_constants.dart';
import 'legal_dialog.dart';

class InfoButtonWidget extends StatelessWidget {
  const InfoButtonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    UserProvider userProvider = context.watch<UserProvider>();

    return IconButton(
      onPressed: () {
        userProvider.toggleIsEditingProfile(false);
        showLegalDialog(context: context);
      },
      icon: Icon(
        AppIcons.infoIcon,
        color: Get.isDarkMode ? Theme.of(context).primaryColor : Theme.of(context).colorScheme.onPrimary,
      ),
    );
  }
}
