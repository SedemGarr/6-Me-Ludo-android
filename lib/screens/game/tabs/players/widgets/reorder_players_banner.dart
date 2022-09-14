import 'package:flutter/material.dart';
import 'package:six_me_ludo_android/constants/textstyle_constants.dart';



class ReorderPlayersBanner extends StatelessWidget {
  const ReorderPlayersBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        'Long press to reorder players',
        textAlign: TextAlign.center,
        style: TextStyles.listTitleStyle(Theme.of(context).colorScheme.onSurface),
      ),
    );
  }
}