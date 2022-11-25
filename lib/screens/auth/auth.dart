// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:provider/provider.dart';
// import 'package:six_me_ludo_android/providers/app_provider.dart';
// import 'package:six_me_ludo_android/widgets/choice_dialog.dart';
// import 'package:six_me_ludo_android/widgets/custom_appbar.dart';
// import 'package:six_me_ludo_android/widgets/custom_outlined_button.dart';
// import 'package:six_me_ludo_android/widgets/loading_screen.dart';
// import 'package:six_me_ludo_android/widgets/title_widget.dart';

// import '../../constants/icon_constants.dart';
// import '../../services/authentication_service.dart';
// import '../../services/translations/dialogue_service.dart';
// import '../../widgets/app_bar_title_widget.dart';
// import '../../widgets/custom_elevated_button.dart';
// import '../../widgets/legal_text.dart';

// class AuthScreen extends StatefulWidget {
//   const AuthScreen({super.key});

//   @override
//   State<AuthScreen> createState() => _AuthScreenState();
// }

// class _AuthScreenState extends State<AuthScreen> {
//   bool hasLottieLoaded = false;

//   @override
//   Widget build(BuildContext context) {
//     AppProvider appProvider = context.watch<AppProvider>();

//     return appProvider.isLoading
//         ? const LoadingScreen()
//         : Scaffold(
//             appBar: CustomAppBarWidget(
//               title: AppBarTitleWidget(
//                 text: DialogueService.welcomeSubtileText.tr,
//               ),
//               centerTitle: true,
//             ),
//             body: Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.spaceAround,
//                 children: [
//                   const Spacer(),
//                   TitleWidget(width: Get.width * 2 / 4),
//                   // CustomAnimatedCrossFade(
//                   //   firstChild: Lottie.asset(
//                   //     AppConstants.authLottieAssetPath,
//                   //     onLoaded: (p0) {
//                   //       setState(() {
//                   //         hasLottieLoaded = true;
//                   //       });
//                   //     },
//                   //     repeat: true,
//                   //     fit: BoxFit.cover,
//                   //   ),
//                   //   secondChild: const SizedBox(),
//                   //   condition: hasLottieLoaded,
//                   // ),
//                   //   const Spacer(),
//                   //   const Divider(),
//                   //  const Spacer(),
//                   Container(
//                     width: Get.width * 2 / 3,
//                     padding: const EdgeInsets.symmetric(vertical: 24),
//                     child: Column(
//                       children: [
//                         CustomElevatedButton(
//                           iconData: AppIcons.googleIcon,
//                           onPressed: () {
//                             AuthenticationService.signInWithGoogle(context);
//                           },
//                           text: DialogueService.signInGoogleText.tr,
//                         ),
//                         CustomOutlinedButton(
//                           iconData: AppIcons.anonIcon,
//                           color: Theme.of(context).primaryColor,
//                           onPressed: () {
//                             showChoiceDialog(
//                                 titleMessage: DialogueService.anonSignInTitleText.tr,
//                                 contentMessage: DialogueService.anonWarningText.tr,
//                                 yesMessage: DialogueService.anonSignInYesText.tr,
//                                 noMessage: DialogueService.anonSignInNoText.tr,
//                                 onYes: () {
//                                   AuthenticationService.signInAnon(context);
//                                 },
//                                 onNo: () {},
//                                 context: context);
//                           },
//                           text: DialogueService.signInAnonText.tr,
//                         ),
//                       ],
//                     ),
//                   ),
//                   Spacer(),
//                   const LegalText(),
//                 ],
//               ),
//             ),
//           );
//   }
// }
