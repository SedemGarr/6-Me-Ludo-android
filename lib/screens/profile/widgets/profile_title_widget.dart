import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:six_me_ludo_android/providers/user_provider.dart';

import '../../../constants/textstyle_constants.dart';

class ProfilePseudonymWidget extends StatelessWidget {
  const ProfilePseudonymWidget({super.key});

  @override
  Widget build(BuildContext context) {
    UserProvider userProvider = context.watch<UserProvider>();

    return Text(
      userProvider.getUserPseudonym(),
      style: TextStyles.listTitleStyle(
        Theme.of(context).colorScheme.onBackground,
      ),
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
    );
  }
}
