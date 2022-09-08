import 'package:flutter/material.dart';
import 'package:six_me_ludo_android/constants/player_constants.dart';

class ReputationWidget extends StatelessWidget {
  final int value;
  final Color color;

  const ReputationWidget({super.key, required this.value, required this.color});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: null,
      icon: Icon(
        PlayerConstants.parsePlayerReputationToIcon(value),
        color: color,
      ),
    );
  }
}
