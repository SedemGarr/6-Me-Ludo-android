import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:six_me_ludo_android/providers/user_provider.dart';
import 'package:six_me_ludo_android/services/translations/dialogue_service.dart';

import '../../../constants/textstyle_constants.dart';

class ProfileStatusWidget extends StatelessWidget {
  const ProfileStatusWidget({super.key});

  @override
  Widget build(BuildContext context) {
    UserProvider userProvider = context.watch<UserProvider>();
    final String status = userProvider.isUserAnon()
        ? DialogueService.anonAccountText.tr
        : userProvider.getUserEmail().isEmpty
            ? DialogueService.verifiedAccountText.tr
            : userProvider.getUserEmail();

    return Text(
      status,
      style: TextStyles.listSubtitleStyle(
        Theme.of(context).colorScheme.primary,
      ),
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
    );
  }
}
