import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:six_me_ludo_android/screens/profile_settings/settings/widgets/account/widgets/delete_account_widget.dart';
import 'package:six_me_ludo_android/screens/profile_settings/settings/widgets/account/widgets/sign_out_widget.dart';

import '../../../../../providers/user_provider.dart';
import '../../../../../services/translations/dialogue_service.dart';
import '../settings_header.dart';

class AccountSettingsSection extends StatelessWidget {
  const AccountSettingsSection({super.key});

  @override
  Widget build(BuildContext context) {
    UserProvider userProvider = context.watch<UserProvider>();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (!userProvider.getUserIsOffline()) SettingsHeaderWidget(text: DialogueService.accountSettingsText.tr),
        const SignOutWidget(),
        const DeleteAcountWidget(),
      ],
    );
  }
}
