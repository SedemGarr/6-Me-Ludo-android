import 'package:flutter/material.dart';
import 'package:six_me_ludo_android/constants/icon_constants.dart';

class ChatUserIcon extends StatelessWidget {
  final Color color;

  const ChatUserIcon({super.key, required this.color});

  @override
  Widget build(BuildContext context) {
    return Icon(
      AppIcons.userIcon,
      color: color,
    );
  }
}
