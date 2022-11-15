import 'package:flutter/material.dart';

import '../constants/app_constants.dart';

class CustomCardWidget extends StatelessWidget {
  final Widget child;

  const CustomCardWidget({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4.0),
      child: Card(
        shape: AppConstants.appShape,
        color: Theme.of(context).colorScheme.primaryContainer.withOpacity(AppConstants.appOpacity),
        elevation: 0,
        child: child,
      ),
    );
  }
}
