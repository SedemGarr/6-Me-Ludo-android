import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../../../../../../../constants/icon_constants.dart';
import '../../../../../../../providers/user_provider.dart';
import '../../../../../../../services/translations/dialogue_service.dart';
import '../../settings_icon_widget.dart';
import '../../settings_subtitle_widget.dart';
import '../../settings_title_widget.dart';

class DeleteAcountWidget extends StatelessWidget {
  const DeleteAcountWidget({super.key});

  @override
  Widget build(BuildContext context) {
    UserProvider userProvider = context.watch<UserProvider>();

    return ListTile(
      onTap: () {
        userProvider.showDeleteAccountDialog(context);
      },
      leading: const SettingsIconWidget(iconData: AppIcons.deleteAccountIcon),
      title: SettingsTitleWidget(text: DialogueService.deleteAccountTitleText.tr),
      subtitle: SettingsSubtitleWidget(text: DialogueService.deleteAccountSubtitleText.tr),
    );
  }
}
