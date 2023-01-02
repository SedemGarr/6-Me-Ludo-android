import 'package:flutter/material.dart';

class SettingsIconWidget extends StatelessWidget {
  final IconData iconData;

  const SettingsIconWidget({super.key, required this.iconData});

  @override
  Widget build(BuildContext context) {
    return Icon(
      iconData,
      color: Theme.of(context).colorScheme.primary,
    );
  }
}
