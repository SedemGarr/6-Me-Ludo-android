import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:multiavatar/multiavatar.dart';

import '../models/user.dart';

class UserAvatarWidget extends StatelessWidget {
  final Users user;

  const UserAvatarWidget({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // TODO handle taps
      },
      child: CircleAvatar(
        backgroundColor: Get.isDarkMode ? Theme.of(context).colorScheme.onSurface : Theme.of(context).colorScheme.onPrimary,
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: SvgPicture.string(
            multiavatar(
              user.avatar,
              trBackground: true,
            ),
          ),
        ),
      ),
    );
  }
}
