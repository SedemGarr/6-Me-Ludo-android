import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:multiavatar/multiavatar.dart';
import 'package:provider/provider.dart';
import 'package:six_me_ludo_android/providers/user_provider.dart';

import '../constants/app_constants.dart';

class UserAvatarWidget extends StatelessWidget {
  final String? id;
  final bool? shouldExpand;
  final String avatar;
  final Color backgroundColor;
  final Color borderColor;

  const UserAvatarWidget({super.key, required this.backgroundColor, this.id, required this.avatar, this.shouldExpand, required this.borderColor});

  @override
  Widget build(BuildContext context) {
    UserProvider userProvider = context.watch<UserProvider>();
    bool isExpanding = shouldExpand != null;

    Widget avatarWidget = AnimatedContainer(
      duration: AppConstants.animationDuration,
      decoration: BoxDecoration(
        color: backgroundColor,
        border: Border.all(
          color: borderColor,
          width: 2,
        ),
        shape: BoxShape.circle,
      ),
      child: SvgPicture.string(
        multiavatar(
          avatar,
          trBackground: true,
        ),
      ),
    );

    return GestureDetector(
      onTap: id == null
          ? null
          : () {
              userProvider.handleUserAvatarOnTap(id!, context);
            },
      child: isExpanding
          ? avatarWidget
          : CircleAvatar(
              child: avatarWidget,
            ),
    );
  }
}
