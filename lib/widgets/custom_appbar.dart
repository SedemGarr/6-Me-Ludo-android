import 'package:flutter/material.dart';
import 'package:six_me_ludo_android/constants/app_constants.dart';

class CustomAppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  final Widget? leading;
  final Widget? title;
  final List<Widget>? actions;
  final PreferredSizeWidget? bottom;
  final double? size;
  final Color? backgroundColor;

  const CustomAppBarWidget({
    super.key,
    this.leading,
    this.title,
    this.actions,
    this.bottom,
    this.size,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: backgroundColor,
      leading: leading,
      title: title,
      actions: actions,
      bottom: bottom,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(size ?? AppConstants.standardAppbarHeight);
}
