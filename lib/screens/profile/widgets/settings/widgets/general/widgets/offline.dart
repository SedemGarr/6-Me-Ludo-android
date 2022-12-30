import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:six_me_ludo_android/providers/user_provider.dart';
import 'package:six_me_ludo_android/screens/profile/widgets/settings/widgets/settings_title_widget.dart';
import 'package:six_me_ludo_android/services/translations/dialogue_service.dart';

import '../../../../../../../widgets/general/custom_card_widget.dart';
import '../../../../../../../widgets/general/custom_list_tile.dart';
import '../../../../../../../widgets/general/custom_switch.dart';
import '../../settings_subtitle_widget.dart';

class OfflineModeWidget extends StatelessWidget {
  const OfflineModeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    UserProvider userProvider = context.watch<UserProvider>();

    return CustomCardWidget(
      child: CustomListTileWidget(
        //   leading: const SettingsIconWidget(iconData: AppIcons.darkModeIcon),
        title: SettingsTitleWidget(text: DialogueService.offlineModeTitleText.tr),
        subtitle: SettingsSubtitleWidget(text: DialogueService.offlineModeSubtitleText.tr),
        trailing: CustomSwitchWidget(onChanged: userProvider.toggleOfflineMode, value: userProvider.getUserIsOffline()),
      ),
    );
  }
}
