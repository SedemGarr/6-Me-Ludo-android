import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:six_me_ludo_android/providers/app_provider.dart';
import 'package:six_me_ludo_android/providers/user_provider.dart';
import 'package:six_me_ludo_android/screens/edit_profile/widgets/change_pseudonym_textfield.dart';
import 'package:six_me_ludo_android/screens/edit_profile/widgets/save_pseudonym_widget.dart';
import 'package:six_me_ludo_android/services/navigation_service.dart';
import 'package:six_me_ludo_android/services/translations/dialogue_service.dart';

import 'package:six_me_ludo_android/widgets/buttons/back_button_widget.dart';
import 'package:six_me_ludo_android/widgets/appbar/custom_appbar.dart';

import '../../widgets/appbar/app_bar_title_widget.dart';
import '../../widgets/text/banner_widget.dart';

class EditPseudonymScreen extends StatefulWidget {
  const EditPseudonymScreen({super.key});

  @override
  State<EditPseudonymScreen> createState() => _EditPseudonymScreenState();
}

class _EditPseudonymScreenState extends State<EditPseudonymScreen> {
  late UserProvider userProvider;

  @override
  void initState() {
    super.initState();
    userProvider = context.read<UserProvider>();
    userProvider.setPseudonymControllerValue(userProvider.getUserPseudonym(), false);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        AppProvider.dismissKeyboard();
      },
      child: Scaffold(
        appBar: CustomAppBarWidget(
          leading: BackButtonWidget(onPressed: () {
            NavigationService.genericGoBack();
          }),
          title: AppBarTitleWidget(text: DialogueService.changePseudonymText.tr),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            BannerWidget(
              text: DialogueService.changePseudonymBannerText.tr,
            ),
            const ChangePseudonymTextField(),
          ],
        ),
        bottomSheet: const SavePseudonymButton(),
      ),
    );
  }
}
