import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../../../constants/icon_constants.dart';
import '../../../../../../../services/navigation_service.dart';
import '../../../../../../../services/translations/dialogue_service.dart';
import '../../../../../../../widgets/custom_card_widget.dart';
import '../../../../../../../widgets/custom_list_tile.dart';
import '../../settings_icon_widget.dart';
import '../../settings_subtitle_widget.dart';
import '../../settings_title_widget.dart';

class ThemeWidget extends StatelessWidget {
  const ThemeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomCardWidget(
      child: CustomListTileWidget(
        onTap: () {
          NavigationService.goToThemeSelector();
        },
        leading: const SettingsIconWidget(iconData: AppIcons.themeIcon),
        title: SettingsTitleWidget(text: DialogueService.themeTitleText.tr),
        subtitle: SettingsSubtitleWidget(text: DialogueService.themeSubtitleText.tr),
        trailing: Icon(AppIcons.themeArrowIcon, color: Theme.of(context).colorScheme.onBackground),
      ),
    );
  }
}
