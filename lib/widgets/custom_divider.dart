import 'package:flutter/material.dart';

class CustomDividerWidget extends StatelessWidget {
  const CustomDividerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Divider(
      color: Theme.of(context).scaffoldBackgroundColor,
      thickness: 2,
    );
  }
}
