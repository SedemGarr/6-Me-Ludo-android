import 'package:flutter/material.dart';
import 'package:six_me_ludo_android/screens/profile_settings/settings/widgets/about/about_section.dart';
import 'package:six_me_ludo_android/screens/profile_settings/settings/widgets/account/account_section.dart';
import 'package:six_me_ludo_android/screens/profile_settings/settings/widgets/game/game_section.dart';
import 'package:six_me_ludo_android/screens/profile_settings/settings/widgets/general/general_section.dart';

import '../../../constants/app_constants.dart';
import '../../../widgets/text/copyright_widget.dart';
import '../profile/profile_section_widget.dart';

class SettingsList extends StatelessWidget {
  const SettingsList({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: AppConstants.listViewPadding,
      children: const [
        ProfileSectionWidget(),
        GeneralSettingsSection(),
        GameSettingsSection(),
        AboutSettingsSection(),
        AccountSettingsSection(),
        CopyrightWidget(),
      ],
    );
  }
}
