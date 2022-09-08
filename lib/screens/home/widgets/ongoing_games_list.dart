import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:provider/provider.dart';
import 'package:six_me_ludo_android/providers/user_provider.dart';
import 'package:six_me_ludo_android/screens/home/widgets/no_games_widget.dart';
import 'package:six_me_ludo_android/widgets/animation_wrapper.dart';

import '../../../constants/app_constants.dart';

class OngoingGamesListWidget extends StatelessWidget {
  const OngoingGamesListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    UserProvider userProvider = context.watch<UserProvider>();

    return userProvider.hasOngoingGames()
        ? AnimationLimiter(
            child: ListView.builder(
              itemCount: userProvider.getUserOngoingGamesLength(),
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              itemBuilder: (context, index) {
                return AnimationConfiguration.staggeredList(
                  position: index,
                  duration: AppConstants.animationDuration,
                  child: CustomAnimationWidget(
                    child: Container(),
                  ),
                );
              },
            ),
          )
        : const NoGamesWidget();
  }
}
