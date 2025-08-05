// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:test_diversition/enum/headings.dart';

textStyle({
  Headings headings = Headings.normal,
  FontType? fontType,
  double? fontSize,
  FontWeight? fontWeight,
  Color? color,
  double? opacityColor,
  TextDecoration? decoration = TextDecoration.none,
  double? letterSpacing,
  bool isFixFontSize = true,
  List<Shadow>? shadows,
  double? height,
}) {
  const fontFamily = 'NotoSansThai';
  switch (headings) {
    case Headings.h1:
      return TextStyle(
        fontFamily: fontFamily,
        fontSize:
            isFixFontSize
                ? fontSize ?? 18
                : checkFontType(fontType, fontSize ?? 18),
        fontWeight: fontWeight ?? FontWeight.w700,
        color: opacityColor == null ? color : color?.withOpacity(opacityColor),
        decoration: decoration,
        letterSpacing: letterSpacing,
        shadows: shadows,
      );
    case Headings.h2:
      return TextStyle(
        fontFamily: fontFamily,
        fontSize:
            isFixFontSize
                ? fontSize ?? 16
                : checkFontType(fontType, fontSize ?? 16),
        fontWeight: fontWeight ?? FontWeight.w700,
        color: opacityColor == null ? color : color?.withOpacity(opacityColor),
        decoration: decoration,
        letterSpacing: letterSpacing,
        shadows: shadows,
      );
    case Headings.h3:
      return TextStyle(
        fontFamily: fontFamily,
        fontSize:
            isFixFontSize
                ? fontSize ?? 16
                : checkFontType(fontType, fontSize ?? 16),
        fontWeight: fontWeight ?? FontWeight.w400,
        color: opacityColor == null ? color : color?.withOpacity(opacityColor),
        decoration: decoration,
        letterSpacing: letterSpacing,
        shadows: shadows,
      );
    case Headings.body:
      return TextStyle(
        fontFamily: fontFamily,
        fontSize:
            isFixFontSize
                ? fontSize ?? 14
                : checkFontType(fontType, fontSize ?? 14),
        fontWeight: fontWeight ?? FontWeight.normal,
        color: opacityColor == null ? color : color?.withOpacity(opacityColor),
        decoration: decoration,
        letterSpacing: letterSpacing,
        shadows: shadows,
      );
    case Headings.tabs:
      return TextStyle(
        fontFamily: fontFamily,
        fontSize:
            isFixFontSize
                ? fontSize ?? 14
                : checkFontType(fontType, fontSize ?? 14),
        fontWeight: fontWeight ?? FontWeight.w700,
        color: opacityColor == null ? color : color?.withOpacity(opacityColor),
        decoration: decoration,
        letterSpacing: letterSpacing,
        height: height,
        shadows: shadows,
      );
    case Headings.normal:
      return TextStyle(
        fontFamily: fontFamily,
        fontWeight: fontWeight ?? FontWeight.w400,
        fontSize:
            isFixFontSize
                ? fontSize ?? 14
                : checkFontType(fontType, fontSize ?? 14),
        color: opacityColor == null ? color : color?.withOpacity(opacityColor),
        decoration: decoration,
        letterSpacing: letterSpacing,
        textBaseline: TextBaseline.alphabetic,
        shadows: shadows,
      );
    case Headings.detail:
      return TextStyle(
        fontFamily: fontFamily,
        fontSize:
            isFixFontSize
                ? fontSize ?? 14
                : checkFontType(fontType, fontSize ?? 14),
        fontWeight: fontWeight ?? FontWeight.w100,
        color: opacityColor == null ? color : color?.withOpacity(opacityColor),
        decoration: decoration,
        letterSpacing: letterSpacing,
        textBaseline: TextBaseline.alphabetic,
        shadows: shadows,
      );
    case Headings.subbody:
      return TextStyle(
        fontFamily: fontFamily,
        fontSize:
            isFixFontSize
                ? fontSize ?? 14
                : checkFontType(fontType, fontSize ?? 14),
        fontWeight: fontWeight ?? FontWeight.normal,
        color: opacityColor == null ? color : color?.withOpacity(opacityColor),
        decoration: decoration,
        letterSpacing: letterSpacing,
        shadows: shadows,
      );
    case Headings.subbodybold:
      return TextStyle(
        fontFamily: fontFamily,
        fontSize:
            isFixFontSize
                ? fontSize ?? 14
                : checkFontType(fontType, fontSize ?? 14),
        fontWeight: fontWeight ?? FontWeight.bold,
        color: opacityColor == null ? color : color?.withOpacity(opacityColor),
        decoration: decoration,
        letterSpacing: letterSpacing,
        shadows: shadows,
      );
  }
}

double checkFontType(FontType? fontType, double? fontSize) {
  fontSize = fontSize ?? 14;
  switch (fontType) {
    case FontType.large:
      fontSize += 2;
      break;
    case FontType.extraLarge:
      fontSize += 4;
      break;
    case FontType.normal:
      fontSize += 0;
      break;
    default:
      fontSize += 0;
  }

  return fontSize;
}
