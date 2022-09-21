import 'package:flutter/material.dart';
import 'package:six_me_ludo_android/screens/new_game/widgets/max_players.dart';
import 'package:six_me_ludo_android/screens/new_game/widgets/new_game_button.dart';

import '../../../constants/app_constants.dart';
import '../../profile/widgets/settings/widgets/game/widgets/adaptive_ai.dart';
import '../../profile/widgets/settings/widgets/game/widgets/add_ai_players.dart';
import '../../profile/widgets/settings/widgets/game/widgets/ai_personality.dart';
import '../../profile/widgets/settings/widgets/game/widgets/auto_start.dart';
import '../../profile/widgets/settings/widgets/game/widgets/catch_up_assist.dart';
import '../../profile/widgets/settings/widgets/game/widgets/game_speed.dart';
import '../../profile/widgets/settings/widgets/game/widgets/profanity.dart';
import '../../profile/widgets/settings/widgets/game/widgets/start_assist.dart';

class HostGameView extends StatefulWidget {
  const HostGameView({super.key});

  @override
  State<HostGameView> createState() => _HostGameViewState();
}

class _HostGameViewState extends State<HostGameView> with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return ListView(
      padding: AppConstants.listViewPadding,
      children: const [
        MaxPlayers(),
        NewGameButton(),
        Divider(),
        AddAIPlayers(),
        Divider(),
        AutoStart(),
        Divider(),
        CatchUpAssist(),
        Divider(),
        StartAssist(),
        Divider(),
        AdaptiveAI(),
        Divider(),
        AIPersonality(),
        Divider(),
        GameSpeed(),
        Divider(),
        ProfaneMessages(),
      ],
    );
  }

  @override
  bool get wantKeepAlive => true;
}
