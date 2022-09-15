import 'package:flutter/material.dart';
import 'package:six_me_ludo_android/widgets/reputation_widget.dart';
import 'package:six_me_ludo_android/widgets/user_avatar_widget.dart';
import '../constants/app_constants.dart';
import '../constants/textstyle_constants.dart';
import '../models/user.dart';
import 'custom_list_tile.dart';

showUserDialog({
  required Users user,
  required BuildContext context,
}) {
  return showDialog(
    context: context,
    barrierDismissible: true,
    builder: (BuildContext context) {
      return AlertDialog(
        shape: AppConstants.appShape,
        title: CustomListTileWidget(
          title: Text(
            user.psuedonym,
            style: TextStyles.dialogTitleStyle(Theme.of(context).colorScheme.onSurface),
          ),
          trailing: ReputationWidget(value: user.reputationValue, color: Theme.of(context).colorScheme.onSurface),
        ),
        content: UserAvatarWidget(
          // id: user.id,
          backgroundColor: Theme.of(context).primaryColor,
          borderColor: Theme.of(context).colorScheme.onSurface,
          avatar: user.avatar,
        ),
      );
    },
  );
}
