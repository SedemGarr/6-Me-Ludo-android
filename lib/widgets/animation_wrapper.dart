import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

class CustomAnimationWidget extends StatelessWidget {
  final Widget child;

  const CustomAnimationWidget({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SlideAnimation(
      verticalOffset: 50.0,
      child: FadeInAnimation(child: child),
    );
  }
}
