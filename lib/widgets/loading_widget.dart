import 'package:flutter/material.dart';

class LoadingWidget extends StatelessWidget {
  final Color? color;

  final double? size;

  const LoadingWidget({
    Key? key,
    this.color,
    this.size,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(color ?? Theme.of(context).primaryColor),
      ),
    );
  }
}
