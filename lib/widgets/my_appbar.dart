import 'package:flutter/material.dart';
import 'package:flutter_app_web/res/colors.dart';
import 'package:flutter_app_web/res/constants.dart';
import 'package:flutter_app_web/res/fonts.dart';
import 'package:flutter_app_web/widgets/base_widget.dart';
import 'package:flutter_app_web/widgets/special_name.dart';

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
  Widget buildTablet(BuildContext context) {
    return MyAppBarWeb();
  }
}

class MyAppBarMobile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MyConstants.heightAppBar,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(),
          SpecialTextName(),
          IconButton(
              icon: Icon(
                Icons.menu,
                color: MyAssetColor.appColor,
              ),
              onPressed: () => openDialog(context)),
        ],
      ),
    );
  }

  void openDialog(BuildContext context) {
    showGeneralDialog(
        context: context,
        barrierDismissible: true,
        barrierLabel: "App Bar Dialog",
        transitionDuration: Duration(milliseconds: 200),
        pageBuilder: (context, anim1, anim2) {
          return GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Scaffold(
              backgroundColor: MyAssetColor.backgroundColor.withOpacity(0.5),
              body: Container(
                color: MyAssetColor.backgroundColor,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      height: MyConstants.heightAppBar,
                      child: Row(
                        mainAxisAlignment:
                        MainAxisAlignment.spaceBetween,
                        children: [
                          Container(),
                          SpecialTextName(),
                          IconButton(
                            icon: Icon(Icons.close,
                                color: MyAssetColor.appColor),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          ),
                        ],
                      ),
                    ),
                    NormalText("Home", isChosen: true),
                    NormalText("Work", isChosen: false),
                    NormalText("Projects", isChosen: false),
                    NormalText("Contact", isChosen: false),
                  ],
                ),
              ),
            ),
          );
        });
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
        height: MyConstants.heightAppBar,
        decoration: BoxDecoration(
          color: isHover ? Colors.white : MyAssetColor.backgroundColor,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            NormalText("Home", isChosen: true),
            NormalText("Work", isChosen: false),
            SpecialTextName(),
            NormalText("Projects", isChosen: false),
            NormalText("Contact", isChosen: false),
          ],
        ),
      ),
    );
  }
}

class NormalText extends StatelessWidget {
  final String text;
  final bool isChosen;

  NormalText(this.text, {this.isChosen = false});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
      child: Text(
        text,
        style: isChosen
            ? MyAssetFonts.appBarTextSelected
            : MyAssetFonts.appBarTextUnselected,
      ),
    );
  }
}



