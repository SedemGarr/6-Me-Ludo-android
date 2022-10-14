import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:six_me_ludo_android/constants/textstyle_constants.dart';

class CustomTextFieldWidget extends StatelessWidget {
  final TextEditingController controller;
  final String hint;
  final int? maxLength;

  const CustomTextFieldWidget({
    super.key,
    required this.controller,
    this.maxLength,
    required this.hint,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      maxLength: maxLength,
      decoration: InputDecoration(
        hintText: hint,
        filled: false,
        errorBorder: InputBorder.none,
        disabledBorder: InputBorder.none,
        focusedErrorBorder: InputBorder.none,
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: Get.isDarkMode ? Theme.of(context).colorScheme.onSurface : Theme.of(context).colorScheme.onPrimary,
          ),
        ),
        border: UnderlineInputBorder(
          borderSide: BorderSide(
            color: Get.isDarkMode ? Theme.of(context).colorScheme.onSurface : Theme.of(context).colorScheme.onPrimary,
          ),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: Get.isDarkMode ? Theme.of(context).colorScheme.onSurface : Theme.of(context).colorScheme.onPrimary,
          ),
        ),
        hintStyle: TextStyles.textFieldStyle(Theme.of(context).primaryColor),
        counterStyle: TextStyles.textFieldStyle(
          Get.isDarkMode ? Theme.of(context).colorScheme.onSurface : Theme.of(context).colorScheme.onPrimary,
        ),
      ),
      style: TextStyles.textFieldStyle(
        Get.isDarkMode ? Theme.of(context).colorScheme.onSurface : Theme.of(context).colorScheme.onPrimary,
      ),
      cursorColor: Get.isDarkMode ? Theme.of(context).primaryColor : Theme.of(context).colorScheme.onPrimary,
      keyboardType: TextInputType.text,
    );
  }
}
