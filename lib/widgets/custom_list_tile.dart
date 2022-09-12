import 'package:flutter/material.dart';

class CustomListTileWidget extends StatelessWidget {
  final Widget? title;
  final Widget? subtitle;
  final Widget? leading;
  final Widget? trailing;
  final bool? dense;
  final VoidCallback? onTap;
  final EdgeInsets? contentPadding;

  const CustomListTileWidget({super.key, this.title, this.dense, this.subtitle, this.leading, this.trailing, this.onTap, this.contentPadding});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      dense: dense?? true,
      leading: leading,
      title: title,
      subtitle: subtitle,
      trailing: trailing,
      contentPadding: contentPadding,
      onTap: onTap,
    );
  }
}
