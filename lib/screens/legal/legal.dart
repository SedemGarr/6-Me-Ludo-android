import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:six_me_ludo_android/screens/legal/widgets/licence_list.dart';

import 'package:six_me_ludo_android/widgets/buttons/back_button_widget.dart';

import '../../services/navigation_service.dart';
import '../../services/translations/dialogue_service.dart';
import '../../widgets/appbar/app_bar_title_widget.dart';
import '../../widgets/appbar/custom_appbar.dart';

class LegalScreen extends StatelessWidget {
  const LegalScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBarWidget(
        leading: const BackButtonWidget(onPressed: NavigationService.genericGoBack),
        title: AppBarTitleWidget(
          text: DialogueService.licenceText.tr,
        ),
      ),
      body: const LicenseWidget(),
    );
  }
}
