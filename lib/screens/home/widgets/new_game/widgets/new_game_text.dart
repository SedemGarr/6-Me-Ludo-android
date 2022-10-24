import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../constants/textstyle_constants.dart';
import '../../../../../services/translations/dialogue_service.dart';

class CreateNewGameTextWidget extends StatelessWidget {
  const CreateNewGameTextWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16),
      child: Text(
        DialogueService.createNewGameText.tr,
        style: TextStyles.listTitleStyle(Theme.of(context).colorScheme.onSurface),
      ),
    );
  }
}
