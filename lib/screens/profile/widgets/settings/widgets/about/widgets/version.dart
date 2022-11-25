import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:six_me_ludo_android/constants/app_constants.dart';
import 'package:six_me_ludo_android/utils/utils.dart';

import '../../../../../../../constants/textstyle_constants.dart';
import '../../../../../../../providers/app_provider.dart';
import '../../../../../../../services/translations/dialogue_service.dart';
import '../../../../../../../widgets/custom_card_widget.dart';
import '../../../../../../../widgets/custom_list_tile.dart';
import '../../settings_title_widget.dart';

class VersionSettings extends StatefulWidget {
  const VersionSettings({super.key});

  @override
  State<VersionSettings> createState() => _VersionSettingsState();
}

class _VersionSettingsState extends State<VersionSettings> {
  late int counter;
  late bool canShowToast;

  @override
  void initState() {
    super.initState();
    counter = 0;
    canShowToast = true;
  }

  void handleTaps() {
    counter++;

    if (counter >= 5 && canShowToast) {
      Utils.showToast(DialogueService.specialText.tr);
      canShowToast = !canShowToast;

      Future.delayed(AppConstants.snackBarDuration, () {
        canShowToast = !canShowToast;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    AppProvider appProvider = context.read<AppProvider>();

    return CustomCardWidget(
      child: CustomListTileWidget(
        onTap: handleTaps,
        //   leading: const SettingsIconWidget(iconData: AppIcons.themeIcon),
        title: SettingsTitleWidget(text: DialogueService.versionTitleText.tr),
        //  subtitle: SettingsSubtitleWidget(text: appProvider.getAppVersion()),
        trailing: Padding(
          padding: const EdgeInsets.only(right: 4.0),
          child: Text(
            appProvider.getAppVersion(),
            style: TextStyles.listSubtitleStyle(Theme.of(context).colorScheme.onBackground),
          ),
        ),
      ),
    );
  }
}
