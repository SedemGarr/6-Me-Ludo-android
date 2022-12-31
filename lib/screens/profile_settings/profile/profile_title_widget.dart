

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../constants/textstyle_constants.dart';
import '../../../providers/user_provider.dart';
import '../../../services/navigation_service.dart';

class ProfilePseudonymWidget extends StatelessWidget {
  const ProfilePseudonymWidget({super.key});

  @override
  Widget build(BuildContext context) {
    UserProvider userProvider = context.watch<UserProvider>();

    return GestureDetector(
      onTap: () {
        NavigationService.goToEditPseudonymScreen();
      },
      child: Text(
        userProvider.getUserPseudonym(),
        style: TextStyles.listTitleStyle(
          Theme.of(context).colorScheme.onBackground,
        ),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}
