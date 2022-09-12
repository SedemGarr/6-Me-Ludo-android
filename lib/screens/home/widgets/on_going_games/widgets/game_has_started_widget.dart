import 'package:flutter/material.dart';
import 'package:six_me_ludo_android/constants/icon_constants.dart';

class GameHasStarteWidget extends StatelessWidget {
  final bool hasGameStarted;

  const GameHasStarteWidget({super.key, required this.hasGameStarted});

  @override
  Widget build(BuildContext context) {
    return Icon(
      AppIcons.gameHasStartedIcon,
      color: !hasGameStarted ? Theme.of(context).primaryColor : Colors.transparent,
    );
  }
}
