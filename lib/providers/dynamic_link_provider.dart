import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:six_me_ludo_android/constants/app_constants.dart';
import 'package:six_me_ludo_android/providers/app_provider.dart';
import 'package:six_me_ludo_android/providers/game_provider.dart';
import 'package:six_me_ludo_android/providers/user_provider.dart';

class DynamicLinkProvider with ChangeNotifier {
  FirebaseDynamicLinks firebase = FirebaseDynamicLinks.instance;

  Future<String> createDynamicLink(String id) async {
    final dynamicLinkParams = DynamicLinkParameters(
      link: Uri.parse('https://www.wayyyoutgames.com/game?id=$id'),
      uriPrefix: AppConstants.appLinkPrefix,
      androidParameters: const AndroidParameters(packageName: AppConstants.appPackageName),
    );

    final Uri dynamicLink = await firebase.buildLink(dynamicLinkParams);

    return dynamicLink.toString();
  }

  Future<void> handleDynamicLinks() async {
    // on startup
    final PendingDynamicLinkData? data = await firebase.getInitialLink();
    await _handleDeepLinkData(data);

    // from background
    firebase.onLink.listen((PendingDynamicLinkData event) async {
      await _handleDeepLinkData(event);
    }).onError((error) {
      debugPrint(error.toString());
    });
  }

  Future<void> _handleDeepLinkData(PendingDynamicLinkData? data) async {
    if (data != null) {
      String? id = data.link.queryParameters['id'];

      if (id != null) {
        GameProvider gameProvider = Get.context!.read<GameProvider>();
        AppProvider appProvider = Get.context!.read<AppProvider>();
        UserProvider userProvider = Get.context!.read<UserProvider>();

        gameProvider.setJoinGameController(id, false);

        await gameProvider.joinGameWithCode(userProvider.getUser(), appProvider);
      }
    }
  }
}
