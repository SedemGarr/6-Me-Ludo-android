import 'package:flutter/material.dart';

class CustomSliverAppbarWidget extends StatelessWidget {
  final Widget? leading;
  final Widget? title;
  final List<Widget>? actions;
  final PreferredSizeWidget? bottom;
  final bool? centerTitle;
  final double? size;
  final Color? backgroundColor;

  const CustomSliverAppbarWidget({
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
    return SliverAppBar(
      automaticallyImplyLeading: false,
      centerTitle: centerTitle ?? false,
      floating: true,
      snap: true,
      backgroundColor: backgroundColor,
      leading: leading,
      title: title,
      actions: actions,
      bottom: bottom,
    );
  }
}
