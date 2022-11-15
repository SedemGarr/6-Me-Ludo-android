import 'package:flutter/material.dart';

class Cell {
  late int index;
  late IconData? icon;
  late Border? border;
  late BorderRadius? borderRadius;
  late Color cellColor;
  late Color? iconColor;

  Cell({
    required this.index,
    required this.icon,
    required this.border,
    required this.borderRadius,
    required this.cellColor,
    required this.iconColor,
  });
}
