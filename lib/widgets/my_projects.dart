import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_app_web/res/fonts.dart';
import 'package:flutter_app_web/res/images.dart';
import 'package:flutter_app_web/widgets/base_widget.dart';

class MyProjects extends BaseWidget {
  @override
  Widget buildPhone(BuildContext context) {
    return MyPageViewProjects(0.8);
  }

  @override
  Widget buildTablet(BuildContext context) {
    return MyPageViewProjects(0.55);
  }

  @override
  Widget buildWeb(BuildContext context) {
    return MyPageViewProjects(0.3);
  }
}

class MyPageViewProjects extends StatefulWidget {
  MyPageViewProjects(this.viewPort) : super(key: ValueKey(viewPort));

  final double viewPort;

  @override
  _MyPageViewProjectsState createState() => _MyPageViewProjectsState();
}

class _MyPageViewProjectsState extends State<MyPageViewProjects> {
  PageController _pageController;
  int currentPage = 2;

  @override
  void initState() {
    super.initState();

    _pageController = PageController(
        initialPage: currentPage, viewportFraction: widget.viewPort);
    _pageController.addListener(() {
      int page = _pageController.page.toInt() % 5;
      if (page != currentPage) {
        setState(() {
          currentPage = page;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    List<String> listImages = [
      MyAssetImages.imageFlashSale,
      MyAssetImages.imageDailyDeal,
      MyAssetImages.imageLmx,
      MyAssetImages.imageLuckySale,
      MyAssetImages.imageGos,
    ];

    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Container(
      height: screenHeight / 1.4,
      width: screenWidth,
      child: PageView.builder(
          controller: _pageController,
          itemBuilder: (context, index) {
            int page = index % 5;

            return Container(
              width: screenWidth / 2,
              height: screenHeight / 1.4,
              child: ImageDescription(
                listImages[page],
                isCurrent: currentPage == page,
                description: "Item $index",
              ),
            );
          }),
    );
  }
}

class ImageDescription extends StatefulWidget {
  final String image;
  final String description;
  final bool isCurrent;

  ImageDescription(this.image, {this.description = "", this.isCurrent = false});

  @override
  _ImageDescriptionState createState() => _ImageDescriptionState();
}

class _ImageDescriptionState extends State<ImageDescription> {
  bool isHover = false;

  @override
  Widget build(BuildContext context) {
    double sigma = isHover ? 2 : 0;
    double opacity = 1;
    if (isHover) {
      opacity = 0.5;
    } else {
      opacity = widget.isCurrent ? 1 : 0.5;
    }

    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: MouseRegion(
        onEnter: (_) {
          setState(() {
            isHover = true;
          });
        },
        onExit: (_) {
          setState(() {
            isHover = false;
          });
        },
        child: Stack(
          fit: StackFit.expand,
          children: [
            AnimatedOpacity(
              duration: Duration(milliseconds: 200),
              opacity: opacity,
              child: Image.asset(
                widget.image,
                fit: BoxFit.fitHeight,
              ),
            ),
            BackdropFilter(
              filter: ImageFilter.blur(
                sigmaX: sigma,
                sigmaY: sigma,
              ),
              child: Container(),
            ),
            isHover
                ? Align(
                    alignment: Alignment.center,
                    child: Text(
                      widget.description,
                      style: MyAssetFonts.descriptionName,
                    ),
                  )
                : Container()
          ],
        ),
      ),
    );
  }
}
