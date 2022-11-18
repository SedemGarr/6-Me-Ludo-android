import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:six_me_ludo_android/constants/icon_constants.dart';

class DrawerButtonWidget extends StatelessWidget {
  const DrawerButtonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        Scaffold.of(context).openDrawer();
      },
      icon: Icon(
        AppIcons.drawerMenuIcon,
        color: Get.isDarkMode ? Theme.of(context).primaryColor : Theme.of(context).colorScheme.onPrimary,
      ),
    );
  }
}
