import 'package:flutter/material.dart';
import 'package:flutter_app_web/res/constants.dart';
import 'package:flutter_app_web/res/fonts.dart';

class MyTitle extends StatelessWidget {
  final String text;

  MyTitle(this.text);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: MyConstants.paddingVertical),
      child: Text(
        text,
        style: MyAssetFonts.bigBoldTitle,
      ),
    );
  }
}
