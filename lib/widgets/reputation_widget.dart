import 'package:flutter/material.dart';

import '../models/player.dart';

class ReputationWidget extends StatelessWidget {
  final int value;
  final Color color;

  const ReputationWidget({super.key, required this.value, required this.color});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: null,
      icon: Icon(
        Player.parsePlayerReputationToIcon(value),
        color: color,
      ),
    );
  }
}
