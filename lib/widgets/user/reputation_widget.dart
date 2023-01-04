import 'package:flutter/material.dart';

import '../../models/player.dart';

class ReputationWidget extends StatelessWidget {
  final int value;
  final bool shouldPad;
  final Color color;

  const ReputationWidget({super.key, required this.value, required this.color, required this.shouldPad});

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: Player.getPlayerReputationName(value),
      child: Padding(
        padding: shouldPad
            ? const EdgeInsets.only(
                left: 16.0,
                right: 16.0,
              )
            : EdgeInsets.zero,
        child: Icon(
          Player.parsePlayerReputationToIcon(value),
          color: color,
        ),
      ),
    );
  }
}
