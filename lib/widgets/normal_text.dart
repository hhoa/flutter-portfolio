import 'package:flutter/material.dart';

import '../res/fonts.dart';

class NormalText extends StatelessWidget {
  final VoidCallback? onTap;
  final String text;
  final bool isChosen;

  const NormalText(this.text, {Key? key, this.onTap, this.isChosen = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Center(
        child: InkWell(
          onTap: onTap,
          child: AnimatedDefaultTextStyle(
            duration: const Duration(milliseconds: 200),
            style: isChosen
                ? MyAssetFonts.appBarTextSelected
                : MyAssetFonts.appBarTextUnselected,
            child: Text(
              text,
            ),
          ),
        ),
      ),
    );
  }
}