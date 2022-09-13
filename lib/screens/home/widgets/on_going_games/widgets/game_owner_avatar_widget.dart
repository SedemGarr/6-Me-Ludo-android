import 'package:flutter/material.dart';
import 'package:six_me_ludo_android/constants/app_constants.dart';
import 'package:six_me_ludo_android/widgets/multiavatar_widget.dart';

class GameOwnerAvatarWidget extends StatelessWidget {
  final String avatar;

  const GameOwnerAvatarWidget({super.key, required this.avatar});

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundColor: Theme.of(context).primaryColor,
      child: Padding(
        padding: AppConstants.userAvatarPadding,
        child: MultiAvatarWidget(
          avatar: avatar,
          isBackgroundTransparent: true,
        ),
      ),
    );
  }
}
