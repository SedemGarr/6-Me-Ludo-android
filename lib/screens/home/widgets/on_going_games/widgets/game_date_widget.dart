import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:six_me_ludo_android/constants/textstyle_constants.dart';
import 'package:six_me_ludo_android/services/translations/dialogue_service.dart';
import 'package:six_me_ludo_android/utils/utils.dart';

class GameDateWidget extends StatelessWidget {
  final String lastUpdatedAt;

  const GameDateWidget({super.key, required this.lastUpdatedAt});

  @override
  Widget build(BuildContext context) {
    return Text(
      DialogueService.lastPlayedAtText.tr + Utils.parseDateFromNow(lastUpdatedAt),
      style: TextStyles.listSubtitleStyle(Theme.of(context).colorScheme.onSurface),
    );
  }
}
