import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:six_me_ludo_android/providers/app_provider.dart';
import 'package:six_me_ludo_android/screens/profile/widgets/settings/widgets/settings_header.dart';
import 'package:six_me_ludo_android/services/navigation_service.dart';
import 'package:six_me_ludo_android/services/translations/dialogue_service.dart';
import 'package:six_me_ludo_android/widgets/custom_animated_crossfade.dart';
import 'package:six_me_ludo_android/widgets/dialogs/join_game_dialog.dart';
import 'package:six_me_ludo_android/widgets/dialogs/new_game_dialog.dart';

import '../../../constants/app_constants.dart';
import '../../../constants/textstyle_constants.dart';
import '../../../providers/user_provider.dart';
import '../../../widgets/custom_card_widget.dart';
import '../../../widgets/custom_list_tile.dart';
import '../../../widgets/user_avatar_widget.dart';
import '../../profile/widgets/settings/widgets/general/widgets/dark_mode.dart';
import '../../profile/widgets/settings/widgets/general/widgets/offline.dart';

class HomeDrawerWidget extends StatelessWidget {
  const HomeDrawerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    UserProvider userProvider = context.watch<UserProvider>();

    return Drawer(
      shape: AppConstants.appShape,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColorDark,
            ),
            margin: EdgeInsets.zero,
            padding: EdgeInsets.zero,
            curve: AppConstants.animationCurve,
            duration: AppConstants.animationDuration,
            child: Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 16.0),
                    child: UserAvatarWidget(
                      avatar: userProvider.getUserAvatar(),
                      backgroundColor: Get.isDarkMode ? Theme.of(context).primaryColor : Theme.of(context).colorScheme.onPrimary,
                      borderColor: Theme.of(context).colorScheme.onBackground,
                      id: userProvider.getUserID(),
                      hasLeftGame: false,
                      shouldExpand: true,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(
                top: 8.0,
                left: 4.0,
                right: 4.0,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SettingsHeaderWidget(text: DialogueService.gameSettingsText.tr),
                  CustomCardWidget(
                    child: CustomListTileWidget(
                      //     leading: const Icon(AppIcons.newGameIcon),
                      title: Text(
                        DialogueService.hostGameFABText.tr,
                        style: TextStyles.listTitleStyle(Theme.of(context).colorScheme.onBackground),
                      ),
                      onTap: () {
                        NavigationService.genericGoBack();
                        showNewGameDialog(context: context);
                      },
                    ),
                  ),
                  CustomAnimatedCrossFade(
                      firstChild: const SizedBox.shrink(),
                      secondChild: CustomCardWidget(
                        child: CustomListTileWidget(
                          //    leading: const Icon(AppIcons.joinGameIcon),
                          title: Text(
                            DialogueService.joinGameFABText.tr,
                            style: TextStyles.listTitleStyle(Theme.of(context).colorScheme.onBackground),
                          ),
                          onTap: () {
                            NavigationService.genericGoBack();
                            showJoinGameDialog(context: context);
                          },
                        ),
                      ),
                      condition: userProvider.getUserIsOffline()),
                  SettingsHeaderWidget(text: DialogueService.personalisationSettingsText.tr),
                  CustomCardWidget(
                    child: CustomListTileWidget(
                      //     leading: const Icon(AppIcons.profileIcon),
                      title: Text(
                        DialogueService.profileAndSettingsText.tr,
                        style: TextStyles.listTitleStyle(Theme.of(context).colorScheme.onBackground),
                      ),
                      onTap: () {
                        NavigationService.genericGoBack();
                        NavigationService.goToProfileScreen();
                      },
                    ),
                  ),
                  const DarkModeWidget(),
                  const OfflineModeWidget(),
                  const Spacer(),
                  const Divider(),
                  CustomAnimatedCrossFade(
                      firstChild: const SizedBox.shrink(),
                      secondChild: CustomCardWidget(
                        child: CustomListTileWidget(
                          //        leading: const Icon(AppIcons.signOutIcon),
                          title: Text(
                            userProvider.isUserAnon() ? DialogueService.deleteAccountTitleText.tr : DialogueService.signOutTitleText.tr,
                            style: TextStyles.listTitleStyle(Theme.of(context).colorScheme.onBackground),
                          ),
                          onTap: () {
                            if (userProvider.isUserAnon()) {
                              userProvider.showDeleteAccountDialog(context);
                            } else {
                              userProvider.showSignOutDialog(context);
                            }
                          },
                        ),
                      ),
                      condition: userProvider.getUserIsOffline()),
                  CustomCardWidget(
                    child: CustomListTileWidget(
                      //       leading: const Icon(AppIcons.exitIcon),
                      title: Text(
                        DialogueService.exitAppText.tr,
                        style: TextStyles.listTitleStyle(Theme.of(context).colorScheme.onBackground),
                      ),
                      onTap: () {
                        NavigationService.genericGoBack();
                        AppProvider.showExitDialog(context);
                      },
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
