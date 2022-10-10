import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../constants/icon_constants.dart';
import '../providers/user_provider.dart';

class RandomThemeButtonWidget extends StatelessWidget {
  const RandomThemeButtonWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    UserProvider userProvider = context.watch<UserProvider>();

    return IconButton(
      onPressed: () {
        userProvider.setThemeToRandom(context);
      },
      icon: Icon(
        AppIcons.randomIcon,
        color: Get.isDarkMode ? Theme.of(context).colorScheme.onSurface : Theme.of(context).colorScheme.onPrimary,
      ),
    );
  }
}
