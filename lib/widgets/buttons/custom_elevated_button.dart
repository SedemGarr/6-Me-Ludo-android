import 'package:flutter/material.dart';

import '../../constants/app_constants.dart';
import '../../constants/textstyle_constants.dart';

class CustomElevatedButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;
  final IconData? iconData;
  final VisualDensity? visualDensity;

  const CustomElevatedButton({
    Key? key,
    required this.onPressed,
    required this.text,
    this.iconData,
    this.visualDensity,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color color = Theme.of(context).colorScheme.primary;
    Color textColor = Theme.of(context).colorScheme.onPrimary;
    Color overlayColor = Theme.of(context).primaryColorDark;

    return iconData != null
        ? ElevatedButton.icon(
            icon: Icon(
              iconData,
              color: textColor,
            ),
            style: ButtonStyle(
              overlayColor: MaterialStateProperty.all(overlayColor),
              backgroundColor: MaterialStateProperty.all(color),
              shape: MaterialStateProperty.all(
                AppConstants.appShape,
              ),
              elevation: MaterialStateProperty.all(0),
              visualDensity: visualDensity,
            ),
            onPressed: onPressed,
            label: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(
                text,
                style: TextStyles.elevatedButtonStyle(textColor),
              ),
            ),
          )
        : ElevatedButton(
            style: ButtonStyle(
              overlayColor: MaterialStateProperty.all(overlayColor),
              backgroundColor: MaterialStateProperty.all(color),
              shape: MaterialStateProperty.all(
                AppConstants.appShape,
              ),
              elevation: MaterialStateProperty.all(0),
              visualDensity: visualDensity,
            ),
            onPressed: onPressed,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(
                text,
                style: TextStyles.elevatedButtonStyle(textColor),
              ),
            ),
          );
  }
}
