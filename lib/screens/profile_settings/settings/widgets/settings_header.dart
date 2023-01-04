import 'package:flutter/material.dart';

import '../../../../constants/textstyle_constants.dart';

class SettingsHeaderWidget extends StatelessWidget {
  final String text;

  const SettingsHeaderWidget({
    Key? key,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8, left: 8.0, bottom: 8.0),
      child: Text(
        text,
        style: TextStyles.settingsHeaderStyle(Theme.of(context).primaryColor),
      ),
    );
  }
}
