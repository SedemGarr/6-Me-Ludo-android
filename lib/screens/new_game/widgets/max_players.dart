import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:six_me_ludo_android/providers/user_provider.dart';
import 'package:six_me_ludo_android/screens/profile/widgets/settings/widgets/settings_subtitle_widget.dart';
import 'package:six_me_ludo_android/screens/profile/widgets/settings/widgets/settings_title_widget.dart';
import 'package:six_me_ludo_android/services/translations/dialogue_service.dart';

import '../../../constants/icon_constants.dart';
import '../../../models/user_settings.dart';
import '../../../widgets/custom_list_tile.dart';
import '../../profile/widgets/settings/widgets/settings_icon_widget.dart';

class MaxPlayers extends StatelessWidget {
  const MaxPlayers({super.key});

  @override
  Widget build(BuildContext context) {
    UserProvider userProvider = context.watch<UserProvider>();

    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: CustomListTileWidget(
        leading: const SettingsIconWidget(iconData: AppIcons.maxHumanPlayerIcon),
        title: SettingsTitleWidget(text: DialogueService.maxPlayersTitleText.tr),
        subtitle: SettingsSubtitleWidget(text: DialogueService.maxPlayersSubtitleText.tr),
        trailing: DropdownButton<dynamic>(
          iconEnabledColor: Theme.of(context).primaryColor,
          value: userProvider.getUserHumanPlayerNumber(),
          items: UserSettings.getHumanPlayerDropDownMenuItems(context),
          underline: const SizedBox.shrink(),
          onChanged: (dynamic value) {
            userProvider.setHumanPlayerNumber(value!, context);
          },
        ),
      ),
    );
  }
}
