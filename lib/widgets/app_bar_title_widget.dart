import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../constants/textstyle_constants.dart';

class AppBarTitleWidget extends StatelessWidget {
  final String text;

  const AppBarTitleWidget({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    

    return Text(
      text,
      style: TextStyles.appBarTitleStyle(
        Get.isDarkMode ? Theme.of(context).colorScheme.onSurface : Theme.of(context).colorScheme.onPrimary,
      ),
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
    );
  }
}
