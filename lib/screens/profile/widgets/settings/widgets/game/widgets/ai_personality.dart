import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:six_me_ludo_android/providers/user_provider.dart';
import 'package:six_me_ludo_android/screens/profile/widgets/settings/widgets/settings_title_widget.dart';
import 'package:six_me_ludo_android/services/translations/dialogue_service.dart';

import '../../../../../../../models/user_settings.dart';
import '../../../../../../../widgets/custom_card_widget.dart';
import '../../../../../../../widgets/custom_list_tile.dart';

class AIPersonality extends StatelessWidget {
  const AIPersonality({super.key});

  @override
  Widget build(BuildContext context) {
    UserProvider userProvider = context.watch<UserProvider>();

    return CustomCardWidget(
      child: CustomListTileWidget(
        //  leading: shouldShowIcon ? const SettingsIconWidget(iconData: AppIcons.aIPersonalityTypeIcon) : null,
        title: SettingsTitleWidget(text: DialogueService.aIPersonalityTitleText.tr),
        //    subtitle: SettingsSubtitleWidget(text: DialogueService.aIPersonalitySubtitleText.tr),
        trailing: DropdownButton<dynamic>(
          iconEnabledColor: Theme.of(context).primaryColor,
          value: userProvider.getUserPersonalityPreference(),
          items: UserSettings.getPersonalityDropDownMenuItems(context),
          underline: const SizedBox.shrink(),
          onChanged: (dynamic value) {
            userProvider.setPersonalityPreference(value!);
          },
        ),
      ),
    );
  }
}
