import 'package:flutter/material.dart';
import 'package:flutter_app_web/bloc/bloc_homepage.dart';
import 'package:flutter_app_web/bloc/bloc_provider.dart';
import 'package:flutter_app_web/res/colors.dart';
import 'package:flutter_app_web/res/constants.dart';
import 'package:flutter_app_web/res/fonts.dart';
import 'package:flutter_app_web/widgets/base_widget.dart';
import 'package:flutter_app_web/widgets/special_name.dart';

List<String> titleAppBar = ["Home", "Work", "Projects", "Contact"];

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

class MyAppBarMobile extends StatefulWidget {
  @override
  _MyAppBarMobileState createState() => _MyAppBarMobileState();
}

class _MyAppBarMobileState extends State<MyAppBarMobile> {
  BlocHomePage _parentBloc;
  int currentPage = 0;

  @override
  void initState() {
    super.initState();

    _parentBloc = BlocProvider.of<BlocHomePage>(context);
    _parentBloc.pageStream.listen((int data) {
      currentPage = data;
    });
  }

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
              onPressed: () => openDialog()),
        ],
      ),
    );
  }

  void openDialog() {
    List<Widget> listTextWidgets = List.generate(
        titleAppBar.length,
        (index) => NormalText(titleAppBar[index],
            onTap: () => tapPage(index),
            isChosen: index == currentPage)).toList();

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
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(),
                          SpecialTextName(),
                          IconButton(
                            icon:
                                Icon(Icons.close, color: MyAssetColor.appColor),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          ),
                        ],
                      ),
                    ),
                  ]..addAll(listTextWidgets),
                ),
              ),
            ),
          );
        });
  }

  void tapPage(int index) {
    _parentBloc.changePageIndex(index);
    Navigator.pop(context);
  }
}

class MyAppBarWeb extends StatefulWidget {
  @override
  _MyAppBarWebState createState() => _MyAppBarWebState();
}

class _MyAppBarWebState extends State<MyAppBarWeb> {
  BlocHomePage _parentBloc;
  bool isHover = false;
  int currentPage = 0;
  List<Widget> listTextWidgets = [];

  @override
  void initState() {
    super.initState();

    listTextWidgets =
        List<Widget>.generate(titleAppBar.length, (index) {
          return NormalText(titleAppBar[index],
              onTap: () => tapPage(index), isChosen: index == currentPage);
        }).toList();

    listTextWidgets.insert(titleAppBar.length ~/ 2, SpecialTextName());

    _parentBloc = BlocProvider.of<BlocHomePage>(context);
    _parentBloc.pageStream.listen((int data) {
      setState(() {
        currentPage = data;
      });
    });
  }

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
          children: listTextWidgets,
        ),
      ),
    );
  }

  void tapPage(int index) {
    print("index: $index");
    _parentBloc.changePageIndex(index);
  }
}

class NormalText extends StatelessWidget {
  final Function onTap;
  final String text;
  final bool isChosen;

  NormalText(this.text, {this.onTap, this.isChosen = false});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
      child: InkWell(
        onTap: onTap ?? () {},
        child: AnimatedDefaultTextStyle(
          duration: Duration(milliseconds: 200),
          style: isChosen
              ? MyAssetFonts.appBarTextSelected
              : MyAssetFonts.appBarTextUnselected,
          child: Text(
            text,
          ),
        ),
      ),
    );
  }
}
