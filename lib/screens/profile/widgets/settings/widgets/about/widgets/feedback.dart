import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:six_me_ludo_android/providers/app_provider.dart';

import '../../../../../../../services/translations/dialogue_service.dart';
import '../../../../../../../widgets/custom_card_widget.dart';
import '../../../../../../../widgets/custom_list_tile.dart';
import '../../settings_title_widget.dart';

class FeedbackSettings extends StatelessWidget {
  const FeedbackSettings({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomCardWidget(
      child: CustomListTileWidget(
        onTap: () {
          AppProvider.sendFeedback();
        },
        //   leading: const SettingsIconWidget(iconData: AppIcons.themeIcon),
        title: SettingsTitleWidget(text: DialogueService.sendFeedbackText.tr),
        // subtitle: SettingsSubtitleWidget(text: DialogueService.versionText.tr),
        // trailing: Icon(AppIcons.themeArrowIcon, color: Theme.of(context).colorScheme.onBackground),
      ),
    );
  }
}
