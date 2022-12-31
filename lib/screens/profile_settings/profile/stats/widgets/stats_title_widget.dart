import 'package:flutter/material.dart';

import '../../../../../constants/textstyle_constants.dart';

class StatsTitleWidget extends StatelessWidget {
  final String text;

  const StatsTitleWidget({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyles.listTitleStyle(Theme.of(context).colorScheme.onBackground),
    );
  }
}
