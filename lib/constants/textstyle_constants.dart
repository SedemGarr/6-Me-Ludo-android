import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TextStyles {
  static TextStyle appTextStyle = GoogleFonts.fuzzyBubbles();
  static TextTheme appTextTheme = GoogleFonts.fuzzyBubblesTextTheme();

  static TextStyle appBarTitleStyle(Color color) {
    return appTextStyle.copyWith(
      fontWeight: FontWeight.bold,
      color: color,
    );
  }

  static TextStyle fabStyle(Color color) {
    return appTextStyle.copyWith(
      fontWeight: FontWeight.bold,
      color: color,
    );
  }

  static TextStyle noGamesStyle(Color color) {
    return appTextStyle.copyWith(
      color: color,
    );
  }

  static TextStyle listTitleStyle(Color color) {
    return appTextStyle.copyWith(
      fontWeight: FontWeight.bold,
      color: color,
    );
  }

  static TextStyle listSubtitleStyle(Color color) {
    return appTextStyle.copyWith(
      color: color,
    );
  }

  static TextStyle chatListSubtitleStyle(Color color, bool isItalic) {
    return appTextStyle.copyWith(
      color: color,
      fontStyle: isItalic ? FontStyle.italic : FontStyle.normal,
    );
  }

  static TextStyle dialogTitleStyle(Color color) {
    return appTextStyle.copyWith(
      color: color,
      fontWeight: FontWeight.bold,
    );
  }

  static TextStyle dialogContentStyle(Color color) {
    return appTextStyle.copyWith(
      color: color,
    );
  }

  static TextStyle dialogContentStyleBold(Color color) {
    return appTextStyle.copyWith(
      color: color,
      fontWeight: FontWeight.bold,
    );
  }

  static TextStyle elevatedButtonStyle(Color color) {
    return appTextStyle.copyWith(
      color: color,
      fontWeight: FontWeight.bold,
    );
  }

  static TextStyle textButtonStyle(Color color) {
    return appTextStyle.copyWith(
      color: color,
      fontWeight: FontWeight.bold,
    );
  }

  static TextStyle settingsHeaderStyle(Color color) {
    return appTextStyle.copyWith(
      color: color,
      fontWeight: FontWeight.bold,
    );
  }

  static TextStyle textFieldStyle(Color color) {
    return appTextStyle.copyWith(
      color: color,
    );
  }

  static TextStyle popupMenuStyle(Color color) {
    return appTextStyle.copyWith(
      color: color,
      fontWeight: FontWeight.bold,
    );
  }

  static TextStyle legalTextStyleNormal(Color color) {
    return appTextStyle.copyWith(
      color: color,
    );
  }

  static TextStyle legalTextStyleBold(Color color) {
    return appTextStyle.copyWith(
      color: color,
    );
  }
}
