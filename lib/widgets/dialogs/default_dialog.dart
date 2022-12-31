import 'package:css_colors/css_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../constants/app_constants.dart';

showDefaultDialog({
  required BuildContext context,
  required bool isDismissible,
  required VoidCallback? onPop,
  required Widget title,
  required Widget content,
  required List<Widget> actions,
  EdgeInsets? contentPadding,
}) {
  bool shouldOverridePop = onPop != null;

  return showDialog(
    context: context,
    barrierDismissible: isDismissible,
    builder: (context) {
      return WillPopScope(
        onWillPop: () async {
          if (shouldOverridePop) {
            onPop();
          }
          return !shouldOverridePop;
        },
        child: AlertDialog(
          backgroundColor: Get.isDarkMode ? CSSColors.darkSlateGray : null,
          shape: AppConstants.appShape,
          contentPadding: contentPadding,
          title: title,
          content: content,
          actions: actions,
        ),
      );
    },
  );
}
