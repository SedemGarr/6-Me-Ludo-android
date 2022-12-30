import 'package:flutter/material.dart';
import 'package:six_me_ludo_android/constants/app_constants.dart';

import '../../constants/textstyle_constants.dart';

class CustomOutlinedButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final String text;
  final IconData? iconData;
  final Color? color;

  const CustomOutlinedButton({
    Key? key,
    required this.onPressed,
    required this.text,
    this.color,
    this.iconData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return iconData != null
        ? OutlinedButton.icon(
            style: OutlinedButton.styleFrom(
              shape: AppConstants.appShape,
              side: BorderSide(color: color ?? Theme.of(context).colorScheme.secondary),
            ),
            onPressed: onPressed,
            label: Text(
              text,
              style: TextStyles.textButtonStyle(color ?? Theme.of(context).colorScheme.secondary),
            ),
            icon: Icon(
              iconData,
              color: color ?? Theme.of(context).colorScheme.secondary,
            ),
          )
        : OutlinedButton(
            style: OutlinedButton.styleFrom(
              shape: AppConstants.appShape,
              side: BorderSide(color: color ?? Theme.of(context).colorScheme.secondary),
            ),
            onPressed: onPressed,
            child: Text(
              text,
              style: TextStyles.textButtonStyle(color ?? Theme.of(context).colorScheme.secondary),
            ),
          );
  }
}
