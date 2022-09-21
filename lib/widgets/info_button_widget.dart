import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../constants/icon_constants.dart';
import 'legal_dialog.dart';

class InfoButtonWidget extends StatelessWidget {
  const InfoButtonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        showLegalDialog(context: context);
      },
      icon: Icon(
        AppIcons.infoIcon,
        color: Get.isDarkMode ? Theme.of(context).colorScheme.onSurface : Theme.of(context).colorScheme.onPrimary,
      ),
    );
  }
}
