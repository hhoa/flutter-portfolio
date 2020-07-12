import 'package:flutter/material.dart';
import 'package:flutter_app_web/res/colors.dart';

class MyAssetFonts {
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

  static TextStyle descriptionName = TextStyle(
    fontWeight: FontWeight.w300,
    fontSize: 1.3 * oneRem,
    fontFamily: fontFamily,
    color: MyAssetColor.descriptionColor,
  );
}