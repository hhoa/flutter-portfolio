import 'package:flutter/material.dart';
import 'package:flutter_app_web/res/colors.dart';
import 'package:flutter_app_web/res/fonts.dart';

class MyAppBar extends StatefulWidget {
  @override
  _MyAppBarState createState() => _MyAppBarState();
}

class _MyAppBarState extends State<MyAppBar> {
  bool isHover = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (event) {
        setState(() {
          isHover = true;
        });
      },
      onExit: (event) {
        setState(() {
          isHover = false;
        });
      },
      child: AnimatedContainer(
        duration: Duration(milliseconds: 200),
        height: 80,
        decoration: BoxDecoration(
          color: isHover ? Colors.white : MyAssetColor.backgroundColor,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            buildText("Home", isChosen: true),
            buildText("Work", isChosen: false),
            buildSpecialText("Me."),
            buildText("Projects", isChosen: false),
            buildText("Contact", isChosen: false),
          ],
        ),
      ),
    );
  }

  Widget buildSpecialText(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Text(
        text,
        style: MyAssetFonts.specialAppBarText,
      ),
    );
  }

  Widget buildText(String text, {bool isChosen = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Text(
        text,
        style: isChosen
            ? MyAssetFonts.appBarTextSelected
            : MyAssetFonts.appBarTextUnselected,
      ),
    );
  }
}
