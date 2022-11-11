import 'package:flutter/material.dart';
import 'package:six_me_ludo_android/screens/profile/widgets/settings/widgets/account/account_section.dart';
import 'package:six_me_ludo_android/screens/profile/widgets/settings/widgets/game/game_section.dart';
import 'package:six_me_ludo_android/screens/profile/widgets/settings/widgets/general/general_section.dart';

import '../../../../constants/app_constants.dart';
import '../profile_section_widget.dart';

class SettingsList extends StatelessWidget {
  const SettingsList({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: AppConstants.listViewPadding,
      //  shrinkWrap: true,
      children: const [
        ProfileSectionWidget(),
        GeneralSettingsSection(),
        GameSettingsSection(),
        AccountSettingsSection(),
      ],
    );
  }
}
