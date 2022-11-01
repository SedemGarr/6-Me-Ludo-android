import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:six_me_ludo_android/models/player.dart';
import 'package:six_me_ludo_android/providers/user_provider.dart';

import '../../../../../constants/textstyle_constants.dart';

class GameNameWidget extends StatelessWidget {
  final Player host;
  final List<Player> players;

  const GameNameWidget({super.key, required this.host, required this.players});

  @override
  Widget build(BuildContext context) {
    UserProvider userProvider = context.watch<UserProvider>();

    return Text(
      userProvider.parseGameNameText(host, players),
      style: TextStyles.listTitleStyle(Theme.of(context).colorScheme.onBackground),
    );
  }
}
