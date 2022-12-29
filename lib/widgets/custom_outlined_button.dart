import 'package:flutter/material.dart';
import 'package:six_me_ludo_android/constants/app_constants.dart';

import '../constants/textstyle_constants.dart';

class CustomOutlinedButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final String text;
  final IconData? iconData;

  const CustomOutlinedButton({
    Key? key,
    required this.onPressed,
    required this.text,
    this.iconData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color color = Theme.of(context).colorScheme.primary;

    return iconData != null
        ? OutlinedButton.icon(
            style: OutlinedButton.styleFrom(
              shape: AppConstants.appShape,
              side: BorderSide(color: color),
            ),
            onPressed: onPressed,
            label: Text(
              text,
              style: TextStyles.textButtonStyle(color),
            ),
            icon: Icon(
              iconData,
              color: color,
            ),
          )
        : OutlinedButton(
            style: OutlinedButton.styleFrom(
              shape: AppConstants.appShape,
              side: BorderSide(color: color),
            ),
            onPressed: onPressed,
            child: Text(
              text,
              style: TextStyles.textButtonStyle(color),
            ),
          );
  }
}
