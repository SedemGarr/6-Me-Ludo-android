import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:provider/provider.dart';
import 'package:six_me_ludo_android/models/game.dart';
import 'package:six_me_ludo_android/providers/user_provider.dart';
import 'package:six_me_ludo_android/screens/home/widgets/no_games_widget.dart';
import 'package:six_me_ludo_android/screens/home/widgets/on_going_games/ongoing_games_list_item.dart';
import 'package:six_me_ludo_android/widgets/animation_wrapper.dart';
import 'package:six_me_ludo_android/widgets/loading_widget.dart';

import '../../../../constants/app_constants.dart';

class OngoingGamesListWidget extends StatelessWidget {
  const OngoingGamesListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    UserProvider userProvider = context.watch<UserProvider>();

    return StreamBuilder<List<Game>>(
        stream: userProvider.onGoingGamesStream,
        initialData: userProvider.getUserOngoingGames(),
        builder: (BuildContext context, AsyncSnapshot<List<Game>> snapshot) {
          if (snapshot.hasData) {
            userProvider.syncOnGoingGamesList(snapshot.data!);

            return !userProvider.hasOngoingGames()
                ? const NoGamesWidget()
                : AnimationLimiter(
                    child: ListView.builder(
                      itemCount: userProvider.getUserOngoingGamesLength(),
                      padding: AppConstants.listViewBottomPadding,
                      itemBuilder: (context, index) {
                        return AnimationConfiguration.staggeredList(
                          position: index,
                          duration: AppConstants.animationDuration,
                          child: CustomAnimationWidget(
                            child: OnGoingGamesListItemWidget(index: index),
                          ),
                        );
                      },
                    ),
                  );
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return const LoadingWidget();
          } else {
            return const NoGamesWidget();
          }
        });
  }
}
