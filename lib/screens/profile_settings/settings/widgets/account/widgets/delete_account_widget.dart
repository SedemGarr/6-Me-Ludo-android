import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:six_me_ludo_android/constants/icon_constants.dart';
import 'package:six_me_ludo_android/screens/profile_settings/settings/widgets/settings_icon_widget.dart';

import '../../../../../../providers/user_provider.dart';
import '../../../../../../services/translations/dialogue_service.dart';
import '../../../../../../widgets/general/custom_animated_crossfade.dart';
import '../../../../../../widgets/general/custom_card_widget.dart';
import '../../../../../../widgets/general/custom_list_tile.dart';
import '../../settings_subtitle_widget.dart';
import '../../settings_title_widget.dart';

class DeleteAcountWidget extends StatelessWidget {
  const DeleteAcountWidget({super.key});

  @override
  Widget build(BuildContext context) {
    UserProvider userProvider = context.watch<UserProvider>();

    return CustomAnimatedCrossFade(
        firstChild: const SizedBox.shrink(),
        secondChild: CustomCardWidget(
          child: CustomListTileWidget(
            onTap: () {
              userProvider.showDeleteAccountDialog(context);
            },
            //  leading: const SettingsIconWidget(iconData: AppIcons.deleteAccountIcon),
            title: SettingsTitleWidget(text: DialogueService.deleteAccountTitleText.tr),
            subtitle: SettingsSubtitleWidget(text: DialogueService.deleteAccountSubtitleText.tr),
            trailing: const SettingsIconWidget(iconData: AppIcons.deleteAccountIcon),
          ),
        ),
        condition: userProvider.getUserIsOffline() || userProvider.isUserAnon());
  }
}
