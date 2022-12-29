import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';
import 'package:six_me_ludo_android/providers/app_provider.dart';
import 'package:six_me_ludo_android/services/translations/dialogue_service.dart';
import '../models/user.dart';

import '../providers/sound_provider.dart';
import '../providers/theme_provider.dart';
import '../providers/user_provider.dart';
import 'database_service.dart';
import 'local_storage_service.dart';
import 'package:flutter/material.dart';

import 'navigation_service.dart';

class AuthenticationService {
  static Future<void> convertToGoogle(BuildContext context) async {
    final GoogleSignIn googleSignIn = GoogleSignIn();
    FirebaseAuth auth = FirebaseAuth.instance;
    UserProvider userProvider = context.read<UserProvider>();
    ThemeProvider themeProvider = context.read<ThemeProvider>();
    AppProvider appProvider = context.read<AppProvider>();
    SoundProvider soundProvider = context.read<SoundProvider>();

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
          UserCredential? userCredential;

          try {
            if (auth.currentUser == null) {
              await signInWithGoogle(credential);
            } else {
              userCredential = await auth.currentUser?.linkWithCredential(credential);
            }
          } on FirebaseAuthException catch (e) {
            switch (e.code) {
              case "credential-already-in-use":
                await deleteAccount(false);
                await signInWithGoogle(credential);
                return;
              default:
                appProvider.setLoading(false, true);
                AppProvider.showToast(DialogueService.genericErrorText.tr);
                debugPrint(e.toString());
                break;
            }
          }

          if (userCredential != null) {
            Users? user = await DatabaseService.createUser(
              userCredential.user!,
              false,
              appProvider.getAppVersion(),
              appProvider.getAppBuildNumber(),
            );

            if (user != null) {
              appProvider.setLoading(false, false);
              userProvider.setUser(user, appProvider, soundProvider);
              themeProvider.toggleDarkMode(user.settings.prefersDarkMode);
              NavigationService.goToHomeScreen();
            } else {
              appProvider.setLoading(false, true);
              AppProvider.showToast(DialogueService.genericErrorText.tr);
            }
          }
        } catch (e) {
          appProvider.setLoading(false, true);
          AppProvider.showToast(DialogueService.genericErrorText.tr);
          debugPrint(e.toString());
        }
      } else {
        // if user is null
        appProvider.setLoading(false, true);
        AppProvider.showToast(DialogueService.noUserSelectedText.tr);
      }
    } catch (e) {
      appProvider.setLoading(false, true);
      AppProvider.showToast(DialogueService.genericErrorText.tr);
      debugPrint(e.toString());
    }
  }

  static Future<void> signInAnon(BuildContext context) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    UserProvider userProvider = context.read<UserProvider>();
    AppProvider appProvider = context.read<AppProvider>();
    SoundProvider soundProvider = context.read<SoundProvider>();

    appProvider.setLoading(true, true);

    try {
      UserCredential userCredential = await auth.signInAnonymously();

      Users? user = await DatabaseService.createUser(
        userCredential.user!,
        true,
        appProvider.getAppVersion(),
        appProvider.getAppBuildNumber(),
      );

      if (user != null) {
        userProvider.setUser(user, appProvider, soundProvider);
        appProvider.setLoading(false, true);
        NavigationService.goToHomeScreen();
      }
    } catch (e) {
      appProvider.setLoading(false, true);
      AppProvider.showToast(DialogueService.genericErrorText.tr);
      debugPrint(e.toString());
    }
  }

  static Future<void> signInWithGoogle(AuthCredential credential) async {
    BuildContext context = Get.context!;
    FirebaseAuth auth = FirebaseAuth.instance;
    UserProvider userProvider = context.read<UserProvider>();
    ThemeProvider themeProvider = context.read<ThemeProvider>();
    AppProvider appProvider = context.read<AppProvider>();
    SoundProvider soundProvider = context.read<SoundProvider>();

    try {
      final UserCredential userCredential = await auth.signInWithCredential(credential);

      Users? user = await DatabaseService.createUser(
        userCredential.user!,
        false,
        appProvider.getAppVersion(),
        appProvider.getAppBuildNumber(),
      );

      if (user != null) {
        appProvider.setLoading(false, false);
        userProvider.setUser(user, appProvider, soundProvider);
        themeProvider.toggleDarkMode(user.settings.prefersDarkMode);
        NavigationService.goToHomeScreen();
      } else {
        appProvider.setLoading(false, true);
        AppProvider.showToast(DialogueService.genericErrorText.tr);
      }
    } catch (e) {
      appProvider.setLoading(false, true);
      AppProvider.showToast(DialogueService.genericErrorText.tr);
      debugPrint(e.toString());
    }
  }

  static Future<void> signOut(Users user, BuildContext context) async {
    FirebaseAuth firebase = FirebaseAuth.instance;

    try {
      if (!user.isAnon) {
        final GoogleSignIn googleSignIn = GoogleSignIn();
        googleSignIn.signOut();
      }

      await firebase.signOut();
      LocalStorageService.clearUser();
      AppProvider.clearCache();
    } catch (e) {
      AppProvider.showToast(DialogueService.genericErrorText.tr);
      debugPrint(e.toString());
    }

    NavigationService.goToSplashScreenAfterLogOut();
  }

  static Future<void> deleteAccount(bool shouldGoBackToSplash) async {
    BuildContext context = Get.context!;
    UserProvider userProvider = context.read<UserProvider>();
    Users user = userProvider.getUser();
    FirebaseAuth firebase = FirebaseAuth.instance;
    final User? signedInUser = firebase.currentUser;

    if (shouldGoBackToSplash) {
      NavigationService.goToSplashScreenAfterLogOut();
    }

    try {
      if (!user.isAnon) {
        final GoogleSignIn googleSignIn = GoogleSignIn();
        final GoogleSignInAccount? googleSignInAccount = await googleSignIn.signIn();

        if (googleSignInAccount != null) {
          final GoogleSignInAuthentication googleSignInAuthentication = await googleSignInAccount.authentication;

          final AuthCredential credential = GoogleAuthProvider.credential(
            accessToken: googleSignInAuthentication.accessToken,
            idToken: googleSignInAuthentication.idToken,
          );

          await signedInUser!.reauthenticateWithCredential(credential);
          await deleteUser(signedInUser, googleSignIn, firebase, user);
        }
      } else {
        await deleteUser(signedInUser!, null, firebase, user);
      }
    } catch (e) {
      AppProvider.showToast(DialogueService.genericErrorText.tr);
      debugPrint(e.toString());
    }
  }

  static Future<void> deleteUser(User signedInUser, GoogleSignIn? googleSignIn, FirebaseAuth firebase, Users user) async {
    await signedInUser.delete();
    if (googleSignIn != null) {
      await googleSignIn.signOut();
    }
    await firebase.signOut();
    await DatabaseService.deleteUserData(user);
    LocalStorageService.clearUser();
    AppProvider.clearCache();
  }
}
