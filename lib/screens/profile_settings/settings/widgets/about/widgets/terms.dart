import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:six_me_ludo_android/providers/app_provider.dart';
import 'package:six_me_ludo_android/screens/profile_settings/settings/widgets/settings_icon_widget.dart';

import '../../../../../../constants/app_constants.dart';
import '../../../../../../constants/icon_constants.dart';
import '../../../../../../services/translations/dialogue_service.dart';

import '../../../../../../widgets/general/custom_card_widget.dart';
import '../../../../../../widgets/general/custom_list_tile.dart';
import '../../settings_subtitle_widget.dart';
import '../../settings_title_widget.dart';

class TermsSettings extends StatelessWidget {
  const TermsSettings({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomCardWidget(
      child: CustomListTileWidget(
        onTap: () {
          AppProvider.openURL(AppConstants.termsURL);
        },
        //   leading: const SettingsIconWidget(iconData: AppIcons.themeIcon),
        title: SettingsTitleWidget(text: DialogueService.termsTitleText.tr),
        subtitle: SettingsSubtitleWidget(text: DialogueService.termsSubtitleText.tr),
        trailing: const SettingsIconWidget(iconData: AppIcons.webIcon),
      ),
    );
  }
}
