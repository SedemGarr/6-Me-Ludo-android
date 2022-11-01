import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:six_me_ludo_android/providers/user_provider.dart';

import '../constants/textstyle_constants.dart';

class AppBarVersionText extends StatelessWidget {
  const AppBarVersionText({super.key});

  @override
  Widget build(BuildContext context) {
    UserProvider userProvider = context.watch<UserProvider>();

    return Center(
      child: Padding(
        padding: const EdgeInsets.only(right: 8.0),
        child: Text(
          userProvider.getAppVersion(),
          style: TextStyles.listSubtitleStyle(
            Get.isDarkMode ? Theme.of(context).colorScheme.onBackground : Theme.of(context).colorScheme.onPrimary,
          ),
        ),
      ),
    );
  }
}
