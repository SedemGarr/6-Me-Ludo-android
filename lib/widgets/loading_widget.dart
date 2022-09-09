import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class LoadingWidget extends StatelessWidget {
  final Color? color;
  final double? size;

  const LoadingWidget({Key? key, this.color, this.size}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: LoadingAnimationWidget.prograssiveDots(
        color: color ?? Theme.of(context).colorScheme.primary,
        size: size ?? 60,
      ),
    );
  }
}
