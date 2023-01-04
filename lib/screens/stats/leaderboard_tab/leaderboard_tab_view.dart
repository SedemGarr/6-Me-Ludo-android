import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:six_me_ludo_android/models/user.dart';
import 'package:six_me_ludo_android/providers/user_provider.dart';
import 'package:six_me_ludo_android/screens/stats/leaderboard_tab/widgets/leaderboard_list.dart';
import 'package:six_me_ludo_android/screens/stats/leaderboard_tab/widgets/leaderboard_offline.dart';
import 'package:six_me_ludo_android/screens/stats/leaderboard_tab/widgets/no_leaderboard.dart';
import 'package:six_me_ludo_android/services/database_service.dart';
import 'package:six_me_ludo_android/widgets/loading/loading_widget.dart';

class LeaderboardTabView extends StatefulWidget {
  const LeaderboardTabView({super.key});

  @override
  State<LeaderboardTabView> createState() => _LeaderboardTabViewState();
}

class _LeaderboardTabViewState extends State<LeaderboardTabView> with AutomaticKeepAliveClientMixin {
  late Future<List<Users>> leaderBoardFuture;
  late UserProvider userProvider;

  @override
  void initState() {
    super.initState();
    userProvider = context.read<UserProvider>();
    leaderBoardFuture = DatabaseService.getAllUsersSorted();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return userProvider.getUserIsOffline()
        ? const LeaderboardOfflineWidget()
        : FutureBuilder<List<Users>>(
            future: leaderBoardFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const LoadingWidget();
              } else if (snapshot.connectionState == ConnectionState.done && snapshot.hasData) {
                return LeaderboardList(users: snapshot.data!);
              } else if (snapshot.connectionState == ConnectionState.done && !snapshot.hasData || snapshot.hasError || snapshot.connectionState == ConnectionState.none) {
                return const NoLeaderboardWidget();
              } else {
                return const NoLeaderboardWidget();
              }
            },
          );
  }

  @override
  bool get wantKeepAlive => true;
}
