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
    return Card(
      shape: AppConstants.appShape,
      elevation: 0,
      margin: const EdgeInsets.symmetric(vertical: 4),
      child: Container(
          decoration: BoxDecoration(
            borderRadius: AppConstants.appBorderRadius,
            //color: backgroundColor ?? Theme.of(context).primaryColor.withOpacity(AppConstants.appOpacity),
            color: backgroundColor ?? Theme.of(context).colorScheme.primary.withOpacity(AppConstants.appOpacity),
          ),
          child: child),
    );
  }
}
