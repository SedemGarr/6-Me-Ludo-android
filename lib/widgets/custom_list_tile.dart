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
  final EdgeInsets? contentPadding;

  const CustomListTileWidget({
    super.key,
    this.title,
    this.dense,
    this.subtitle,
    this.leading,
    this.trailing,
    this.onTap,
    this.onLongPress,
    this.contentPadding,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      dense: dense ?? true,
      leading: leading,
      title: title,
      subtitle: subtitle,
      trailing: trailing,
      contentPadding: contentPadding,
      shape: AppConstants.appShape,
      onTap: onTap,
      onLongPress: onLongPress,
    );
  }
}
