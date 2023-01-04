import 'package:flutter/material.dart';

import '../../../../../constants/textstyle_constants.dart';

class StatsTrailingWidget extends StatelessWidget {
  final String text;

  const StatsTrailingWidget({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyles.listSubtitleStyle(Theme.of(context).colorScheme.primary),
    );
  }
}
