import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:six_me_ludo_android/screens/profile/widgets/profile_section_widget.dart';
import 'package:six_me_ludo_android/screens/profile/widgets/profile_settings_section.dart';
import 'package:six_me_ludo_android/services/translations/dialogue_service.dart';
import 'package:six_me_ludo_android/widgets/app_bar_title_widget.dart';
import 'package:six_me_ludo_android/widgets/info_button_widget.dart';

import '../../widgets/custom_appbar.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBarWidget(
        centerTitle: true,
        title: AppBarTitleWidget(text: DialogueService.profileText.tr),
        leading: const InfoButtonWidget(),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(Get.height * 1 / 4),
          child: const ProfileSectionWidget(),
        ),
        size: ((Get.height * 1 / 4) + kToolbarHeight),
      ),
      body: const ProfileSettingsSection(),
    );
  }
}
