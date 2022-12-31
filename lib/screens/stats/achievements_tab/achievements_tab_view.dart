import 'package:flutter/material.dart';
import 'package:six_me_ludo_android/constants/textstyle_constants.dart';

class AchievementsTabView extends StatelessWidget {
  const AchievementsTabView({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Coming Soon',
        style: TextStyles.noGamesStyle(
          Theme.of(context).colorScheme.primary,
        ),
      ),
    );
  }
}
