import 'package:flutter/material.dart';

import '../constants/constants.dart';

class CustomElevatedButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;
  final IconData? iconData;

  const CustomElevatedButton({
    Key? key,
    required this.onPressed,
    required this.text,
    this.iconData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return iconData != null
        ? ElevatedButton.icon(
            icon: Icon(
              iconData,
              color: Theme.of(context).colorScheme.onPrimary,
            ),
            style: ButtonStyle(
              overlayColor: MaterialStateProperty.all(Theme.of(context).primaryColorDark),
              backgroundColor: MaterialStateProperty.all(Theme.of(context).primaryColor),
              shape: MaterialStateProperty.all(
                AppConstants.appShape,
              ),
              elevation: MaterialStateProperty.all(0),
            ),
            onPressed: onPressed,
            label: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(
                text,
                style: TextStyles.elevatedButtonStyle(Theme.of(context).colorScheme.onPrimary),
              ),
            ),
          )
        : ElevatedButton(
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
