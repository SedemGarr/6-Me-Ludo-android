import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../../../../../../../providers/user_provider.dart';
import '../../../../../../../services/translations/dialogue_service.dart';
import '../../../../../../../widgets/custom_card_widget.dart';
import '../../../../../../../widgets/custom_list_tile.dart';
import '../../../../../../../widgets/custom_switch.dart';
import '../../settings_subtitle_widget.dart';
import '../../settings_title_widget.dart';

class WakelockWidget extends StatelessWidget {
  const WakelockWidget({super.key});

  @override
  Widget build(BuildContext context) {
    UserProvider userProvider = context.watch<UserProvider>();

    return CustomCardWidget(
      child: CustomListTileWidget(
        //  leading: const SettingsIconWidget(iconData: AppIcons.wakelockIcon),
        title: SettingsTitleWidget(text: DialogueService.wakelockTitleText.tr),
        subtitle: SettingsSubtitleWidget(text: DialogueService.wakelockSubtitleText.tr),
        trailing: CustomSwitchWidget(onChanged: userProvider.toggleWakelock, value: userProvider.getUserWakelock()),
      ),
    );
  }
}
