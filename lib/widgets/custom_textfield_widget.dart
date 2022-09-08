import 'package:flutter/material.dart';
import 'package:six_me_ludo_android/constants/textstyle_constants.dart';

class CustomTextFieldWidget extends StatelessWidget {
  final TextEditingController controller;
  final String hint;
  final int? maxLength;

  const CustomTextFieldWidget({super.key, required this.controller, this.maxLength, required this.hint});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      maxLength: maxLength,
      decoration: InputDecoration(
        hintText: hint,
        filled: false,
        hintStyle: TextStyles.textFieldStyle(Theme.of(context).colorScheme.onSurface),
        counterStyle: TextStyles.textFieldStyle(Theme.of(context).colorScheme.onSurface),
      ),
      style: TextStyles.textFieldStyle(Theme.of(context).colorScheme.onSurface),
      cursorColor: Theme.of(context).primaryColor,
      keyboardType: TextInputType.text,
    );
  }
}
