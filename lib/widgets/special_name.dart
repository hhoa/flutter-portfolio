import 'package:flutter/material.dart';

import '../res/fonts.dart';

class SpecialTextName extends StatelessWidget {
  const SpecialTextName(this.name, {Key? key}) : super(key: key);

  final String name;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Center(
        child: Text(
          name,
          style: MyAssetFonts.specialAppBarText,
        ),
      ),
    );
  }
}
