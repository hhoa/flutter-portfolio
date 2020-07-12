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

  static TextStyle boldName = TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 24,
    height: 30 / 24,
    color: Color(0xff453E3E),
  );
}