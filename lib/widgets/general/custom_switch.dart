import 'package:flutter/material.dart';

class CustomSwitchWidget extends StatelessWidget {
  final bool value;
  final Function? onChanged;

  const CustomSwitchWidget({
    Key? key,
    required this.onChanged,
    required this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Switch(
      value: value,
      onChanged: (value) {
        if (onChanged != null) {
          onChanged!(context, value);
        }
      },
      activeColor: Theme.of(context).colorScheme.primary,
      activeTrackColor: Theme.of(context).colorScheme.primaryContainer,
      inactiveThumbColor: Theme.of(context).primaryColorLight,
      inactiveTrackColor: Theme.of(context).colorScheme.primaryContainer,
    );
  }
}
