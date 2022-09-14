import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';


class DiceWidget extends StatefulWidget {
  final bool shouldAnimate;
  final bool isPlayerTurn;
  final int value;
  final int playerNumber;
  final int playerColor;
  final Color? startColour;
  final Color? endColour;
  

  const DiceWidget(
      {Key? key,
      required this.shouldAnimate,
      required this.playerColor,
      required this.isPlayerTurn,
      required this.playerNumber,
      required this.value,
      required this.startColour,
      required this.swatches,
      required this.endColour})
      : super(key: key);

  @override
  _DiceWidgetState createState() => _DiceWidgetState();
}

class _DiceWidgetState extends State<DiceWidget> {
  late int value;

  late Timer timer;

  int animationColorIndex = 0;
  late List<Color> animationColours;

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
    if (widget.isPlayerTurn && !widget.shouldAnimate) {
      animationColours = [widget.startColour!, widget.endColour!];
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
    initializeWidget();
    animateColours();
    super.initState();
  }

  @override
  void dispose() {
    if (widget.shouldAnimate || widget.isPlayerTurn) {
      timer.cancel();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(2.0),
      ),
      child: AnimatedContainer(
        duration: const Duration(seconds: 1),
        decoration: BoxDecoration(
          color: widget.isPlayerTurn && !widget.shouldAnimate ? animationColours[animationColorIndex] : Game.determinePlayerColor(widget.playerColor, widget.swatches),
          borderRadius: BorderRadius.circular(2.0),
        ),
        padding: const EdgeInsets.all(8.0),
        key: widget.key,
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 500),
          transitionBuilder: (child, animation) {
            return RotationTransition(
              turns: animation,
              child: child,
            );
          },
          child: Icon(
            diceValues[value],
            size: MediaQuery.of(context).size.width * 0.07,
            color: Game.determinePlayerColor(widget.playerColor, widget.swatches).computeLuminance() > 0.5
                ? ThemeService.darkTheme.scaffoldBackgroundColor
                : ThemeService.lightTheme.scaffoldBackgroundColor,
            key: ValueKey(value),
          ),
        ),
      ),
    );
  }
}
