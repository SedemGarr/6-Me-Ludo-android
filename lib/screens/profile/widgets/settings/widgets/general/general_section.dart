import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:six_me_ludo_android/screens/profile/widgets/settings/widgets/general/widgets/audio.dart';
import 'package:six_me_ludo_android/screens/profile/widgets/settings/widgets/general/widgets/dark_mode.dart';
import 'package:six_me_ludo_android/screens/profile/widgets/settings/widgets/general/widgets/language.dart';
import 'package:six_me_ludo_android/screens/profile/widgets/settings/widgets/settings_header.dart';
import 'package:six_me_ludo_android/services/translations/dialogue_service.dart';

class GeneralSettingsSection extends StatelessWidget {
  const GeneralSettingsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SettingsHeaderWidget(text: DialogueService.generalSettingsText.tr),
        const DarkModeWidget(),
        const Divider(),
        const AudioWidget(),
        const Divider(),
        const LanguageWidget(),
      ],
    );
  }
}
