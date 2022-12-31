import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:six_me_ludo_android/models/user_settings.dart';
import 'package:six_me_ludo_android/screens/profile_settings/settings/widgets/settings_title_widget.dart';
import 'package:six_me_ludo_android/services/translations/dialogue_service.dart';

import '../../../../../../models/game.dart';
import '../../../../../../services/database_service.dart';
import '../../../../../../widgets/general/custom_card_widget.dart';
import '../../../../../../widgets/general/custom_list_tile.dart';

class GameGameSpeed extends StatefulWidget {
  final bool canEdit;
  final Game game;

  const GameGameSpeed({super.key, required this.canEdit, required this.game});

  @override
  State<GameGameSpeed> createState() => _GameGameSpeedState();
}

class _GameGameSpeedState extends State<GameGameSpeed> {
  late Game game;

  void toggleSetting(BuildContext context, int value) {
    setState(() {
      game.hostSettings.preferredSpeed = value;
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
        //  leading: widget.shouldShowIcon ? const SettingsIconWidget(iconData: AppIcons.gameSpeedIcon) : null,
        title: SettingsTitleWidget(text: DialogueService.gameSpeedTitleText.tr),
        //  subtitle: SettingsSubtitleWidget(text: DialogueService.gameSpeedSubtitleText.tr),
        trailing: DropdownButton<dynamic>(
          iconEnabledColor: Theme.of(context).colorScheme.secondary,
          value: game.hostSettings.preferredSpeed,
          items: UserSettings.getGameSpeedDropDownMenuItems(context),
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
