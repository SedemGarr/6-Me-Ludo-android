

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:multiavatar/multiavatar.dart';
import 'package:provider/provider.dart';

import '../../../constants/app_constants.dart';
import '../../../providers/user_provider.dart';
import '../../../services/navigation_service.dart';

class ProfileAvatarWidget extends StatelessWidget {
  const ProfileAvatarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    UserProvider userProvider = context.watch<UserProvider>();

    return GestureDetector(
      onTap: () {
        NavigationService.goToEditAvatarScreen();
      },
      child: CircleAvatar(
        child: AnimatedContainer(
          duration: AppConstants.animationDuration,
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
            border: Border.all(
              color: Theme.of(context).colorScheme.onBackground,
              width: 2,
            ),
            shape: BoxShape.circle,
          ),
          child: SvgPicture.string(
            multiavatar(
              userProvider.getUserAvatar(),
              trBackground: true,
            ),
          ),
        ),
      ),
    );
  }
}
