import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../../../constants/app_constants.dart';
import '../../../../../../../services/translations/dialogue_service.dart';
import '../../../../../../../utils/utils.dart';
import '../../../../../../../widgets/custom_card_widget.dart';
import '../../../../../../../widgets/custom_list_tile.dart';
import '../../settings_title_widget.dart';

class PrivacySettings extends StatelessWidget {
  const PrivacySettings({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomCardWidget(
      child: CustomListTileWidget(
        onTap: () {
          Utils.openURL(AppConstants.privacyURL);
        },
        //   leading: const SettingsIconWidget(iconData: AppIcons.themeIcon),
        title: SettingsTitleWidget(text: DialogueService.privacyTitleText.tr),
        // subtitle: SettingsSubtitleWidget(text: DialogueService.versionText.tr),
        // trailing: Icon(AppIcons.themeArrowIcon, color: Theme.of(context).colorScheme.onBackground),
      ),
    );
  }
}
