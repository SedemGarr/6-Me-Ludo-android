import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:six_me_ludo_android/widgets/user_avatar_widget.dart';

import '../providers/user_provider.dart';

class AppBarAvatarWidget extends StatelessWidget {
  const AppBarAvatarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    UserProvider userProvider = context.watch<UserProvider>();

    return Padding(
      padding: const EdgeInsets.only(left: 8.0),
      child: UserAvatarWidget(
        user: userProvider.getUser(),
        isBackgroundTransparent: true,
      ),
    );
  }
}
