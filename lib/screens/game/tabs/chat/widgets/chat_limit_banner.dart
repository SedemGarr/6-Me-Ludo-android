import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:six_me_ludo_android/constants/app_constants.dart';
import 'package:six_me_ludo_android/constants/textstyle_constants.dart';
import 'package:six_me_ludo_android/providers/game_provider.dart';
import 'package:six_me_ludo_android/services/translations/dialogue_service.dart';
import 'package:six_me_ludo_android/utils/utils.dart';

class ChatLimitBannerWidget extends StatelessWidget {
  const ChatLimitBannerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    GameProvider gameProvider = context.watch<GameProvider>();

    return Container(
      color: gameProvider.playerColor,
      child: Padding(
        padding: AppConstants.bannerPadding,
        child: Center(
            child: Text(
          DialogueService.chatLimitReachedText.tr,
          style: TextStyles.listTitleStyle(Utils.getContrastingColor(gameProvider.playerColor)),
          textAlign: TextAlign.center,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        )),
      ),
    );
  }
}
