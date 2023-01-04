import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:six_me_ludo_android/models/game.dart';
import 'package:six_me_ludo_android/screens/profile_settings/settings/widgets/settings_title_widget.dart';
import 'package:six_me_ludo_android/services/database_service.dart';
import 'package:six_me_ludo_android/services/translations/dialogue_service.dart';

import '../../../../../../widgets/general/custom_card_widget.dart';
import '../../../../../../widgets/general/custom_list_tile.dart';
import '../../../../../../widgets/general/custom_switch.dart';

class GameAdaptiveAI extends StatefulWidget {
  final bool canEdit;
  final Game game;

  const GameAdaptiveAI({super.key, required this.canEdit, required this.game});

  @override
  State<GameAdaptiveAI> createState() => _GameAdaptiveAIState();
}

class _GameAdaptiveAIState extends State<GameAdaptiveAI> {
  late Game game;

  void toggleSetting(BuildContext context, bool value) {
    setState(() {
      game.hostSettings.prefersAdaptiveAI = value;
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
        //  leading: widget.shouldShowIcon ? const SettingsIconWidget(iconData: AppIcons.adaptiveAIIcon) : null,
        title: SettingsTitleWidget(text: DialogueService.adaptiveAITitleText.tr),
        //   subtitle: SettingsSubtitleWidget(text: DialogueService.adaptiveAISubtitleText.tr),
        trailing: CustomSwitchWidget(onChanged: widget.canEdit ? toggleSetting : null, value: game.hostSettings.prefersAdaptiveAI),
      ),
    );
  }
}
