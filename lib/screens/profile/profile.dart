import 'package:flutter/material.dart';
import 'package:six_me_ludo_android/screens/profile/widgets/profile_section_widget.dart';
import 'package:six_me_ludo_android/screens/profile/widgets/profile_settings_section.dart';
import 'package:six_me_ludo_android/services/navigation_service.dart';
import 'package:six_me_ludo_android/widgets/back_button_widget.dart';
import 'package:six_me_ludo_android/widgets/info_button_widget.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        leading: const BackButtonWidget(
          onPressed: NavigationService.genericGoBack,
        ),
        actions: const [InfoButtonWidget()],
      ),
      body: Column(
        children: const [
          ProfileSectionWidget(),
          ProfileSettingsSection(),
        ],
      ),
    );
  }
}
