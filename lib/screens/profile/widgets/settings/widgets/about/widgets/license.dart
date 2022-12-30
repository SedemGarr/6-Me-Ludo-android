import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:six_me_ludo_android/screens/profile/widgets/settings/widgets/settings_icon_widget.dart';
import 'package:six_me_ludo_android/services/navigation_service.dart';

import '../../../../../../../constants/icon_constants.dart';
import '../../../../../../../services/translations/dialogue_service.dart';

import '../../../../../../../widgets/general/custom_card_widget.dart';
import '../../../../../../../widgets/general/custom_list_tile.dart';
import '../../settings_subtitle_widget.dart';
import '../../settings_title_widget.dart';

class LicenseSettings extends StatelessWidget {
  const LicenseSettings({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomCardWidget(
      child: CustomListTileWidget(
        onTap: () {
          NavigationService.goToLegalScreen();
        },
        //   leading: const SettingsIconWidget(iconData: AppIcons.themeIcon),
        title: SettingsTitleWidget(text: DialogueService.licenseTitleText.tr),
        subtitle: SettingsSubtitleWidget(text: DialogueService.licenseSubTitleText.tr),
        trailing: const SettingsIconWidget(iconData: AppIcons.themeArrowIcon),
      ),
    );
  }
}
