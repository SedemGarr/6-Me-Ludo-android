import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:six_me_ludo_android/screens/profile/widgets/settings/widgets/settings_title_widget.dart';
import 'package:six_me_ludo_android/services/translations/dialogue_service.dart';

import '../../../../../../../constants/icon_constants.dart';
import '../../../../../../../models/user_settings.dart';
import '../../../../../../../widgets/custom_card_widget.dart';
import '../../../../../../../widgets/custom_list_tile.dart';
import '../../../../../../models/game.dart';
import '../../../../../../models/player.dart';
import '../../../../../../services/database_service.dart';
import '../../../../../profile/widgets/settings/widgets/settings_icon_widget.dart';
import '../../../../../profile/widgets/settings/widgets/settings_subtitle_widget.dart';

class GameAIPersonality extends StatefulWidget {
  final bool shouldShowIcon;
  final bool canEdit;
  final Game game;

  const GameAIPersonality({super.key, required this.shouldShowIcon, required this.canEdit, required this.game});

  @override
  State<GameAIPersonality> createState() => _GameAIPersonalityState();
}

class _GameAIPersonalityState extends State<GameAIPersonality> {
  late Game game;

  void toggleSetting(BuildContext context, String value) {
    setState(() {
      game.hostSettings.aiPersonalityPreference = value;

      Random random = Random();

      for (Player element in game.players.where((element) => element.isAIPlayer)) {
        element.reputationValue = Player.getAIPersonality(game, game.hostSettings.aiPersonalityPreference, random);
      }
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
        leading: widget.shouldShowIcon ? const SettingsIconWidget(iconData: AppIcons.aIPersonalityTypeIcon) : null,
        title: SettingsTitleWidget(text: DialogueService.aIPersonalityTitleText.tr),
        subtitle: SettingsSubtitleWidget(text: DialogueService.aIPersonalitySubtitleText.tr),
        trailing: DropdownButton<dynamic>(
          iconEnabledColor: Theme.of(context).primaryColor,
          value: game.hostSettings.aiPersonalityPreference,
          items: UserSettings.getPersonalityDropDownMenuItems(context),
          underline: const SizedBox.shrink(),
          onChanged: widget.canEdit
              ? (dynamic value) {
                  toggleSetting(context, value);
                }
              : null,
        ),
      ),
    );
  }
}
