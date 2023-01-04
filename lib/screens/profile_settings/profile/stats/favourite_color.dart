import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:six_me_ludo_android/providers/user_provider.dart';
import 'package:six_me_ludo_android/screens/profile_settings/profile/stats/widgets/stats_tile_widget.dart';
import 'package:six_me_ludo_android/services/translations/dialogue_service.dart';

import '../../../../models/user.dart';

class FavouriteColour extends StatelessWidget {
  const FavouriteColour({super.key});

  @override
  Widget build(BuildContext context) {
    UserProvider userProvider = context.read<UserProvider>();
    Users user = userProvider.getUser();
    List<int> favouriteColors = [...user.stats.favouriteColours];
    favouriteColors.sort();
    int favouriteColor = favouriteColors.first;

    return StatsTileWidget(
      titleText: DialogueService.favouriteColorTitleText.tr,
      subTitleText: DialogueService.favouriteColorSubtitleText.tr,
      trailingText: userProvider.parseFavouriteColorText(favouriteColor),
    );
  }
}
