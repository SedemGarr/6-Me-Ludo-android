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
import 'package:six_me_ludo_android/widgets/user_avatar_widget.dart';

class EndGameWidget extends StatefulWidget {
  final GameProvider gameProvider;
  final UserProvider userProvider;

  const EndGameWidget({super.key, required this.gameProvider, required this.userProvider});

  @override
  State<EndGameWidget> createState() => _EndGameWidgetState();
}

class _EndGameWidgetState extends State<EndGameWidget> {
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
    return Column(
      children: [
        Expanded(
          child: hasWinner
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ConfettiWidget(
                      confettiController: gameProvider.confettiController,
                      blastDirectionality: BlastDirectionality.explosive,
                      colors: [Get.isDarkMode ? PlayerConstants.swatchList[winner!.playerColor].playerSelectedColor : PlayerConstants.swatchList[winner!.playerColor].playerColor],
                      child: Text(
                        DialogueService.gameWinnerText.tr,
                        style: TextStyles.listTitleStyle(Theme.of(context).colorScheme.onSurface).copyWith(
                          fontSize: 28,
                        ),
                      ),
                    ),
                    Flexible(
                      child: UserAvatarWidget(
                        backgroundColor:
                            Get.isDarkMode ? PlayerConstants.swatchList[winner!.playerColor].playerSelectedColor : PlayerConstants.swatchList[winner!.playerColor].playerColor,
                        avatar: winner!.avatar,
                        borderColor: Theme.of(context).colorScheme.onSurface,
                        shouldExpand: true,
                        id: winner!.id,
                      ),
                    ),
                  ],
                )
              : Center(
                  child: Text(
                    DialogueService.noWinnerText.tr,
                    style: TextStyles.listTitleStyle(Theme.of(context).colorScheme.onSurface),
                  ),
                ),
        ),
        if (hasViciousOrPunchingBag) const Divider(),
        if (hasViciousOrPunchingBag)
          Expanded(
              flex: hasWinner ? 1 : 2,
              child: IntrinsicHeight(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Flexible(
                      child: Column(
                        children: [
                          Text(
                            '${DialogueService.gameViciousText.tr} - ${vicious!.numberOfTimesKickerInSession}',
                            style: TextStyles.listTitleStyle(Theme.of(context).colorScheme.onSurface).copyWith(
                              fontSize: 18,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8.0),
                            child: UserAvatarWidget(
                              backgroundColor: Get.isDarkMode
                                  ? PlayerConstants.swatchList[vicious!.playerColor].playerSelectedColor
                                  : PlayerConstants.swatchList[vicious!.playerColor].playerColor,
                              avatar: vicious!.avatar,
                              borderColor: Theme.of(context).colorScheme.onSurface,
                              shouldExpand: true,
                              id: vicious!.id,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const VerticalDivider(),
                    Flexible(
                      child: Column(
                        children: [
                          Text(
                            '${DialogueService.gamePunchingBagText.tr} - ${punchingBag!.numberOfTimesKickedInSession}',
                            style: TextStyles.listTitleStyle(Theme.of(context).colorScheme.onSurface).copyWith(
                              fontSize: 18,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8.0),
                            child: UserAvatarWidget(
                              backgroundColor: Get.isDarkMode
                                  ? PlayerConstants.swatchList[punchingBag!.playerColor].playerSelectedColor
                                  : PlayerConstants.swatchList[punchingBag!.playerColor].playerColor,
                              avatar: punchingBag!.avatar,
                              borderColor: Theme.of(context).colorScheme.onSurface,
                              shouldExpand: true,
                              id: punchingBag!.id,
                            ),
                          ),
                          //   Text('45')
                        ],
                      ),
                    ),
                  ],
                ),
              ))
      ],
    );
  }
}
