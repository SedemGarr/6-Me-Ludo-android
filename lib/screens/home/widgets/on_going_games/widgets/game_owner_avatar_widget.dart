import 'package:flutter/material.dart';
import 'package:six_me_ludo_android/widgets/multiavatar_widget.dart';

class GameOwnerAvatarWidget extends StatelessWidget {
  final String avatar;

  const GameOwnerAvatarWidget({super.key, required this.avatar});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0),
      child: CircleAvatar(
        backgroundColor: Theme.of(context).primaryColor,
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: MultiAvatarWidget(
            avatar: avatar,
            isBackgroundTransparent: true,
          ),
        ),
      ),
    );
  }
}
