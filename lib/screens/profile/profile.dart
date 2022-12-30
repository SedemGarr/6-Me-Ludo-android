import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:six_me_ludo_android/screens/profile/widgets/profile_settings_section.dart';
import 'package:six_me_ludo_android/services/navigation_service.dart';
import 'package:six_me_ludo_android/services/translations/dialogue_service.dart';

import 'package:six_me_ludo_android/widgets/buttons/back_button_widget.dart';

import '../../providers/app_provider.dart';
import '../../widgets/appbar/app_bar_title_widget.dart';
import '../../widgets/appbar/custom_appbar.dart';
import '../../widgets/loading/loading_screen.dart';

class ProfileScreen extends StatelessWidget {
  static int routeIndex = 1;

  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    AppProvider appProvider = context.watch<AppProvider>();

    return appProvider.isLoading
        ? LoadingScreen(
            text: DialogueService.loadingDefaultText.tr,
          )
        : Scaffold(
            appBar: CustomAppBarWidget(
              title: AppBarTitleWidget(text: DialogueService.profileAndSettingsText.tr),
              leading: BackButtonWidget(
                onPressed: () {
                  NavigationService.genericGoBack();
                },
              ),
            ),
            body: const ProfileSettingsSection(),
          );
  }
}
