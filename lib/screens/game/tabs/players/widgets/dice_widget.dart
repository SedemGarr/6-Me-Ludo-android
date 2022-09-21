import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:six_me_ludo_android/constants/app_constants.dart';
import 'package:six_me_ludo_android/constants/player_constants.dart';
import 'package:six_me_ludo_android/providers/game_provider.dart';
import 'package:six_me_ludo_android/utils/utils.dart';

import '../../../../../constants/icon_constants.dart';

class DiceWidget extends StatefulWidget {
  final bool shouldAnimate;
  final int value;
  final int playerNumber;
  final GameProvider gameProvider;

  const DiceWidget({
    Key? key,
    required this.shouldAnimate,
    required this.playerNumber,
    required this.value,
    required this.gameProvider,
  }) : super(key: key);

  @override
  DiceWidgetState createState() => DiceWidgetState();
}

class DiceWidgetState extends State<DiceWidget> {
  late int value;
  late Timer timer;
  late List<Color> animationColours;
  late bool isPlayerTurn;
  late Color startColor;
  late Color endColor;

  int animationColorIndex = 0;

  Random random = Random();

  List<IconData> diceValues = [
    AppIcons.staticDieIcon,
    AppIcons.oneDieIcon,
    AppIcons.twoDieIcon,
    AppIcons.threeDieIcon,
    AppIcons.fourDieIcon,
    AppIcons.fiveDieIcon,
    AppIcons.sixDieIcon
  ];

  void initializeWidget() {
    value = widget.value;
    if (widget.shouldAnimate) {
      timer = Timer.periodic(const Duration(milliseconds: 250), (Timer t) {
        setState(() {
          value = (random.nextInt(6) + 1);
        });
      });
    } else {
      value = widget.value;
    }
  }

  void animateColours() {
    if (isPlayerTurn && !widget.shouldAnimate) {
      animationColours = [startColor, endColor];
      timer = Timer.periodic(const Duration(seconds: 1), (Timer t) {
        if (animationColorIndex + 1 < animationColours.length) {
          setState(() {
            animationColorIndex++;
          });
        } else {
          setState(() {
            animationColorIndex = 0;
          });
        }
      });
    }
  }

  @override
  void initState() {
    isPlayerTurn = widget.shouldAnimate
        ? widget.gameProvider.currentGame!.playerTurn == widget.playerNumber
        : widget.gameProvider.currentGame!.playerTurn == widget.playerNumber && !widget.gameProvider.currentGame!.hasSessionEnded;
    startColor = PlayerConstants.swatchList[widget.playerNumber].playerColor;
    endColor = PlayerConstants.swatchList[widget.playerNumber].playerSelectedColor;
    initializeWidget();
    animateColours();
    super.initState();
  }

  @override
  void dispose() {
    if (widget.shouldAnimate || isPlayerTurn) {
      timer.cancel();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: FittedBox(
        fit: BoxFit.fitWidth,
        child: Card(
          shape: AppConstants.appShape,
          margin: EdgeInsets.zero,
          child: AnimatedContainer(
            duration: AppConstants.animationDuration,
            decoration: BoxDecoration(
              color: isPlayerTurn && !widget.shouldAnimate ? animationColours[animationColorIndex] : startColor,
              borderRadius: AppConstants.appBorderRadius,
            ),
            key: widget.key,
            child: AnimatedSwitcher(
              duration: AppConstants.animationDuration,
              transitionBuilder: (child, animation) {
                return RotationTransition(
                  turns: animation,
                  child: child,
                );
              },
              child: Icon(
                diceValues[value],
                // size: MediaQuery.of(context).size.width * 0.07,
                color: Utils.getContrastingColor(startColor),
                key: ValueKey(value),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
