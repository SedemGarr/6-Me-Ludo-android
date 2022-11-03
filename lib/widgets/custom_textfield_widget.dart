// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:six_me_ludo_android/constants/textstyle_constants.dart';

// class CustomTextFieldWidget extends StatelessWidget {
//   final TextEditingController controller;
//   final String hint;
//   final int? maxLength;

//   const CustomTextFieldWidget({
//     super.key,
//     required this.controller,
//     this.maxLength,
//     required this.hint,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return TextFormField(
//       controller: controller,
//       maxLength: maxLength,
//       decoration: InputDecoration(
//         hintText: hint,
//         filled: false,
//         errorBorder: InputBorder.none,
//         disabledBorder: InputBorder.none,
//         focusedErrorBorder: InputBorder.none,
//         enabledBorder: UnderlineInputBorder(
//           borderSide: BorderSide(
//             color: Theme.of(context).colorScheme.tertiary,
//           ),
//         ),
//         border: UnderlineInputBorder(
//           borderSide: BorderSide(
//             color: Theme.of(context).colorScheme.primaryContainer,
//           ),
//         ),
//         focusedBorder: UnderlineInputBorder(
//           borderSide: BorderSide(
//             color: Get.isDarkMode ? Theme.of(context).colorScheme.primary : Theme.of(context).scaffoldBackgroundColor,
//           ),
//         ),
//         hintStyle: TextStyles.listSubtitleStyle(
//           Get.isDarkMode ? Theme.of(context).colorScheme.tertiary : Theme.of(context).colorScheme.onPrimary.withOpacity(0.5),
//         ),
//         counterStyle: TextStyles.listSubtitleStyle(
//           Get.isDarkMode ? Theme.of(context).colorScheme.primaryContainer : Theme.of(context).colorScheme.onPrimary,
//         ),
//       ),
//       style: TextStyles.listTitleStyle(
//         Get.isDarkMode ? Theme.of(context).colorScheme.onBackground : Theme.of(context).colorScheme.onPrimary,
//       ),
//       cursorColor:  Theme.of(context).primaryColor,
//       keyboardType: TextInputType.text,
//     );
//   }
// }
