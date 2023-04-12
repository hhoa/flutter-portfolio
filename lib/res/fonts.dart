import 'package:flutter/material.dart';
import 'colors.dart';

class MyAssetFonts {
  MyAssetFonts._();

  static double oneRem = 18;
  static String fontFamily = "ArbutusSlab";

  static TextStyle appBarTextSelected = TextStyle(
    color: MyAssetColor.appColor,
    fontWeight: FontWeight.normal,
    fontFamily: fontFamily,
    fontSize: oneRem
  );

  static TextStyle appBarTextUnselected = TextStyle(
      color: Colors.black,
      fontWeight: FontWeight.normal,
      fontFamily: fontFamily,
      fontSize: oneRem
  );

  static TextStyle specialAppBarText = TextStyle(
      color: MyAssetColor.appColor,
      fontWeight: FontWeight.w500,
      fontFamily: fontFamily,
      fontSize: 1.4 * oneRem
  );

  static TextStyle bigBoldName = TextStyle(
    fontWeight: FontWeight.w500,
    fontSize: 3 * oneRem,
    fontFamily: fontFamily,
    color: Colors.black,
  );

  static TextStyle bigBoldTitle = TextStyle(
    fontWeight: FontWeight.w500,
    fontSize: 2 * oneRem,
    fontFamily: fontFamily,
    color: Colors.black,
  );

  static TextStyle descriptionName = TextStyle(
    fontWeight: FontWeight.w300,
    fontSize: 1.3 * oneRem,
    fontFamily: fontFamily,
    color: MyAssetColor.descriptionColor,
  );

  static TextStyle descriptionProjects = TextStyle(
    fontWeight: FontWeight.w700,
    fontSize: 1.3 * oneRem,
    fontFamily: fontFamily,
    color: MyAssetColor.descriptionColor,
  );

  static TextStyle descriptionNameLink = TextStyle(
    fontWeight: FontWeight.w400,
    fontSize: 1 * oneRem,
    fontFamily: fontFamily,
    color: Colors.blue,
  );

  static TextStyle companyName = TextStyle(
    fontWeight: FontWeight.w500,
    fontSize: 1.4 * oneRem,
    fontFamily: fontFamily,
    color: Colors.black,
  );

  static TextStyle companyDescription = TextStyle(
    fontWeight: FontWeight.w300,
    fontSize: 1 * oneRem,
    fontFamily: fontFamily,
    color: MyAssetColor.descriptionColor,
  );

  static TextStyle companyTimeline = TextStyle(
    fontWeight: FontWeight.w200,
    fontSize: 1 * oneRem,
    fontFamily: fontFamily,
    color: MyAssetColor.descriptionColor.withAlpha(150),
  );

  static TextStyle followText = TextStyle(
    fontWeight: FontWeight.w500,
    fontSize: 1.1 * oneRem,
    fontFamily: fontFamily,
    color: Colors.black,
  );
}