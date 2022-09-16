import 'package:flutter/material.dart';
import 'package:six_me_ludo_android/constants/icon_constants.dart';

class KickPlayerWidget extends StatelessWidget {
  final Color color;
  final bool isKicked;

  const KickPlayerWidget({super.key, required this.color, required this.isKicked});

  @override
  Widget build(BuildContext context) {
    return !isKicked
        ? IconButton(
            onPressed: () {},
            icon: Icon(
              AppIcons.kickPlayerIcon,
              color: color,
            ),
          )
        : const SizedBox.shrink();
  }
}
