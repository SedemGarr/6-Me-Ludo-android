import 'package:flutter/material.dart';
import 'package:six_me_ludo_android/constants/icon_constants.dart';

class TitleWidget extends StatelessWidget {
  final double width;
  final Color? color;

  const TitleWidget({Key? key, required this.width, this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: FittedBox(
        fit: BoxFit.fitWidth,
        child: Icon(
          AppIcons.appIcon,
          color: color ?? Theme.of(context).colorScheme.onBackground,
        ),
      ),
    );
  }
}
