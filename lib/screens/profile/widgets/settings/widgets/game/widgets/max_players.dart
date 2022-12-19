import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:six_me_ludo_android/providers/user_provider.dart';
import 'package:six_me_ludo_android/screens/profile/widgets/settings/widgets/settings_title_widget.dart';
import 'package:six_me_ludo_android/services/translations/dialogue_service.dart';

import '../../../../../../../models/user_settings.dart';
import '../../../../../../../widgets/custom_animated_crossfade.dart';
import '../../../../../../../widgets/custom_card_widget.dart';
import '../../../../../../../widgets/custom_list_tile.dart';

class MaxPlayers extends StatelessWidget {
  const MaxPlayers({super.key});

  @override
  Widget build(BuildContext context) {
    UserProvider userProvider = context.watch<UserProvider>();

    return CustomAnimatedCrossFade(
      firstChild: const SizedBox.shrink(),
      secondChild: CustomCardWidget(
        child: CustomListTileWidget(
          //  leading: shouldShowIcon ? const SettingsIconWidget(iconData: AppIcons.maxHumanPlayerIcon) : null,
          title: SettingsTitleWidget(text: userProvider.getUserIsOffline() ? DialogueService.maxPlayersOfflineTitleText.tr : DialogueService.maxPlayersTitleText.tr),
          //   subtitle: SettingsSubtitleWidget(text: DialogueService.maxPlayersSubtitleText.tr),
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
      ),
      condition: userProvider.getUserIsOffline(),
    );
  }
}
