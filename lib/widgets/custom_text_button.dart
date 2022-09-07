import 'package:flutter/material.dart';

import '../constants/constants.dart';

class CustomTextButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final Color color;
  final String text;

  const CustomTextButton({
    Key? key,
    required this.onPressed,
    required this.text,
    required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      child: Text(
        text,
        style: TextStyles.textButtonStyle(color),
      ),
    );
  }
}
