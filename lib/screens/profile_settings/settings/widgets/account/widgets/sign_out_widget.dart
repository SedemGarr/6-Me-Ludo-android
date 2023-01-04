import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:six_me_ludo_android/providers/user_provider.dart';
import 'package:six_me_ludo_android/screens/profile_settings/settings/widgets/settings_icon_widget.dart';
import 'package:six_me_ludo_android/screens/profile_settings/settings/widgets/settings_title_widget.dart';
import 'package:six_me_ludo_android/services/translations/dialogue_service.dart';

import '../../../../../../constants/icon_constants.dart';

import '../../../../../../widgets/general/custom_animated_crossfade.dart';
import '../../../../../../widgets/general/custom_card_widget.dart';
import '../../../../../../widgets/general/custom_list_tile.dart';
import '../../settings_subtitle_widget.dart';

class SignOutWidget extends StatelessWidget {
  const SignOutWidget({super.key});

  @override
  Widget build(BuildContext context) {
    UserProvider userProvider = context.watch<UserProvider>();

    bool isAnon = userProvider.isUserAnon();

    return CustomAnimatedCrossFade(
        firstChild: const SizedBox.shrink(),
        secondChild: CustomCardWidget(
          child: CustomListTileWidget(
            onTap: () {
              if (isAnon) {
                userProvider.showConvertAccountDialog(context);
              } else {
                userProvider.showSignOutDialog(context);
              }
            },
            //   leading: const SettingsIconWidget(iconData: AppIcons.signOutIcon),
            title: SettingsTitleWidget(text: isAnon ? DialogueService.convertAccountTitleText.tr : DialogueService.signOutTitleText.tr),
            subtitle: SettingsSubtitleWidget(text: isAnon ? DialogueService.signInSubtitleText.tr : DialogueService.signOutSubtitleText.tr),
            trailing: SettingsIconWidget(iconData: isAnon ? AppIcons.googleIcon : AppIcons.signOutIcon),
          ),
        ),
        condition: userProvider.getUserIsOffline());
  }
}
