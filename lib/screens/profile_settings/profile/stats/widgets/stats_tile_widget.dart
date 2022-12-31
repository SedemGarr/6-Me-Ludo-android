import 'package:flutter/material.dart';
import 'package:six_me_ludo_android/screens/profile_settings/profile/stats/widgets/stats_subtitle_widget.dart';
import 'package:six_me_ludo_android/screens/profile_settings/profile/stats/widgets/stats_title_widget.dart';
import 'package:six_me_ludo_android/screens/profile_settings/profile/stats/widgets/stats_trailing_widget.dart';
import 'package:six_me_ludo_android/widgets/general/custom_list_tile.dart';

class StatsTileWidget extends StatelessWidget {
  final String titleText;
  final String subTitleText;
  final String trailingText;

  const StatsTileWidget({super.key, required this.titleText, required this.subTitleText, required this.trailingText});

  @override
  Widget build(BuildContext context) {
    return CustomListTileWidget(
      title: StatsTitleWidget(text: titleText),
      subtitle: StatsSubtitleWidget(text: subTitleText),
      trailing: StatsTrailingWidget(text: trailingText),
      dense: true,
    );
  }
}
