import 'package:flutter/material.dart';
import '../bloc/bloc_homepage.dart';
import '../bloc/bloc_provider.dart';
import '../res/colors.dart';
import '../res/constants.dart';
import '../res/fonts.dart';
import 'base_widget.dart';
import 'special_name.dart';

List<String> titleAppBar = ["Home", "Work", "Projects", "Contact"];

class MyAppBar extends BaseWidget {
  const MyAppBar({Key? key}) : super(key: key);

  @override
  Widget buildPhone(BuildContext context) {
    return const MyAppBarMobile();
  }

  @override
  Widget buildWeb(BuildContext context) {
    return const MyAppBarWeb();
  }

  @override
  Widget buildTablet(BuildContext context) {
    return const MyAppBarWeb();
  }
}

class MyAppBarMobile extends StatefulWidget {
  const MyAppBarMobile({Key? key}) : super(key: key);

  @override
  State<MyAppBarMobile> createState() => _MyAppBarMobileState();
}

class _MyAppBarMobileState extends State<MyAppBarMobile> {
  late BlocHomePage _parentBloc;
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
    return StreamBuilder<bool>(
        stream: _parentBloc.appBarShadowStream,
        initialData: false,
        builder: (context, snapshot) {
          bool isShadow = snapshot.data ?? false;
          return SafeArea(
            top: true,
            bottom: false,
            child: Container(
              height: MyConstants.heightAppBar,
              decoration: BoxDecoration(
                  color: MyAssetColor.backgroundColor,
                  boxShadow: isShadow
                      ? [
                          const BoxShadow(
                              color: Colors.black12,
                              offset: Offset(0, 4),
                              blurRadius: 4,
                              spreadRadius: 4)
                        ]
                      : null),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const SizedBox(width: 48),
                  const SpecialTextName(),
                  IconButton(
                      icon: Icon(
                        Icons.menu,
                        color: MyAssetColor.appColor,
                      ),
                      onPressed: openDialog),
                ],
              ),
            ),
          );
        });
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
        transitionDuration: const Duration(milliseconds: 200),
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
                    SizedBox(
                      height: MyConstants.heightAppBar,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(),
                          const SpecialTextName(),
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
                    ...listTextWidgets,
                  ],
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
  const MyAppBarWeb({Key? key}) : super(key: key);

  @override
  State<MyAppBarWeb> createState() => _MyAppBarWebState();
}

class _MyAppBarWebState extends State<MyAppBarWeb> {
  late BlocHomePage _parentBloc;
  bool isHover = false;
  int currentPage = 0;
  List<Widget> listTextWidgets = [];

  @override
  void initState() {
    super.initState();

    _parentBloc = BlocProvider.of<BlocHomePage>(context);
    _parentBloc.pageStream.listen((int data) {
      if (mounted) {
        setState(() {
          currentPage = data;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    listTextWidgets = List<Widget>.generate(titleAppBar.length, (index) {
      return NormalText(titleAppBar[index],
          onTap: () => tapPage(index), isChosen: index == currentPage);
    }).toList();

    listTextWidgets.insert(titleAppBar.length ~/ 2, const SpecialTextName());

    return MouseRegion(
      onEnter: (event) {
        if (mounted) {
          setState(() {
            isHover = true;
          });
        }
      },
      onExit: (event) {
        if (mounted) {
          setState(() {
            isHover = false;
          });
        }
      },
      child: StreamBuilder<bool>(
          stream: _parentBloc.appBarShadowStream,
          initialData: false,
          builder: (context, snapshot) {
            bool isShadow = snapshot.data ?? false;
            return Container(
              height: MyConstants.heightAppBar,
              decoration: BoxDecoration(
                  color: isHover ? Colors.white : MyAssetColor.backgroundColor,
                  boxShadow: isShadow
                      ? [
                          const BoxShadow(
                              color: Colors.black12,
                              offset: Offset(0, 4),
                              blurRadius: 4,
                              spreadRadius: 4)
                        ]
                      : null),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: listTextWidgets,
              ),
            );
          }),
    );
  }

  void tapPage(int index) {
    _parentBloc.changePageIndex(index);
  }
}

class NormalText extends StatelessWidget {
  final VoidCallback? onTap;
  final String text;
  final bool isChosen;

  const NormalText(this.text, {Key? key, this.onTap, this.isChosen = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
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
    );
  }
}
