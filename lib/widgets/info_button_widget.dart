import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../constants/icon_constants.dart';

class InfoButtonWidget extends StatelessWidget {
  const InfoButtonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {},
      icon: Icon(
        AppIcons.infoIcon,
        color: Get.isDarkMode ? Theme.of(context).primaryColor : Theme.of(context).colorScheme.onPrimary,
      ),
    );
  }
}
