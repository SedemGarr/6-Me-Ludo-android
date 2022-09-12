import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';
import 'package:six_me_ludo_android/providers/app_provider.dart';
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
    AppProvider appProvider = context.read<AppProvider>();

    appProvider.setLoading(true, true);

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

          Users? user = await DatabaseService.createUser(userCredential.user!, false);

          if (user != null) {
            appProvider.setLoading(false, false);
            userProvider.setUser(user);
            themeProvider.toggleDarkMode(user.settings.prefersDarkMode);
            NavigationService.goToHomeScreen();
          } else {
            appProvider.setLoading(false, true);
            Utils.showToast(DialogueService.genericErrorText.tr);
          }
        } catch (e) {
          appProvider.setLoading(false, true);
          Utils.showToast(DialogueService.genericErrorText.tr);
          debugPrint(e.toString());
        }
      } else {
        // if user is null
        appProvider.setLoading(false, true);
        Utils.showToast(DialogueService.noUserSelectedText.tr);
      }
    } catch (e) {
      appProvider.setLoading(false, true);
      Utils.showToast(DialogueService.genericErrorText.tr);
      debugPrint(e.toString());
    }
  }

  static Future<void> signInAnon(BuildContext context) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    UserProvider userProvider = context.read<UserProvider>();
    AppProvider appProvider = context.read<AppProvider>();

    appProvider.setLoading(true, true);

    try {
      UserCredential userCredential = await auth.signInAnonymously();

      Users? user = await DatabaseService.createUser(userCredential.user!, true);

      if (user != null) {
        appProvider.setLoading(false, true);
        userProvider.setUser(user);
        NavigationService.goToHomeScreen();
      }
    } catch (e) {
      appProvider.setLoading(false, true);
      Utils.showToast(DialogueService.genericErrorText.tr);
      debugPrint(e.toString());
    }
  }

  static Future<void> signOut(Users user, BuildContext context) async {
    FirebaseAuth firebase = FirebaseAuth.instance;

    try {
      await firebase.signOut();
      LocalStorageService.clearUser();
      Utils.clearCache();
    } catch (e) {
      Utils.showToast(DialogueService.genericErrorText.tr);
      debugPrint(e.toString());
    }

    NavigationService.goToAuthScreenAfterLogOut();
  }

  static Future<void> deleteAccount(Users user, BuildContext context) async {
    FirebaseAuth firebase = FirebaseAuth.instance;
    final signedInUser = firebase.currentUser;

    try {
      await DatabaseService.deleteUserData(user);
      await signedInUser!.delete();
      LocalStorageService.clearUser();
      Utils.clearCache();
    } catch (e) {
      Utils.showToast(DialogueService.genericErrorText.tr);
      debugPrint(e.toString());
    }

    NavigationService.goToAuthScreenAfterLogOut();
  }
}
