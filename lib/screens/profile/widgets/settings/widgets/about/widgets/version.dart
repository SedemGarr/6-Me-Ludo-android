import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../../../../../../../providers/app_provider.dart';
import '../../../../../../../services/translations/dialogue_service.dart';
import '../../../../../../../widgets/custom_card_widget.dart';
import '../../../../../../../widgets/custom_list_tile.dart';
import '../../settings_subtitle_widget.dart';
import '../../settings_title_widget.dart';

class VersionSettings extends StatelessWidget {
  const VersionSettings({super.key});

  @override
  Widget build(BuildContext context) {
    AppProvider appProvider = context.read<AppProvider>();

    return CustomCardWidget(
      child: CustomListTileWidget(
        onTap: null,
        //   leading: const SettingsIconWidget(iconData: AppIcons.themeIcon),
        title: SettingsTitleWidget(text: DialogueService.versionTitleText.tr),
        subtitle: SettingsSubtitleWidget(text: appProvider.getAppVersion()),
        // trailing: Icon(AppIcons.themeArrowIcon, color: Theme.of(context).colorScheme.onBackground),
      ),
    );
  }
}
