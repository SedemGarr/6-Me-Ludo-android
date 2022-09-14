import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../constants/icon_constants.dart';

class BackButtonWidget extends StatelessWidget {
  final VoidCallback onPressed;
  final Color? color;

  const BackButtonWidget({super.key, required this.onPressed, this.color});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed,
      icon: Icon(
        AppIcons.backIcon,
        color: color ?? (Get.isDarkMode ? Theme.of(context).primaryColor : Theme.of(context).colorScheme.onPrimary),
      ),
    );
  }
}
