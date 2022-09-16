import 'package:flutter/material.dart';
import 'package:six_me_ludo_android/constants/icon_constants.dart';

class BanPlayerWidget extends StatelessWidget {
  final Color color;
  final bool isBanned;

  const BanPlayerWidget({super.key, required this.color, required this.isBanned});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {},
      icon: Icon(
        isBanned ? AppIcons.unBanPlayerIcon : AppIcons.banPlayerIcon,
        color: color,
      ),
    );
  }
}
