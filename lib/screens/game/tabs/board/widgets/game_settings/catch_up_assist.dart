import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:six_me_ludo_android/screens/profile_settings/settings/widgets/settings_title_widget.dart';
import 'package:six_me_ludo_android/services/translations/dialogue_service.dart';
import '../../../../../../models/game.dart';
import '../../../../../../services/database_service.dart';
import '../../../../../../widgets/general/custom_card_widget.dart';
import '../../../../../../widgets/general/custom_list_tile.dart';
import '../../../../../../widgets/general/custom_switch.dart';

class GameCatchUpAssist extends StatefulWidget {
  final bool canEdit;
  final Game game;

  const GameCatchUpAssist({super.key, required this.canEdit, required this.game});

  @override
  State<GameCatchUpAssist> createState() => _GameCatchUpAssistState();
}

class _GameCatchUpAssistState extends State<GameCatchUpAssist> {
  late Game game;

  void toggleSetting(BuildContext context, bool value) {
    setState(() {
      game.hostSettings.prefersCatchupAssist = value;
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
        //  leading: widget.shouldShowIcon ? const SettingsIconWidget(iconData: AppIcons.catchUpAssistIcon) : null,
        title: SettingsTitleWidget(text: DialogueService.catchUpAssistTitleText.tr),
        //   subtitle: SettingsSubtitleWidget(text: DialogueService.catchUpAssistSubtitleText.tr),
        trailing: CustomSwitchWidget(onChanged: widget.canEdit ? toggleSetting : null, value: game.hostSettings.prefersCatchupAssist),
      ),
    );
  }
}
