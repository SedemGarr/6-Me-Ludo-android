import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';
import 'package:six_me_ludo_android/providers/app_provider.dart';
import 'package:six_me_ludo_android/services/translations/dialogue_service.dart';
import 'package:six_me_ludo_android/utils/utils.dart';
import '../models/user.dart';

import '../providers/sound_provider.dart';
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
        appProvider.setLoading(false, true);
        userProvider.setUser(user, appProvider, soundProvider);
        NavigationService.goToHomeScreen();
      }
    } catch (e) {
      appProvider.setLoading(false, true);
      Utils.showToast(DialogueService.genericErrorText.tr);
      debugPrint(e.toString());
    }
  }

  // Future<void> convertAnonToGoogle(AppVersion appVersion) async {
  //   // Google Sign-in
  //   final GoogleSignIn googleSignIn = GoogleSignIn();

  //   final GoogleSignInAccount? googleSignInAccount = await googleSignIn.signIn();

  //   if (googleSignInAccount != null) {
  //     final GoogleSignInAuthentication googleSignInAuthentication = await googleSignInAccount.authentication;

  //     final AuthCredential credential = GoogleAuthProvider.credential(
  //       accessToken: googleSignInAuthentication.accessToken,
  //       idToken: googleSignInAuthentication.idToken,
  //     );

  //     try {
  //       final userCredential = await FirebaseAuth.instance.currentUser?.linkWithCredential(credential);

  //       if (userCredential != null) {
  //         await DatabaseService.createUser(userCredential.user!, false, appVersion.version);
  //       }
  //     } on FirebaseAuthException catch (e) {
  //       switch (e.code) {
  //         case "provider-already-linked":
  //           print("The provider has already been linked to the user.");
  //           break;
  //         case "invalid-credential":
  //           print("The provider's credential is not valid.");
  //           break;
  //         case "credential-already-in-use":
  //           print("The account corresponding to the credential already exists, "
  //               "or is already linked to a Firebase User.");
  //           break;
  //         // See the API reference for the full list of error codes.
  //         default:
  //           print("Unknown error.");
  //       }
  //     }
  //   }
  // }

  static Future<void> signOut(Users user, BuildContext context) async {
    FirebaseAuth firebase = FirebaseAuth.instance;

    try {
      if (!user.isAnon) {
        final GoogleSignIn googleSignIn = GoogleSignIn();
        googleSignIn.signOut();
      }

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

    NavigationService.goToAuthScreenAfterLogOut();

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
          await googleSignIn.signOut();
          await firebase.signOut();
          await DatabaseService.deleteUserData(user);
          LocalStorageService.clearUser();
          Utils.clearCache();
        }
      } else {
        await firebase.signOut();
        await DatabaseService.deleteUserData(user);
        LocalStorageService.clearUser();
        Utils.clearCache();
      }
    } catch (e) {
      Utils.showToast(DialogueService.genericErrorText.tr);
      debugPrint(e.toString());
    }
  }
}
