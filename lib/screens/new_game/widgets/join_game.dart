import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:six_me_ludo_android/services/translations/dialogue_service.dart';
import 'package:six_me_ludo_android/widgets/join_game_textfield_widget.dart';

import '../../../widgets/banner_widget.dart';

class JoinOngoingGameView extends StatefulWidget {
  const JoinOngoingGameView({super.key});

  @override
  State<JoinOngoingGameView> createState() => _JoinOngoingGameViewState();
}

class _JoinOngoingGameViewState extends State<JoinOngoingGameView> with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Column(
      children: [
        BannerWidget(text: DialogueService.joinGameBannerText.tr),
        const JoinGameTextFieldWidget(),
      ],
    );
  }

  @override
  bool get wantKeepAlive => true;
}
