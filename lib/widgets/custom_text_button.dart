import 'package:flutter/material.dart';
import 'package:six_me_ludo_android/constants/app_constants.dart';

import '../constants/textstyle_constants.dart';

class CustomTextButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final Color color;
  final String text;
  final bool isOutlined;

  const CustomTextButton({
    Key? key,
    required this.onPressed,
    required this.text,
    required this.color,
    required this.isOutlined,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return isOutlined
        ? OutlinedButton(
            style: OutlinedButton.styleFrom(
              shape: AppConstants.appShape,
            ),
            onPressed: onPressed,
            child: Text(
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
