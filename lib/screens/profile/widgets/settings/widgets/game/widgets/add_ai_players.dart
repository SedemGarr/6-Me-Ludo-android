import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:six_me_ludo_android/providers/user_provider.dart';
import 'package:six_me_ludo_android/screens/profile/widgets/settings/widgets/settings_title_widget.dart';
import 'package:six_me_ludo_android/services/translations/dialogue_service.dart';

import '../../../../../../../widgets/general/custom_animated_crossfade.dart';
import '../../../../../../../widgets/general/custom_card_widget.dart';
import '../../../../../../../widgets/general/custom_list_tile.dart';
import '../../../../../../../widgets/general/custom_switch.dart';
import '../../settings_subtitle_widget.dart';

class AddAIPlayers extends StatelessWidget {
  const AddAIPlayers({super.key});

  @override
  Widget build(BuildContext context) {
    UserProvider userProvider = context.watch<UserProvider>();

    return CustomAnimatedCrossFade(
      firstChild: const SizedBox.shrink(),
      secondChild: CustomCardWidget(
        child: CustomListTileWidget(
          //   leading: shouldShowIcon ? const SettingsIconWidget(iconData: AppIcons.addAIPlayersIcon) : null,
          title: SettingsTitleWidget(text: DialogueService.addAIPlayersTitleText.tr),
          subtitle: SettingsSubtitleWidget(text: DialogueService.addAIPlayersSubtitleText.tr),
          trailing: CustomSwitchWidget(onChanged: userProvider.toggleAddAI, value: userProvider.getUserAddAI()),
          isThreeLine: true,
        ),
      ),
      condition: userProvider.getUserIsOffline(),
    );
  }
}
