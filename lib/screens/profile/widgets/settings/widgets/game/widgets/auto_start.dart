import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:six_me_ludo_android/providers/user_provider.dart';
import 'package:six_me_ludo_android/screens/profile/widgets/settings/widgets/settings_title_widget.dart';
import 'package:six_me_ludo_android/services/translations/dialogue_service.dart';
import 'package:six_me_ludo_android/widgets/custom_switch.dart';

import '../../../../../../../widgets/custom_animated_crossfade.dart';
import '../../../../../../../widgets/custom_card_widget.dart';
import '../../../../../../../widgets/custom_list_tile.dart';

class AutoStart extends StatelessWidget {
  const AutoStart({super.key});

  @override
  Widget build(BuildContext context) {
    UserProvider userProvider = context.watch<UserProvider>();

    return CustomAnimatedCrossFade(
      firstChild: const SizedBox.shrink(),
      secondChild: CustomCardWidget(
        child: CustomListTileWidget(
          //  leading: shouldShowIcon ? const SettingsIconWidget(iconData: AppIcons.autoStartIcon) : null,
          title: SettingsTitleWidget(text: DialogueService.autoStartTitleText.tr),
          //   subtitle: SettingsSubtitleWidget(text: DialogueService.autoStartSubtitleText.tr),
          trailing: CustomSwitchWidget(onChanged: userProvider.toggleAutoStart, value: userProvider.getUserAutoStart()),
        ),
      ),
      condition: userProvider.getUserIsOffline(),
    );

    // return CustomCardWidget(
    //   child: CustomListTileWidget(
    //     //  leading: shouldShowIcon ? const SettingsIconWidget(iconData: AppIcons.autoStartIcon) : null,
    //     title: SettingsTitleWidget(text: DialogueService.autoStartTitleText.tr),
    //     //   subtitle: SettingsSubtitleWidget(text: DialogueService.autoStartSubtitleText.tr),
    //     trailing: CustomSwitchWidget(onChanged: userProvider.toggleAutoStart, value: userProvider.getUserAutoStart()),
    //   ),
    // );
  }
}
