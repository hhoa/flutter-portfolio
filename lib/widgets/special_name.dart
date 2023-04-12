import 'package:flutter/material.dart';
import '../res/constants.dart';
import '../res/fonts.dart';

class SpecialTextName extends StatelessWidget {
  const SpecialTextName({Key? key}) : super(key: key);

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
