import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:six_me_ludo_android/screens/profile/widgets/settings/widgets/settings_title_widget.dart';
import 'package:six_me_ludo_android/services/translations/dialogue_service.dart';
import 'package:six_me_ludo_android/widgets/custom_switch.dart';

import '../../../../../../../constants/icon_constants.dart';
import '../../../../../../../widgets/custom_card_widget.dart';
import '../../../../../../../widgets/custom_list_tile.dart';
import '../../../../../../models/game.dart';
import '../../../../../../services/database_service.dart';
import '../../../../../profile/widgets/settings/widgets/settings_icon_widget.dart';
import '../../../../../profile/widgets/settings/widgets/settings_subtitle_widget.dart';

class GameStartAssist extends StatefulWidget {
  final bool shouldShowIcon;
  final bool canEdit;
  final Game game;

  const GameStartAssist({super.key, required this.shouldShowIcon, required this.canEdit, required this.game});

  @override
  State<GameStartAssist> createState() => _GameStartAssistState();
}

class _GameStartAssistState extends State<GameStartAssist> {
  late Game game;

  void toggleSetting(BuildContext context, bool value) {
    setState(() {
      game.hostSettings.prefersStartAssist = value;
    });

    DatabaseService.updateGame(
      game,
      false,
      shouldSyncWithFirestore: true,
      shouldCreate: false,
    );
  }

  @override
  void initState() {
    super.initState();
    game = widget.game;
  }

  @override
  Widget build(BuildContext context) {
    return CustomCardWidget(
      child: CustomListTileWidget(
        leading: widget.shouldShowIcon ? const SettingsIconWidget(iconData: AppIcons.startAssistIcon) : null,
        title: SettingsTitleWidget(text: DialogueService.startAssistTitleText.tr),
        subtitle: SettingsSubtitleWidget(text: DialogueService.startAssistSubtitleText.tr),
        trailing: CustomSwitchWidget(onChanged: widget.canEdit ? toggleSetting : null, value: game.hostSettings.prefersStartAssist),
      ),
    );
  }
}
