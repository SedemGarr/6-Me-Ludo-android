import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:six_me_ludo_android/providers/user_provider.dart';

import '../../../../../../../services/translations/dialogue_service.dart';
import '../../../../../../../widgets/general/custom_card_widget.dart';
import '../../../../../../../widgets/general/custom_list_tile.dart';
import '../../settings_subtitle_widget.dart';
import '../../settings_title_widget.dart';

class LanguageWidget extends StatelessWidget {
  const LanguageWidget({super.key});

  @override
  Widget build(BuildContext context) {
    UserProvider userProvider = context.watch<UserProvider>();

    return CustomCardWidget(
      child: CustomListTileWidget(
        //    leading: const SettingsIconWidget(iconData: AppIcons.languageIcon),
        title: SettingsTitleWidget(text: DialogueService.languageTitleText.tr),
        subtitle: SettingsSubtitleWidget(text: DialogueService.languageSubtitleText.tr),
        trailing: DropdownButton<dynamic>(
          iconEnabledColor: Theme.of(context).colorScheme.secondary,
          value: userProvider.getLocale().languageCode,
          items: DialogueService.getLocaleDropDownMenuItems(context),
          underline: const SizedBox.shrink(),
          onChanged: (dynamic value) {
            userProvider.setLanguageCode(value!);
          },
        ),
      ),
    );
  }
}
