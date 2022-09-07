import 'package:flutter/material.dart';

import '../constants/constants.dart';

class CustomElevatedButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;

  const CustomElevatedButton({
    Key? key,
    required this.onPressed,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        overlayColor: MaterialStateProperty.all(Theme.of(context).primaryColorDark),
        backgroundColor: MaterialStateProperty.all(Theme.of(context).primaryColor),
        shape: MaterialStateProperty.all(
          AppConstants.appShape,
        ),
        elevation: MaterialStateProperty.all(0),
      ),
      onPressed: onPressed,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Text(
          text,
          style: TextStyles.elevatedButtonStyle(Theme.of(context).colorScheme.onPrimary),
        ),
      ),
    );
  }
}
