import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../../../../../../providers/user_provider.dart';
import '../../../../../../services/translations/dialogue_service.dart';

import '../../../../../../widgets/general/custom_card_widget.dart';
import '../../../../../../widgets/general/custom_list_tile.dart';
import '../../../../../../widgets/general/custom_switch.dart';
import '../../settings_subtitle_widget.dart';
import '../../settings_title_widget.dart';

class VisibilityWidget extends StatelessWidget {
  const VisibilityWidget({super.key});

  @override
  Widget build(BuildContext context) {
    UserProvider userProvider = context.watch<UserProvider>();

    return CustomCardWidget(
      child: CustomListTileWidget(
        //  leading: const SettingsIconWidget(iconData: AppIcons.wakelockIcon),
        title: SettingsTitleWidget(text: DialogueService.visibilityTitleText.tr),
        subtitle: SettingsSubtitleWidget(text: DialogueService.visibilitySubtitleText.tr),
        trailing: CustomSwitchWidget(onChanged: userProvider.toggleIsPrivate, value: userProvider.getUserIsPrivate()),
        isThreeLine: true,
      ),
    );
  }
}
