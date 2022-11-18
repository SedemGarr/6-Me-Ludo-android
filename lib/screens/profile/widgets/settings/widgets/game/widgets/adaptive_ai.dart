import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:six_me_ludo_android/providers/user_provider.dart';
import 'package:six_me_ludo_android/screens/profile/widgets/settings/widgets/settings_title_widget.dart';
import 'package:six_me_ludo_android/services/translations/dialogue_service.dart';
import 'package:six_me_ludo_android/widgets/custom_card_widget.dart';
import 'package:six_me_ludo_android/widgets/custom_switch.dart';

import '../../../../../../../constants/icon_constants.dart';
import '../../../../../../../widgets/custom_list_tile.dart';
import '../../settings_icon_widget.dart';
import '../../settings_subtitle_widget.dart';

class AdaptiveAI extends StatelessWidget {
  final bool shouldShowIcon;

  const AdaptiveAI({super.key, required this.shouldShowIcon});

  @override
  Widget build(BuildContext context) {
    UserProvider userProvider = context.watch<UserProvider>();

    return CustomCardWidget(
      child: CustomListTileWidget(
        leading: shouldShowIcon ? const SettingsIconWidget(iconData: AppIcons.adaptiveAIIcon) : null,
        title: SettingsTitleWidget(text: DialogueService.adaptiveAITitleText.tr),
        subtitle: SettingsSubtitleWidget(text: DialogueService.adaptiveAISubtitleText.tr),
        trailing: CustomSwitchWidget(onChanged: userProvider.toggleAdaptiveAI, value: userProvider.getUserAdaptiveAI()),
      ),
    );
  }
}
