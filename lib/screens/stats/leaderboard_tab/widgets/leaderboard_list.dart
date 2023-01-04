import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:six_me_ludo_android/constants/app_constants.dart';
import 'package:six_me_ludo_android/providers/user_provider.dart';
import 'package:six_me_ludo_android/screens/stats/leaderboard_tab/widgets/leaderboard_list_item.dart';
import 'package:six_me_ludo_android/screens/stats/leaderboard_tab/widgets/no_leaderboard.dart';
import 'package:six_me_ludo_android/services/translations/dialogue_service.dart';
import 'package:six_me_ludo_android/widgets/buttons/custom_elevated_button.dart';
import 'package:six_me_ludo_android/widgets/text/banner_widget.dart';
import 'package:six_me_ludo_android/widgets/wrappers/animation_wrapper.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

import '../../../../models/user.dart';

class LeaderboardList extends StatefulWidget {
  final List<Users> users;

  const LeaderboardList({super.key, required this.users});

  @override
  State<LeaderboardList> createState() => _LeaderboardListState();
}

class _LeaderboardListState extends State<LeaderboardList> {
  late ItemScrollController itemScrollController;

  @override
  void initState() {
    super.initState();
    itemScrollController = ItemScrollController();
  }

  @override
  Widget build(BuildContext context) {
    UserProvider userProvider = context.watch<UserProvider>();
    Users me = userProvider.getUser();

    return widget.users.isEmpty
        ? const NoLeaderboardWidget()
        : Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              BannerWidget(text: DialogueService.leaderBoardBannerText.tr),
              Flexible(
                child: AnimationLimiter(
                    child: ScrollablePositionedList.builder(
                  itemScrollController: itemScrollController,
                  padding: AppConstants.listViewPadding,
                  itemCount: widget.users.length,
                  itemBuilder: (context, index) {
                    return AnimationConfiguration.staggeredList(
                      position: index,
                      duration: AppConstants.animationDuration,
                      child: CustomAnimationWidget(
                        child: LeaderboardListItem(
                          user: widget.users[index],
                          index: index,
                          isMe: widget.users[index].id == userProvider.getUserID(),
                        ),
                      ),
                    );
                  },
                )),
              ),
              if (widget.users.contains(me))
                Container(
                  width: Get.width,
                  padding: const EdgeInsets.all(8.0),
                  child: CustomElevatedButton(
                    onPressed: () {
                      itemScrollController.scrollTo(
                        index: widget.users.indexWhere((element) => element == me),
                        duration: AppConstants.listScrollDuration,
                        curve: AppConstants.animationCurve,
                        alignment: 0.1,
                      );
                    },
                    text: DialogueService.leaderboardFindMeButtonText.tr,
                  ),
                ),
            ],
          );
  }
}
