import 'package:flutter/material.dart';
import '../res/constants.dart';
import '../res/fonts.dart';

class MyTitle extends StatelessWidget {
  final String text;

  const MyTitle(this.text, {Key? key}) : super(key: key);

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
