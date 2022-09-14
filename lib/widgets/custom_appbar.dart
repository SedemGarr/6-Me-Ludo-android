import 'package:flutter/material.dart';
import 'package:six_me_ludo_android/constants/app_constants.dart';

class CustomAppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  final Widget? leading;
  final Widget? title;
  final List<Widget>? actions;
  final PreferredSizeWidget? bottom;
  final bool? centerTitle;
  final double? size;
  final Color? backgroundColor;

  const CustomAppBarWidget({
    super.key,
    this.leading,
    this.title,
    this.actions,
    this.bottom,
    this.centerTitle,
    this.size,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      automaticallyImplyLeading: false,
      backgroundColor: backgroundColor,
      centerTitle: centerTitle ?? false,
      leading: leading,
      title: title,
      actions: actions,
      bottom: bottom,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(size ?? AppConstants.standardAppbarHeight);
}
