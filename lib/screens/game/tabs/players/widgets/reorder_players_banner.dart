import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:six_me_ludo_android/constants/textstyle_constants.dart';
import 'package:six_me_ludo_android/services/translations/dialogue_service.dart';

class ReorderPlayersBanner extends StatelessWidget {
  const ReorderPlayersBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        DialogueService.reorderPlayersBannerText.tr,
        textAlign: TextAlign.center,
        style: TextStyles.listTitleStyle(Theme.of(context).colorScheme.onSurface),
      ),
    );
  }
}
