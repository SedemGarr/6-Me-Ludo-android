import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:six_me_ludo_android/screens/profile/widgets/settings/widgets/account/widgets/delete_account_widget.dart';
import 'package:six_me_ludo_android/screens/profile/widgets/settings/widgets/account/widgets/sign_out_widget.dart';

import '../../../../../../services/translations/dialogue_service.dart';
import '../settings_header.dart';

class AccountSettingsSection extends StatelessWidget {
  const AccountSettingsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SettingsHeaderWidget(text: DialogueService.accountSettingsText.tr),
        const SignOutWidget(),
        const Divider(),
        const DeleteAcountWidget(),
      ],
    );
  }
}
