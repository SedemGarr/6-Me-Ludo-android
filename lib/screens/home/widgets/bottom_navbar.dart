import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:six_me_ludo_android/constants/app_constants.dart';
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
        : NavigationBar(
            //   backgroundColor: Colors.transparent,
            animationDuration: AppConstants.animationDuration,
            //    elevation: 0,
            // height: kBottomNavigationBarHeight,
            labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
            selectedIndex: navProvider.getBottomNavBarIndex(),
            onDestinationSelected: (index) async => navProvider.setBottomNavBarIndex(index, true),
            destinations: [
              NavigationDestination(
                icon: const Icon(
                  AppIcons.homeIcon,
                ),
                selectedIcon: const Icon(
                  AppIcons.homeActiveIcon,
                ),
                label: DialogueService.homeText.tr,
              ),
              NavigationDestination(
                icon: const Icon(
                  AppIcons.profileIcon,
                ),
                selectedIcon: const Icon(
                  AppIcons.profileActiveIcon,
                ),
                label: DialogueService.profileText.tr,
              ),

              // NavigationDestination(
              //   icon: const Icon(
              //     AppIcons.newGameIcon,
              //   ),
              //   selectedIcon: const Icon(
              //     AppIcons.newGameActiveIcon,
              //   ),
              //   label: DialogueService.newGameText.tr,
              // ),
            ],
          );

    // return appProvider.isLoading
    //     ? const SizedBox.shrink()
    //     : BottomNavigationBar(
    //         elevation: 0,
    //         showSelectedLabels: false,
    //         showUnselectedLabels: false,
    //         currentIndex: navProvider.getBottomNavBarIndex(),
    //         onTap: (index) async => navProvider.setBottomNavBarIndex(index, true),
    //         items: [
    //           BottomNavigationBarItem(
    //             icon: const Icon(
    //               AppIcons.profileIcon,
    //             ),
    //             activeIcon: const Icon(
    //               AppIcons.profileActiveIcon,
    //             ),
    //             label: DialogueService.profileText.tr,
    //           ),
    //           BottomNavigationBarItem(
    //             icon: const Icon(
    //               AppIcons.homeIcon,
    //             ),
    //             activeIcon: const Icon(
    //               AppIcons.homeActiveIcon,
    //             ),
    //             label: DialogueService.homeText.tr,
    //           ),
    //           BottomNavigationBarItem(
    //             icon: const Icon(
    //               AppIcons.newGameIcon,
    //             ),
    //             activeIcon: const Icon(
    //               AppIcons.newGameActiveIcon,
    //             ),
    //             label: DialogueService.newGameText.tr,
    //           ),
    //         ],
    //       );
  }
}
