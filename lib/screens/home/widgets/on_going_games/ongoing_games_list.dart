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

    return Expanded(
      child: StreamBuilder<List<Game>>(
          stream: userProvider.onGoingGamesStream,
          initialData: userProvider.ongoingGames,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting && !snapshot.hasData) {
              return const LoadingWidget();
            } else if (snapshot.hasData) {
              userProvider.syncOngoingGamesStreamData(snapshot.data!);

              return userProvider.ongoingGames.isEmpty
                  ? const NoGamesWidget()
                  : AnimationLimiter(
                      child: ListView.separated(
                        key: PageStorageKey(UniqueKey()),
                        //   shrinkWrap: true,
                        itemCount: userProvider.ongoingGames.length,
                        padding: AppConstants.listViewPadding,
                        separatorBuilder: (context, index) => const SizedBox(
                          height: 8.0,
                        ),
                        itemBuilder: (context, index) {
                          return AnimationConfiguration.staggeredList(
                            position: index,
                            duration: AppConstants.animationDuration,
                            child: CustomAnimationWidget(
                              child: OnGoingGamesListItemWidget(game: userProvider.ongoingGames[index]),
                            ),
                          );
                        },
                      ),
                    );
            } else {
              return const NoGamesWidget();
            }
          }),
    );
  }
}
