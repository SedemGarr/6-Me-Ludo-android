import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:six_me_ludo_android/models/user_settings.dart';
import 'package:six_me_ludo_android/providers/user_provider.dart';
import 'package:six_me_ludo_android/screens/profile_settings/settings/widgets/settings_title_widget.dart';
import 'package:six_me_ludo_android/services/translations/dialogue_service.dart';

import '../../../../../../widgets/general/custom_card_widget.dart';
import '../../../../../../widgets/general/custom_list_tile.dart';
import '../../settings_subtitle_widget.dart';

class GameSpeed extends StatelessWidget {
  const GameSpeed({super.key});

  @override
  Widget build(BuildContext context) {
    UserProvider userProvider = context.watch<UserProvider>();

    return CustomCardWidget(
      child: CustomListTileWidget(
        //    leading: shouldShowIcon ? const SettingsIconWidget(iconData: AppIcons.gameSpeedIcon) : null,
        title: SettingsTitleWidget(text: DialogueService.gameSpeedTitleText.tr),
        subtitle: SettingsSubtitleWidget(text: DialogueService.gameSpeedSubtitleText.tr),
        trailing: DropdownButton<dynamic>(
          iconEnabledColor: Theme.of(context).colorScheme.primary,
          value: userProvider.getUserGameSpeed(),
          items: UserSettings.getGameSpeedDropDownMenuItems(context),
          underline: const SizedBox.shrink(),
          onChanged: (dynamic value) {
            userProvider.setGameSpeed(value!);
          },
        ),
        // isThreeLine: true,
      ),
    );
  }
}
