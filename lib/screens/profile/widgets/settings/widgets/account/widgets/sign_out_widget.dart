import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:six_me_ludo_android/providers/user_provider.dart';
import 'package:six_me_ludo_android/screens/profile/widgets/settings/widgets/settings_subtitle_widget.dart';
import 'package:six_me_ludo_android/screens/profile/widgets/settings/widgets/settings_title_widget.dart';
import 'package:six_me_ludo_android/services/translations/dialogue_service.dart';

import '../../../../../../../widgets/custom_card_widget.dart';
import '../../../../../../../widgets/custom_list_tile.dart';

class SignOutWidget extends StatelessWidget {
  const SignOutWidget({super.key});

  @override
  Widget build(BuildContext context) {
    UserProvider userProvider = context.watch<UserProvider>();

    return CustomCardWidget(
      child: CustomListTileWidget(
        onTap: () {
          userProvider.showSignOutDialog(context);
        },
        //   leading: const SettingsIconWidget(iconData: AppIcons.signOutIcon),
        title: SettingsTitleWidget(text: DialogueService.signOutTitleText.tr),
        subtitle: SettingsSubtitleWidget(text: DialogueService.signOutSubtitleText.tr),
      ),
    );
  }
}
