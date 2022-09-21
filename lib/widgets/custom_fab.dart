import 'package:flutter/material.dart';

import '../constants/app_constants.dart';

class CustomFABWidget extends StatelessWidget {
  final VoidCallback? onPressed;
  final Widget widget;
  final Color color;

  const CustomFABWidget({super.key, required this.onPressed, required this.widget, required this.color});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.large(
      elevation: 0,
      shape: AppConstants.appShape,
      onPressed: onPressed,
      backgroundColor: color,
      child: widget,
    );
  }
}
