import 'package:css_colors/css_colors.dart';
import 'package:flutter/material.dart';
import 'package:six_me_ludo_android/constants/icon_constants.dart';
import 'package:six_me_ludo_android/models/swatch.dart';

class PlayerConstants {
  static const String pacifist = 'pacifist';
  static const int pacifistValue = 1;
  static const String averageJoe = 'averageJoe';
  static const int averageJoeValue = 0;
  static const String vicious = 'vicious';
  static const int viciousValue = -1;
  static const String randomPersonality = 'random';

  static const IconData pacifistIcon = AppIcons.pacifistIcon;
  static const IconData averageJoeIcon = AppIcons.averageJoeIcon;
  static const IconData viciousIcon = AppIcons.viciousIcon;
  static const IconData randomIcon = AppIcons.randomIcon;

  static const Color errorColor = CSSColors.black;
  static const Color errorSelectedColor = CSSColors.black;
  static const Color errorPathColor = CSSColors.black;

  static List<Color> colors = [
    CSSColors.aliceBlue,
    CSSColors.antiqueWhite,
    CSSColors.aqua,
    CSSColors.aquamarine,
    CSSColors.azure,
    CSSColors.beige,
    CSSColors.bisque,
    CSSColors.black,
    CSSColors.blanchedAlmond,
    CSSColors.blue,
    CSSColors.blueViolet,
    CSSColors.brown,
    CSSColors.burlyWood,
    CSSColors.cadetBlue,
    CSSColors.chartreuse,
    CSSColors.chocolate,
    CSSColors.coral,
    CSSColors.cornflowerBlue,
    CSSColors.cornsilk,
    CSSColors.crimson,
    CSSColors.cyan,
    CSSColors.darkBlue,
    CSSColors.darkCyan,
    CSSColors.darkGoldenRod,
    CSSColors.darkGray,
    CSSColors.darkGreen,
    CSSColors.darkGrey,
    CSSColors.darkKhaki,
    CSSColors.darkMagenta,
    CSSColors.darkOliveGreen,
    CSSColors.darkOrange,
    CSSColors.darkOrchid,
    CSSColors.darkRed,
    CSSColors.darkSalmon,
    CSSColors.darkSeaGreen,
    CSSColors.darkSlateBlue,
    CSSColors.darkSlateGray,
    CSSColors.darkSlateGrey,
    CSSColors.darkTurquoise,
    CSSColors.darkViolet,
    CSSColors.deepPink,
    CSSColors.deepSkyBlue,
    CSSColors.dimGray,
    CSSColors.dimGrey,
    CSSColors.dodgerBlue,
    CSSColors.fireBrick,
    CSSColors.floralWhite,
    CSSColors.forestGreen,
    CSSColors.fuchsia,
    CSSColors.gainsboro,
    CSSColors.ghostWhite,
    CSSColors.gold,
    CSSColors.goldenRod,
    CSSColors.gray,
    CSSColors.green,
    CSSColors.greenYellow,
    CSSColors.grey,
    CSSColors.honeyDew,
    CSSColors.hotPink,
    CSSColors.indianRed,
    CSSColors.indigo,
    CSSColors.ivory,
    CSSColors.khaki,
    CSSColors.lavender,
    CSSColors.lavenderBlush,
    CSSColors.lawnGreen,
    CSSColors.lemonChiffon,
    CSSColors.lightBlue,
    CSSColors.lightCoral,
    CSSColors.lightCyan,
    CSSColors.lightGoldenRodYellow,
    CSSColors.lightGray,
    CSSColors.lightGreen,
    CSSColors.lightGrey,
    CSSColors.lightPink,
    CSSColors.lightSalmon,
    CSSColors.lightSeaGreen,
    CSSColors.lightSkyBlue,
    CSSColors.lightSlateGray,
    CSSColors.lightSlateGrey,
    CSSColors.lightSteelBlue,
    CSSColors.lightYellow,
    CSSColors.lime,
    CSSColors.limeGreen,
    CSSColors.linen,
    CSSColors.magenta,
    CSSColors.maroon,
    CSSColors.mediumAquaMarine,
    CSSColors.mediumBlue,
    CSSColors.mediumOrchid,
    CSSColors.mediumPurple,
    CSSColors.mediumSeaGreen,
    CSSColors.mediumSlateBlue,
    CSSColors.mediumSpringGreen,
    CSSColors.mediumTurquoise,
    CSSColors.mediumVioletRed,
    CSSColors.midnightBlue,
    CSSColors.mintCream,
    CSSColors.mistyRose,
    CSSColors.moccasin,
    CSSColors.navajoWhite,
    CSSColors.navy,
    CSSColors.oldLace,
    CSSColors.olive,
    CSSColors.oliveDrab,
    CSSColors.orange,
    CSSColors.orangeRed,
    CSSColors.orchid,
    CSSColors.paleGoldenRod,
    CSSColors.paleGreen,
    CSSColors.paleTurquoise,
    CSSColors.paleVioletRed,
    CSSColors.papayaWhip,
    CSSColors.peachPuff,
    CSSColors.peru,
    CSSColors.pink,
    CSSColors.plum,
    CSSColors.powderBlue,
    CSSColors.purple,
    CSSColors.rebeccaPurple,
    CSSColors.red,
    CSSColors.rosyBrown,
    CSSColors.royalBlue,
    CSSColors.saddleBrown,
    CSSColors.salmon,
    CSSColors.sandyBrown,
    CSSColors.seaGreen,
    CSSColors.seaShell,
    CSSColors.sienna,
    CSSColors.silver,
    CSSColors.skyBlue,
    CSSColors.slateBlue,
    CSSColors.slateGray,
    CSSColors.slateGrey,
    CSSColors.snow,
    CSSColors.springGreen,
    CSSColors.steelBlue,
    CSSColors.tan,
    CSSColors.teal,
    CSSColors.thistle,
    CSSColors.tomato,
    CSSColors.turquoise,
    CSSColors.violet,
    CSSColors.wheat,
    CSSColors.white,
    CSSColors.whiteSmoke,
    CSSColors.yellow,
    CSSColors.yellowGreen,
  ];

  static List<Swatch> swatchList = [
    Swatch(playerColor: CSSColors.blue, playerSelectedColor: CSSColors.darkBlue),
    Swatch(playerColor: CSSColors.red, playerSelectedColor: CSSColors.darkRed),
    Swatch(playerColor: CSSColors.yellow, playerSelectedColor: CSSColors.orange),
    Swatch(playerColor: CSSColors.green, playerSelectedColor: CSSColors.darkGreen),
    Swatch(playerColor: CSSColors.orange, playerSelectedColor: CSSColors.orange),
  ];

  static IconData parsePlayerReputationToIcon(int value) {
    if (value.isNegative) {
      return viciousIcon;
    } else if (value == 0) {
      return averageJoeIcon;
    } else {
      return pacifistIcon;
    }
  }
}
