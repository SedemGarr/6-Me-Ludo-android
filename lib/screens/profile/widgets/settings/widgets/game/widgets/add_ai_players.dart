import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:six_me_ludo_android/constants/icon_constants.dart';
import 'package:six_me_ludo_android/providers/user_provider.dart';
import 'package:six_me_ludo_android/screens/profile/widgets/settings/widgets/settings_icon_widget.dart';
import 'package:six_me_ludo_android/screens/profile/widgets/settings/widgets/settings_title_widget.dart';
import 'package:six_me_ludo_android/services/translations/dialogue_service.dart';
import 'package:six_me_ludo_android/widgets/custom_switch.dart';

import '../../../../../../../widgets/custom_list_tile.dart';
import '../../settings_subtitle_widget.dart';

class AddAIPlayers extends StatelessWidget {
  const AddAIPlayers({super.key});

  @override
  Widget build(BuildContext context) {
    UserProvider userProvider = context.watch<UserProvider>();

    return CustomListTileWidget(
      leading: const SettingsIconWidget(iconData: AppIcons.addAIPlayersIcon),
      title: SettingsTitleWidget(text: DialogueService.addAIPlayersTitleText.tr),
      subtitle: SettingsSubtitleWidget(text: DialogueService.addAIPlayersSubtitleText.tr),
      trailing: CustomSwitchWidget(onChanged: userProvider.toggleAddAI, value: userProvider.getUserAddAI()),
    );
  }
}
