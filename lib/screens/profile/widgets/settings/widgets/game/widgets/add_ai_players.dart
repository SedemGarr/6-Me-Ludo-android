import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:six_me_ludo_android/providers/user_provider.dart';
import 'package:six_me_ludo_android/screens/profile/widgets/settings/widgets/settings_title_widget.dart';
import 'package:six_me_ludo_android/services/translations/dialogue_service.dart';
import 'package:six_me_ludo_android/widgets/custom_switch.dart';

import '../../../../../../../constants/icon_constants.dart';
import '../../../../../../../widgets/custom_card_widget.dart';
import '../../../../../../../widgets/custom_list_tile.dart';
import '../../settings_icon_widget.dart';
import '../../settings_subtitle_widget.dart';

class AddAIPlayers extends StatelessWidget {
  final bool shouldShowIcon;

  const AddAIPlayers({super.key, required this.shouldShowIcon});

  @override
  Widget build(BuildContext context) {
    UserProvider userProvider = context.watch<UserProvider>();

    return CustomCardWidget(
      child: CustomListTileWidget(
        leading: shouldShowIcon ? const SettingsIconWidget(iconData: AppIcons.addAIPlayersIcon) : null,
        title: SettingsTitleWidget(text: DialogueService.addAIPlayersTitleText.tr),
        subtitle: SettingsSubtitleWidget(text: DialogueService.addAIPlayersSubtitleText.tr),
        trailing: CustomSwitchWidget(onChanged: userProvider.toggleAddAI, value: userProvider.getUserAddAI()),
      ),
    );
  }
}
