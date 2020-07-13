import 'package:flutter/material.dart';
import 'package:flutter_app_web/res/colors.dart';
import 'package:flutter_app_web/res/fonts.dart';
import 'package:flutter_app_web/widgets/base_widget.dart';

class MyAppBar extends BaseWidget {
  @override
  Widget buildPhone(BuildContext context) {
    return MyAppBarMobile();
  }

  @override
  Widget buildWeb(BuildContext context) {
    return MyAppBarWeb();
  }

  @override
  Widget buildTable(BuildContext context) {
    return MyAppBarWeb();
  }
}

class MyAppBarMobile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(),
          SpecialText("Me."),
          IconButton(
              icon: Icon(
                Icons.menu,
                color: MyAssetColor.appColor,
              ),
              onPressed: () {

              }),
        ],
      ),
    );
  }
}

class MyAppBarWeb extends StatefulWidget {
  @override
  _MyAppBarWebState createState() => _MyAppBarWebState();
}

class _MyAppBarWebState extends State<MyAppBarWeb> {
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
            SpecialText("Me."),
            buildText("Projects", isChosen: false),
            buildText("Contact", isChosen: false),
          ],
        ),
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

class SpecialText extends StatelessWidget {
  final String text;

  SpecialText(this.text);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Text(
        text,
        style: MyAssetFonts.specialAppBarText,
      ),
    );
  }
}
