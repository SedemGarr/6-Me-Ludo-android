import 'package:flutter/material.dart';

import '../../constants/app_constants.dart';

class CustomCardWidget extends StatelessWidget {
  final Widget child;
  final Color? backgroundColor;

  const CustomCardWidget({
    super.key,
    required this.child,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 4.0,
        right: 4.0,
        bottom: 8.0,
      ),
      child: Card(
        shape: AppConstants.appShape,
        elevation: 0,
        margin: EdgeInsets.zero,
        child: Container(
            decoration: BoxDecoration(
              borderRadius: AppConstants.appBorderRadius,
              color: backgroundColor ?? Theme.of(context).primaryColor.withOpacity(AppConstants.appOpacity),
            ),
            child: child),
      ),
    );
  }
}
