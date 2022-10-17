import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:six_me_ludo_android/constants/app_constants.dart';
import 'package:six_me_ludo_android/providers/nav_provider.dart';
import 'package:six_me_ludo_android/providers/user_provider.dart';
import 'package:six_me_ludo_android/screens/home/home.dart';
import 'package:six_me_ludo_android/screens/profile/widgets/profile_section_widget.dart';
import 'package:six_me_ludo_android/screens/profile/widgets/profile_settings_section.dart';
import 'package:six_me_ludo_android/screens/profile/widgets/settings/widgets/avatar_selector_widget.dart';
import 'package:six_me_ludo_android/services/translations/dialogue_service.dart';
import 'package:six_me_ludo_android/utils/utils.dart';
import 'package:six_me_ludo_android/widgets/app_bar_title_widget.dart';
import 'package:six_me_ludo_android/widgets/back_button_widget.dart';
import 'package:six_me_ludo_android/widgets/info_button_widget.dart';

import '../../providers/app_provider.dart';
import '../../widgets/custom_appbar.dart';
import '../../widgets/loading_screen.dart';

class ProfileScreen extends StatelessWidget {
  static int routeIndex = 1;

  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    AppProvider appProvider = context.watch<AppProvider>();
    UserProvider userProvider = context.watch<UserProvider>();
    NavProvider navProvider = context.watch<NavProvider>();

    return appProvider.isLoading
        ? const LoadingScreen()
        : GestureDetector(
            onTap: () {
              if (userProvider.isEditingProfile) {
                userProvider.toggleIsEditingProfile(false);
                Utils.dismissKeyboard();
              }
            },
            child: Scaffold(
              appBar: CustomAppBarWidget(
                title: AppBarTitleWidget(text: userProvider.isEditingProfile ? DialogueService.editProfileText.tr : DialogueService.profileText.tr),
                leading: BackButtonWidget(onPressed: () {
                  navProvider.setBottomNavBarIndex(HomeScreen.routeIndex, true);
                }),
                actions: const [InfoButtonWidget()],
                bottom: PreferredSize(
                  preferredSize: Size.fromHeight(AppConstants.profileAppbarHeight),
                  child: const ProfileSectionWidget(),
                ),
                size: (AppConstants.profileAppbarHeight),
              ),
              body: userProvider.isEditingProfile ? const AvatarSelectionWidget() : const ProfileSettingsSection(),
            ),
          );
  }
}
