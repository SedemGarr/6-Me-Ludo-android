import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:six_me_ludo_android/providers/user_provider.dart';
import 'package:six_me_ludo_android/screens/profile/widgets/settings/widgets/settings_title_widget.dart';
import 'package:six_me_ludo_android/services/translations/dialogue_service.dart';
import 'package:six_me_ludo_android/widgets/custom_switch.dart';

import '../../../../../../../widgets/custom_card_widget.dart';
import '../../../../../../../widgets/custom_list_tile.dart';
import '../../settings_subtitle_widget.dart';

class ProfaneMessages extends StatelessWidget {
  const ProfaneMessages({super.key});

  @override
  Widget build(BuildContext context) {
    UserProvider userProvider = context.watch<UserProvider>();

    return CustomCardWidget(
      child: CustomListTileWidget(
        // leading: const SettingsIconWidget(iconData: AppIcons.profaneIcon),
        title: SettingsTitleWidget(text: DialogueService.profaneMessagesTitleText.tr),
        subtitle: SettingsSubtitleWidget(text: DialogueService.profaneMessagesSubtitleText.tr),
        trailing: CustomSwitchWidget(onChanged: userProvider.toggleProfaneMessages, value: userProvider.getUserProfaneMessages()),
      ),
    );
  }
}
