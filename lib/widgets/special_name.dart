import 'package:flutter/material.dart';
import 'package:flutter_app_web/res/constants.dart';
import 'package:flutter_app_web/res/fonts.dart';

class SpecialTextName extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Text(
        MyConstants.myName,
        style: MyAssetFonts.specialAppBarText,
      ),
    );
  }
}
