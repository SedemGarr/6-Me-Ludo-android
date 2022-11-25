import 'package:flutter/material.dart';

import 'package:six_me_ludo_android/constants/app_constants.dart';

class CustomListTileWidget extends StatelessWidget {
  final Widget? title;
  final Widget? subtitle;
  final Widget? leading;
  final Widget? trailing;

  final bool? dense;

  final VoidCallback? onTap;
  final VoidCallback? onLongPress;

  final double? minLeadingWidth;

  const CustomListTileWidget({
    super.key,
    this.title,
    this.subtitle,
    this.leading,
    this.trailing,
    this.onTap,
    this.onLongPress,
    this.dense,
    this.minLeadingWidth,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      minLeadingWidth: minLeadingWidth,
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 8.0,
        vertical: 0.0,
      ),
      shape: AppConstants.appShape,
      dense: dense ?? false,
      onTap: onTap,
      onLongPress: onLongPress,
      leading: leading,
      title: title,
      subtitle: subtitle,
      trailing: trailing,
    );
  }
}
