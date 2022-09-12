import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:six_me_ludo_android/providers/app_provider.dart';
import 'package:six_me_ludo_android/services/translations/dialogue_service.dart';

import '../../../constants/icon_constants.dart';
import '../../../providers/nav_provider.dart';

class CustomBottomNavBar extends StatelessWidget {
  const CustomBottomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    NavProvider navProvider = context.watch<NavProvider>();
    AppProvider appProvider = context.watch<AppProvider>();

    return appProvider.isLoading
        ? const SizedBox.shrink()
        : BottomNavigationBar(
            elevation: 0,
            showSelectedLabels: false,
            showUnselectedLabels: false,
            currentIndex: navProvider.getBottomNavBarIndex(),
            onTap: (index) async => navProvider.setBottomNavBarIndex(index, true),
            items: [
              BottomNavigationBarItem(
                icon: const Icon(
                  AppIcons.profileIcon,
                ),
                activeIcon: const Icon(
                  AppIcons.profileActiveIcon,
                ),
                label: DialogueService.newGameText.tr,
              ),
              BottomNavigationBarItem(
                icon: const Icon(
                  AppIcons.homeIcon,
                ),
                activeIcon: const Icon(
                  AppIcons.homeActiveIcon,
                ),
                label: DialogueService.newGameText.tr,
              ),
              BottomNavigationBarItem(
                icon: const Icon(
                  AppIcons.newGameIcon,
                ),
                activeIcon: const Icon(
                  AppIcons.newGameActiveIcon,
                ),
                label: DialogueService.newGameText.tr,
              ),
            ],
          );
  }
}
