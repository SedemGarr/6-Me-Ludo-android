import 'package:flutter/material.dart';
import 'package:six_me_ludo_android/screens/profile/widgets/settings/widgets/about/about_section.dart';
import 'package:six_me_ludo_android/screens/profile/widgets/settings/widgets/account/account_section.dart';
import 'package:six_me_ludo_android/screens/profile/widgets/settings/widgets/game/game_section.dart';
import 'package:six_me_ludo_android/screens/profile/widgets/settings/widgets/general/general_section.dart';
import 'package:six_me_ludo_android/widgets/copyright_widget.dart';

import '../../../../constants/app_constants.dart';
import '../profile_section_widget.dart';

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
