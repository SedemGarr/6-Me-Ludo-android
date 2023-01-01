import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:multiavatar/multiavatar.dart';
import 'package:six_me_ludo_android/constants/textstyle_constants.dart';
import 'package:six_me_ludo_android/models/user.dart';
import 'package:six_me_ludo_android/widgets/dialogs/user_dialog.dart';
import 'package:six_me_ludo_android/widgets/general/custom_card_widget.dart';
import 'package:six_me_ludo_android/widgets/general/custom_list_tile.dart';

import '../../../../constants/app_constants.dart';

class LeaderboardListItem extends StatelessWidget {
  final Users user;
  final int index;

  const LeaderboardListItem({Key? key, required this.user, required this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double percentageWon = user.stats.numberOfWins == 0 ? 0 : (user.stats.numberOfWins / user.stats.numberOfGames) * 100;

    return CustomCardWidget(
      child: CustomListTileWidget(
        onTap: () {
          showUserDialog(user: user, context: context);
        },
        dense: true,
        leading: CircleAvatar(
          backgroundColor: Colors.transparent,
          child: Container(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary.withOpacity(AppConstants.appOpacity),
              border: Border.all(
                color: Theme.of(context).colorScheme.onPrimaryContainer,
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
          style: TextStyles.listTitleStyle(Theme.of(context).colorScheme.onPrimaryContainer),
        ),
        subtitle: Text(
          '${percentageWon.toStringAsFixed(1)}%',
          style: TextStyles.listSubtitleStyle(Theme.of(context).colorScheme.primary),
        ),
        trailing: Text(
          (index + 1).toString(),
          style: TextStyles.listSubtitleStyle(Theme.of(context).colorScheme.secondary),
        ),
      ),
    );
  }
}
