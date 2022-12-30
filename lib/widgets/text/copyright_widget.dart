import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:six_me_ludo_android/constants/textstyle_constants.dart';

import '../../services/translations/dialogue_service.dart';

class CopyrightWidget extends StatelessWidget {
  const CopyrightWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          DialogueService.copyrightText.tr + DateTime.now().year.toString() + DialogueService.wayyyoutGamesText.tr,
          style: TextStyles.listSubtitleStyle(Theme.of(context).colorScheme.primary),
        ),
      ),
    );
  }
}
