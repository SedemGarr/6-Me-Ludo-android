import 'package:flutter/material.dart';

import '../constants/textstyle_constants.dart';

class CustomTextButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final Color color;
  final String text;
  final IconData? iconData;

  const CustomTextButton({
    Key? key,
    required this.onPressed,
    required this.text,
    required this.color,
    this.iconData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return iconData != null
        ? TextButton.icon(
            icon: Icon(
              iconData,
              color: color,
            ),
            onPressed: onPressed,
            label: Text(
              text,
              style: TextStyles.textButtonStyle(color),
            ),
          )
        : TextButton(
            onPressed: onPressed,
            child: Text(
              text,
              style: TextStyles.textButtonStyle(color),
            ),
          );
  }
}
