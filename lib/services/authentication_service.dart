import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:provider/provider.dart';
import 'package:six_me_ludo_android/services/translations/dialogue_service.dart';
import 'package:six_me_ludo_android/utils/utils.dart';
import '../models/user.dart';

import '../providers/theme_provider.dart';
import '../providers/user_provider.dart';
import 'database_service.dart';
import 'local_storage_service.dart';
import 'package:flutter/material.dart';

import 'navigation_service.dart';

class AuthenticationService {
  static Future<void> signInWithGoogle(BuildContext context) async {
    final GoogleSignIn googleSignIn = GoogleSignIn();
    FirebaseAuth auth = FirebaseAuth.instance;
    UserProvider userProvider = context.read<UserProvider>();
    ThemeProvider themeProvider = context.read<ThemeProvider>();

    try {
      final GoogleSignInAccount? googleSignInAccount = await googleSignIn.signIn();

      if (googleSignInAccount != null) {
        final GoogleSignInAuthentication googleSignInAuthentication = await googleSignInAccount.authentication;

        final AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleSignInAuthentication.accessToken,
          idToken: googleSignInAuthentication.idToken,
        );

        try {
          final UserCredential userCredential = await auth.signInWithCredential(credential);

          Users? user = await DatabaseService.createUser(userCredential.user!);

          if (user != null) {
            userProvider.setUser(user);
            themeProvider.toggleDarkMode(user.settings.prefersDarkMode);
            NavigationService.goToHomeScreen();
            context.loaderOverlay.hide();
          } else {
            Utils.showToast(DialogueService.genericErrorText.tr);
          }
        } catch (e) {
          Utils.showToast(e.toString());
        }
      } else {
        // if user is null
        userProvider.setDoesUserNeedToSignIn(true);
        Utils.showToast(DialogueService.noUserSelectedText.tr);
      }
    } catch (e) {
      Utils.showToast(e.toString());
    }
  }

  static Future<void> signOut(Users user, BuildContext context) async {
    FirebaseAuth firebase = FirebaseAuth.instance;

    try {
      await firebase.signOut();
      LocalStorageService.clearUser();
    } catch (e) {
      Utils.showToast(e.toString());
    }

    NavigationService.goToSplashScreenAfterLogOut();
  }
}
