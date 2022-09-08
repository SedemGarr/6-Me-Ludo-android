import 'package:flutter/material.dart';

import '../constants/app_constants.dart';
import '../constants/textstyle_constants.dart';

class CustomFABWidget extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;

  const CustomFABWidget({super.key, required this.onPressed, required this.text});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.extended(
      elevation: 0,
      shape: AppConstants.appShape,
      onPressed: onPressed,
      label: Text(
        text,
        style: TextStyles.fabStyle(Theme.of(context).colorScheme.onPrimaryContainer),
      ),
    );
  }
}
