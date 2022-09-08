import 'package:flutter/material.dart';

import '../constants/constants.dart';

class Player {

static const String pacifist = 'pacifist';
  static const int pacifistValue = -1;
  static const String averageJoe = 'averageJoe';
  static const int averageJoeValue = 0;
  static const String vicious = 'vicious';
  static const int viciousValue = 1;
  static const String randomPersonality = 'random';
  static const List<String> listOfRepuations = [pacifist, averageJoe, vicious];

  static const IconData pacifistIcon = AppIcons.pacifistIcon;
  static const IconData averageJoeIcon = AppIcons.averageJoeIcon;
  static const IconData viciousIcon = AppIcons.viciousIcon;
  static const IconData randomIcon = AppIcons.randomIcon;

  static const List<Color> playerColors = [];

}