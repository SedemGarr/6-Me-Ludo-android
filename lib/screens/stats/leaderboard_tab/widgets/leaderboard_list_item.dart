import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:multiavatar/multiavatar.dart';
import 'package:six_me_ludo_android/constants/icon_constants.dart';
import 'package:six_me_ludo_android/constants/textstyle_constants.dart';
import 'package:six_me_ludo_android/models/user.dart';
import 'package:six_me_ludo_android/widgets/dialogs/user_dialog.dart';
import 'package:six_me_ludo_android/widgets/general/custom_card_widget.dart';
import 'package:six_me_ludo_android/widgets/general/custom_list_tile.dart';

import '../../../../constants/app_constants.dart';

class LeaderboardListItem extends StatelessWidget {
  final Users user;
  final int index;
  final bool isMe;

  const LeaderboardListItem({
    Key? key,
    required this.user,
    required this.index,
    required this.isMe,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isFirst = index == 0;

    return CustomCardWidget(
      backgroundColor: isMe ? Theme.of(context).colorScheme.primary : null,
      child: CustomListTileWidget(
        onTap: () {
          showUserDialog(
            user: user,
            context: context,
          );
        },
        dense: !isFirst,
        leading: CircleAvatar(
          backgroundColor: Colors.transparent,
          child: Container(
            decoration: BoxDecoration(
              color: isMe ? Theme.of(context).colorScheme.primary : Theme.of(context).colorScheme.primary.withOpacity(AppConstants.appOpacity),
              border: Border.all(
                color: isMe ? Theme.of(context).colorScheme.onPrimary : Theme.of(context).colorScheme.onPrimaryContainer,
                width: 2,
              ),
              shape: BoxShape.circle,
            ),
            child: SvgPicture.string(
              multiavatar(
                user.avatar,
                trBackground: true,
              ),
              color: null,
            ),
          ),
        ),
        title: Text(
          user.psuedonym,
          style: TextStyles.listTitleStyle(isMe ? Theme.of(context).colorScheme.onPrimary : Theme.of(context).colorScheme.onPrimaryContainer),
        ),
        subtitle: Text(
          user.rankingValue.toStringAsFixed(2),
          style: TextStyles.listSubtitleStyle(isMe ? Theme.of(context).colorScheme.onPrimary : Theme.of(context).colorScheme.onPrimaryContainer),
        ),
        trailing: isFirst
            ? Icon(
                AppIcons.leaderboardFirstIcon,
                color: isMe ? Theme.of(context).colorScheme.onPrimary : Theme.of(context).primaryColor,
              )
            : Text(
                (index + 1).toString(),
                style: TextStyles.listSubtitleStyle(isMe ? Theme.of(context).colorScheme.onPrimary : Theme.of(context).colorScheme.primary),
              ),
      ),
    );
  }
}
