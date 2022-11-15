import 'package:flutter/material.dart';
import 'package:six_me_ludo_android/constants/textstyle_constants.dart';

class SettingsTitleWidget extends StatelessWidget {
  final String text;

  const SettingsTitleWidget({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyles.listTitleStyle(Theme.of(context).colorScheme.onBackground),
    );
  }
}
