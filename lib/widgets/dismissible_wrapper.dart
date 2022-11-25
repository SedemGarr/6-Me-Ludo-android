import 'package:flutter/material.dart';
import 'package:six_me_ludo_android/services/navigation_service.dart';

class CustomDismissableWrapper extends StatelessWidget {
  final Widget child;

  const CustomDismissableWrapper({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () => NavigationService.genericGoBack(),
      child: GestureDetector(
        onTap: () {},
        child: child,
      ),
    );
  }
}
