import 'package:flutter/material.dart';

import 'package:six_me_ludo_android/constants/app_constants.dart';

class CustomListTileWidget extends StatelessWidget {
  final Widget? title;
  final Widget? subtitle;
  final Widget? leading;
  final Widget? trailing;

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
    this.minLeadingWidth,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      minLeadingWidth: minLeadingWidth,
      contentPadding: const EdgeInsets.only(left: 16, right: 8.0),
      shape: AppConstants.appShape,
      onTap: onTap,
      onLongPress: onLongPress,
      leading: leading,
      title: title,
      subtitle: subtitle,
      trailing: trailing,
    );
  }
}
