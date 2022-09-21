import 'package:flutter/material.dart';

import '../constants/app_constants.dart';

class CustomAnimatedCrossFade extends StatelessWidget {
  final Widget firstChild;
  final Widget secondChild;
  final bool condition;

  const CustomAnimatedCrossFade({super.key, required this.firstChild, required this.secondChild, required this.condition});

  @override
  Widget build(BuildContext context) {
    return AnimatedCrossFade(
      firstChild: firstChild,
      secondChild: secondChild,
      crossFadeState: condition ? CrossFadeState.showFirst : CrossFadeState.showSecond,
      firstCurve: AppConstants.animationCurve,
      secondCurve: AppConstants.animationCurve,
      sizeCurve: AppConstants.animationCurve,
      duration: AppConstants.animationDuration,
    );
  }
}
