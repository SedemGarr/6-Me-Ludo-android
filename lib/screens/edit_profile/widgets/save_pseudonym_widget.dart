import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:six_me_ludo_android/constants/icon_constants.dart';
import 'package:six_me_ludo_android/providers/user_provider.dart';
import 'package:six_me_ludo_android/widgets/custom_animated_crossfade.dart';

class SavePseudonymButton extends StatelessWidget {
  const SavePseudonymButton({super.key});

  @override
  Widget build(BuildContext context) {
    UserProvider userProvider = context.watch<UserProvider>();

    return CustomAnimatedCrossFade(
      firstChild: Center(
        child: IconButton(
          onPressed: () {
            userProvider.setUserPseudonym();
          },
          icon: Icon(
            AppIcons.editDoneProfileIcon,
            color: Get.isDarkMode ? Theme.of(context).primaryColor : Theme.of(context).colorScheme.onPrimary,
          ),
        ),
      ),
      secondChild: const SizedBox.shrink(),
      condition: userProvider.hasUserPseudonymChanged(),
    );
  }
}
