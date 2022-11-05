import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:six_me_ludo_android/constants/app_constants.dart';
import 'package:six_me_ludo_android/constants/player_constants.dart';
import 'package:six_me_ludo_android/constants/textstyle_constants.dart';
import 'package:six_me_ludo_android/models/game.dart';
import 'package:six_me_ludo_android/models/player.dart';
import 'package:six_me_ludo_android/providers/game_provider.dart';
import 'package:six_me_ludo_android/providers/user_provider.dart';
import 'package:six_me_ludo_android/screens/home/widgets/on_going_games/widgets/game_owner_avatar_widget.dart';
import 'package:six_me_ludo_android/services/translations/dialogue_service.dart';
import 'package:six_me_ludo_android/widgets/custom_list_tile.dart';
import 'package:six_me_ludo_android/widgets/reputation_widget.dart';
import 'package:six_me_ludo_android/widgets/user_avatar_widget.dart';

class EndGameWidget extends StatefulWidget {
  final GameProvider gameProvider;
  final UserProvider userProvider;

  const EndGameWidget({super.key, required this.gameProvider, required this.userProvider});

  @override
  State<EndGameWidget> createState() => _EndGameWidgetState();
}

class _EndGameWidgetState extends State<EndGameWidget> with AutomaticKeepAliveClientMixin {
  late GameProvider gameProvider;
  late UserProvider userProvider;

  late Game game;
  late bool hasWinner;
  late bool hasViciousOrPunchingBag;
  late Player? winner;
  late Player? vicious;
  late Player? punchingBag;

  @override
  void initState() {
    super.initState();
    gameProvider = context.read<GameProvider>();
    userProvider = context.read<UserProvider>();
    //
    gameProvider.confettiController = ConfettiController(duration: AppConstants.confettiDuration);
    //
    game = widget.gameProvider.currentGame!;
    hasWinner = gameProvider.hasWinner();
    hasViciousOrPunchingBag = gameProvider.hasViciousOrPunchingBag();
    //
    if (hasWinner) {
      winner = gameProvider.getWinnerPlayer();
      gameProvider.handleConfettiDisplay(userProvider.getUserID());
    }
    //
    if (hasViciousOrPunchingBag) {
      vicious = gameProvider.getViciousPlayer();
      punchingBag = gameProvider.getPunchingBagPlayer();
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Expanded(
            child: hasWinner
                ? Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        ConfettiWidget(
                          confettiController: gameProvider.confettiController,
                          blastDirectionality: BlastDirectionality.explosive,
                          colors: [
                            Get.isDarkMode ? PlayerConstants.swatchList[winner!.playerColor].playerSelectedColor : PlayerConstants.swatchList[winner!.playerColor].playerColor
                          ],
                          child: Text(
                            DialogueService.gameWinnerText.tr,
                            style: TextStyles.listTitleStyle(Theme.of(context).colorScheme.onBackground).copyWith(
                              fontSize: 28,
                            ),
                          ),
                        ),
                        Flexible(
                          child: UserAvatarWidget(
                            backgroundColor:
                                Get.isDarkMode ? PlayerConstants.swatchList[winner!.playerColor].playerSelectedColor : PlayerConstants.swatchList[winner!.playerColor].playerColor,
                            avatar: winner!.avatar,
                            borderColor: Theme.of(context).colorScheme.onBackground,
                            shouldExpand: true,
                            id: winner!.isAIPlayer ? null : winner!.id,
                            hasLeftGame: winner!.hasLeft,
                          ),
                        ),
                      ],
                    ),
                  )
                : Center(
                    child: Text(
                      DialogueService.noWinnerText.tr,
                      style: TextStyles.listTitleStyle(Theme.of(context).colorScheme.onBackground),
                    ),
                  ),
          ),
          if (hasViciousOrPunchingBag) const Divider(),
          if (hasViciousOrPunchingBag)
            Expanded(
              flex: hasWinner ? 1 : 2,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      DialogueService.statsTitleText.tr,
                      style: TextStyles.listTitleStyle(
                        Theme.of(context).colorScheme.onBackground,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Column(
                      children: [
                        if (hasViciousOrPunchingBag)
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                    color: PlayerConstants.swatchList[vicious!.playerColor].playerSelectedColor.withOpacity(AppConstants.appOpacity),
                                    borderRadius: AppConstants.appBorderRadius),
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      DialogueService.gameViciousText.tr,
                                      style: TextStyles.listTitleStyle(
                                        Theme.of(context).colorScheme.onBackground,
                                      ),
                                    ),
                                    CustomListTileWidget(
                                      leading: GameOwnerAvatarWidget(
                                        avatar: vicious!.avatar,
                                        id: vicious!.isAIPlayer ? null : vicious!.id,
                                        playerColor: vicious!.playerColor,
                                        hasLeft: vicious!.hasLeft,
                                      ),
                                      title: Text(
                                        vicious!.numberOfTimesKickerInSession == 1
                                            ? vicious!.numberOfTimesKickerInSession.toString() + DialogueService.kickSingularText.tr
                                            : vicious!.numberOfTimesKickerInSession.toString() + DialogueService.kickPluralText.tr,
                                        style: TextStyles.listSubtitleStyle(
                                          Theme.of(context).colorScheme.onBackground,
                                        ),
                                      ),
                                      trailing: ReputationWidget(
                                        shouldPad: true,
                                        value: vicious!.reputationValue,
                                        color: Get.isDarkMode
                                            ? PlayerConstants.swatchList[vicious!.playerColor].playerSelectedColor
                                            : PlayerConstants.swatchList[vicious!.playerColor].playerColor,
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        if (hasViciousOrPunchingBag)
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                      color: PlayerConstants.swatchList[punchingBag!.playerColor].playerSelectedColor.withOpacity(AppConstants.appOpacity),
                                      borderRadius: AppConstants.appBorderRadius),
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        DialogueService.gamePunchingBagText.tr,
                                        style: TextStyles.listTitleStyle(
                                          Theme.of(context).colorScheme.onBackground,
                                        ),
                                      ),
                                      CustomListTileWidget(
                                        leading: GameOwnerAvatarWidget(
                                          avatar: punchingBag!.avatar,
                                          id: punchingBag!.isAIPlayer ? null : punchingBag!.id,
                                          playerColor: punchingBag!.playerColor,
                                          hasLeft: punchingBag!.hasLeft,
                                        ),
                                        title: Text(
                                          punchingBag!.numberOfTimesKickedInSession == 1
                                              ? DialogueService.kickedText.tr + punchingBag!.numberOfTimesKickedInSession.toString() + DialogueService.timesSingularText.tr
                                              : DialogueService.kickedText.tr + punchingBag!.numberOfTimesKickedInSession.toString() + DialogueService.timesPluralText.tr,
                                          style: TextStyles.listSubtitleStyle(
                                            Theme.of(context).colorScheme.onBackground,
                                          ),
                                        ),
                                        trailing: ReputationWidget(
                                          shouldPad: true,
                                          value: punchingBag!.reputationValue,
                                          color: Get.isDarkMode
                                              ? PlayerConstants.swatchList[punchingBag!.playerColor].playerSelectedColor
                                              : PlayerConstants.swatchList[punchingBag!.playerColor].playerColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                      ],
                    ),
                  )
                ],
              ),
            ),
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
