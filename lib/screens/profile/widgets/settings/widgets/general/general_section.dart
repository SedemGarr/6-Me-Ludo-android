import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:six_me_ludo_android/screens/profile/widgets/settings/widgets/general/widgets/audio.dart';
import 'package:six_me_ludo_android/screens/profile/widgets/settings/widgets/general/widgets/dark_mode.dart';
import 'package:six_me_ludo_android/screens/profile/widgets/settings/widgets/general/widgets/language.dart';
import 'package:six_me_ludo_android/screens/profile/widgets/settings/widgets/general/widgets/theme.dart';
import 'package:six_me_ludo_android/screens/profile/widgets/settings/widgets/general/widgets/wakelock.dart';
import 'package:six_me_ludo_android/screens/profile/widgets/settings/widgets/settings_header.dart';
import 'package:six_me_ludo_android/services/translations/dialogue_service.dart';
import 'package:six_me_ludo_android/widgets/custom_card_widget.dart';


import '../game/widgets/profanity.dart';

class GeneralSettingsSection extends StatelessWidget {
  const GeneralSettingsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomCardWidget(
      
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SettingsHeaderWidget(text: DialogueService.generalSettingsText.tr),
          const ThemeWidget(),
          //  const Divider(),
          const DarkModeWidget(),
          //  const Divider(),
          const AudioWidget(),
          //   const Divider(),
          const WakelockWidget(),
          //  const Divider(),
          const ProfaneMessages(),
          //  const Divider(),
          const LanguageWidget(),
        ],
      ),
    );
  }
}
