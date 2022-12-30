import 'package:flutter/material.dart';
import 'package:six_me_ludo_android/constants/textstyle_constants.dart';

class SettingsSubtitleWidget extends StatelessWidget {
  final String text;

  const SettingsSubtitleWidget({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyles.listSubtitleStyle(Theme.of(context).colorScheme.primary),
    );
  }
}
