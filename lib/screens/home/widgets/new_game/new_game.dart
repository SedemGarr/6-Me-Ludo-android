import 'package:flutter/material.dart';
import 'package:six_me_ludo_android/screens/home/widgets/new_game/widgets/new_game_text.dart';
import 'package:six_me_ludo_android/widgets/join_game_textfield_widget.dart';

import '../../../../constants/app_constants.dart';
import '../../../new_game/widgets/host_game_button.dart';
import '../../../new_game/widgets/max_players.dart';
import '../../../profile/widgets/settings/widgets/game/widgets/adaptive_ai.dart';
import '../../../profile/widgets/settings/widgets/game/widgets/add_ai_players.dart';
import '../../../profile/widgets/settings/widgets/game/widgets/ai_personality.dart';
import '../../../profile/widgets/settings/widgets/game/widgets/auto_start.dart';
import '../../../profile/widgets/settings/widgets/game/widgets/catch_up_assist.dart';
import '../../../profile/widgets/settings/widgets/game/widgets/game_speed.dart';
import '../../../profile/widgets/settings/widgets/game/widgets/start_assist.dart';

class NewGameView extends StatefulWidget {
  const NewGameView({super.key});

  @override
  State<NewGameView> createState() => _NewGameViewState();
}

class _NewGameViewState extends State<NewGameView> with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return SingleChildScrollView(
      child: Padding(
        padding: AppConstants.listViewPadding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            JoinGameTextFieldWidget(),
            CreateNewGameTextWidget(),
            MaxPlayers(),
            HostGameButton(),
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
          ],
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
