import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../constants/textstyle_constants.dart';
import '../../../../services/translations/dialogue_service.dart';

class NoLocalGamesWidget extends StatelessWidget {
  const NoLocalGamesWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        DialogueService.noLocalGamesText.tr,
        style: TextStyles.noGamesStyle(
          Theme.of(context).colorScheme.primary,
        ),
      ),
    );
  }
}
