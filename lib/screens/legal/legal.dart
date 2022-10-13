import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:six_me_ludo_android/screens/legal/widgets/licence_list.dart';
import 'package:six_me_ludo_android/widgets/back_button_widget.dart';

import '../../constants/textstyle_constants.dart';
import '../../services/navigation_service.dart';
import '../../services/translations/dialogue_service.dart';
import '../../widgets/custom_appbar.dart';

class LegalScreen extends StatelessWidget {
  const LegalScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBarWidget(
        centerTitle: true,
        leading: const BackButtonWidget(onPressed: NavigationService.genericGoBack),
        title: Text(
          DialogueService.licenceText.tr,
          style: TextStyles.appBarTitleStyle(
            Get.isDarkMode ? Theme.of(context).colorScheme.onSurface : Theme.of(context).colorScheme.onPrimary,
          ),
        ),
      ),
      body: const LicenseWidget(),
    );
  }
}
