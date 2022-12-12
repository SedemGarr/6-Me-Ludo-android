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
import 'package:six_me_ludo_android/services/translations/dialogue_service.dart';
import 'package:six_me_ludo_android/widgets/custom_card_widget.dart';
import 'package:six_me_ludo_android/widgets/custom_list_tile.dart';
import 'package:six_me_ludo_android/widgets/user_avatar_widget.dart';
import 'package:carousel_slider/carousel_slider.dart';

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

  late List<Widget> items;

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
    items = [];
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
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (hasWinner) {
      items.add(
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            ConfettiWidget(
              confettiController: gameProvider.confettiController,
              blastDirectionality: BlastDirectionality.explosive,
              colors: [Get.isDarkMode ? PlayerConstants.swatchList[winner!.playerColor].playerSelectedColor : PlayerConstants.swatchList[winner!.playerColor].playerColor],
              child: Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Text(
                  DialogueService.gameWinnerText.tr,
                  style: TextStyles.dialogTitleStyle(Theme.of(context).colorScheme.onBackground),
                ),
              ),
            ),
            Flexible(
              child: UserAvatarWidget(
                backgroundColor: Get.isDarkMode ? PlayerConstants.swatchList[winner!.playerColor].playerSelectedColor : PlayerConstants.swatchList[winner!.playerColor].playerColor,
                avatar: winner!.avatar,
                borderColor: Theme.of(context).colorScheme.onBackground,
                shouldExpand: true,
                id: winner!.isAIPlayer ? null : winner!.id,
                hasLeftGame: winner!.hasLeft,
              ),
            ),
          ],
        ),
      );
    }

    if (hasViciousOrPunchingBag) {
      items.add(
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Text(
                DialogueService.gameViciousText.tr,
                style: TextStyles.dialogTitleStyle(Theme.of(context).colorScheme.onBackground),
              ),
            ),
            Flexible(
              child: UserAvatarWidget(
                backgroundColor:
                    Get.isDarkMode ? PlayerConstants.swatchList[vicious!.playerColor].playerSelectedColor : PlayerConstants.swatchList[vicious!.playerColor].playerColor,
                avatar: vicious!.avatar,
                borderColor: Theme.of(context).colorScheme.onBackground,
                shouldExpand: true,
                id: vicious!.isAIPlayer ? null : vicious!.id,
                hasLeftGame: vicious!.hasLeft,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                vicious!.numberOfTimesKickerInSession == 1
                    ? vicious!.numberOfTimesKickerInSession.toString() + DialogueService.kickSingularText.tr
                    : vicious!.numberOfTimesKickerInSession.toString() + DialogueService.kickPluralText.tr,
                style: TextStyles.listSubtitleStyle(
                  Theme.of(context).colorScheme.onBackground,
                ),
              ),
            )
          ],
        ),
      );

      items.add(
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Text(
                DialogueService.gamePunchingBagText.tr,
                style: TextStyles.dialogTitleStyle(Theme.of(context).colorScheme.onBackground),
              ),
            ),
            Flexible(
              child: UserAvatarWidget(
                backgroundColor:
                    Get.isDarkMode ? PlayerConstants.swatchList[punchingBag!.playerColor].playerSelectedColor : PlayerConstants.swatchList[punchingBag!.playerColor].playerColor,
                avatar: punchingBag!.avatar,
                borderColor: Theme.of(context).colorScheme.onBackground,
                shouldExpand: true,
                id: punchingBag!.isAIPlayer ? null : punchingBag!.id,
                hasLeftGame: punchingBag!.hasLeft,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                punchingBag!.numberOfTimesKickedInSession == 1
                    ? DialogueService.kickedText.tr + punchingBag!.numberOfTimesKickedInSession.toString() + DialogueService.timesSingularText.tr
                    : DialogueService.kickedText.tr + punchingBag!.numberOfTimesKickedInSession.toString() + DialogueService.timesPluralText.tr,
                style: TextStyles.listSubtitleStyle(
                  Theme.of(context).colorScheme.onBackground,
                ),
              ),
            )
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        children: [
          SizedBox(
            height: Get.height * 0.5 - (AppConstants.customAppbarWithTabbarHeight),
            child: items.isNotEmpty
                ? Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CarouselSlider(
                      items: items,
                      options: CarouselOptions(
                        initialPage: 0,
                        aspectRatio: 1,
                        height: Get.height * 0.5 - (AppConstants.customAppbarWithTabbarHeight),
                        viewportFraction: 0.7,
                        enableInfiniteScroll: true,
                        reverse: false,
                        autoPlay: true,
                        enlargeCenterPage: true,
                        autoPlayInterval: AppConstants.carouselDuration,
                        autoPlayAnimationDuration: AppConstants.animationDuration,
                        autoPlayCurve: AppConstants.animationCurve,
                        scrollDirection: Axis.horizontal,
                      ),
                    ),
                  )
                : Center(
                    child: Text(
                      DialogueService.noWinnerText.tr,
                      style: TextStyles.listTitleStyle(Theme.of(context).colorScheme.onBackground),
                    ),
                  ),
          ),
          const Divider(),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: ListView(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 8, left: 8.0, bottom: 8.0),
                    child: Text(
                      DialogueService.statsTitleText.tr,
                      style: TextStyles.settingsHeaderStyle(gameProvider.playerSelectedColor),
                    ),
                  ),
                  CustomCardWidget(
                    child: CustomListTileWidget(
                      title: Text(
                        DialogueService.gameSessionLengthText.tr,
                        style: TextStyles.listTitleStyle(Theme.of(context).colorScheme.onBackground),
                      ),
                      trailing: Text(
                        GameProvider.getGameSessionDuration(game.sessionStartedAt, game.sessionEndedAt),
                        style: TextStyles.listSubtitleStyle(Theme.of(context).colorScheme.onBackground),
                      ),
                    ),
                  ),
                  CustomCardWidget(
                    child: CustomListTileWidget(
                      title: Text(
                        DialogueService.gameSessionNumberOfTurnsText.tr,
                        style: TextStyles.listTitleStyle(Theme.of(context).colorScheme.onBackground),
                      ),
                      trailing: Text(
                        gameProvider.getGameTurnSum(game.players),
                        style: TextStyles.listSubtitleStyle(Theme.of(context).colorScheme.onBackground),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
