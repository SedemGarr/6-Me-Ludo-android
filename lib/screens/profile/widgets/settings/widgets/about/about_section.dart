import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:six_me_ludo_android/screens/profile/widgets/settings/widgets/about/widgets/license.dart';
import 'package:six_me_ludo_android/screens/profile/widgets/settings/widgets/about/widgets/privacy.dart';
import 'package:six_me_ludo_android/screens/profile/widgets/settings/widgets/about/widgets/terms.dart';
import 'package:six_me_ludo_android/screens/profile/widgets/settings/widgets/about/widgets/version.dart';

import '../../../../../../services/translations/dialogue_service.dart';
import '../settings_header.dart';

class AboutSettingsSection extends StatelessWidget {
  const AboutSettingsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SettingsHeaderWidget(text: DialogueService.aboutSettingsText.tr),
        const VersionSettings(),
        const TermsSettings(),
        const PrivacySettings(),
        const LicenseSettings(),
      ],
    );
  }
}
