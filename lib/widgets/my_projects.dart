import 'dart:ui';

import 'package:flutter/material.dart';

import '../bloc/bloc_homepage.dart';
import '../res/constants.dart';
import '../res/fonts.dart';
import '../res/images.dart';
import '../utils/common.dart';
import 'base_widget.dart';
import 'my_title.dart';

class MyProjects extends BaseWidget {
  const MyProjects({Key? key}) : super(key: key);

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
  State<MyPageViewProjects> createState() => _MyPageViewProjectsState();
}

class _MyPageViewProjectsState extends State<MyPageViewProjects> {
  late PageController _pageController;
  int currentPage = 3;

  @override
  void initState() {
    super.initState();

    _pageController = PageController(
        initialPage: currentPage, viewportFraction: widget.viewPort);
    _pageController.addListener(() {
      int page = _pageController.page!.toInt() % 5;
      if (page != currentPage) {
        if (mounted) {
          setState(() {
            currentPage = page;
          });
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    List<List<String>> listImages = [
      [
        MyAssetImages.imageFlashSale,
        MyConstants.descFlashSale,
        MyConstants.linkFlashSale
      ],
      [
        MyAssetImages.imageDailyDeal,
        MyConstants.descDailyDeal,
        MyConstants.linkDailyDeal
      ],
      [MyAssetImages.imageLmx, MyConstants.descLmx, MyConstants.linkLmx],
      [
        MyAssetImages.imageCakeHomescreen,
        MyConstants.descCake,
        MyConstants.linkCake
      ],
      [
        MyAssetImages.imageLuckySale,
        MyConstants.descLuckySale,
        MyConstants.linkLuckySale
      ],
      [MyAssetImages.imageGos, MyConstants.descGos, MyConstants.linkGos],
    ];

    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Column(
      children: [
        const MyTitle("Recent Projects"),
        Container(
          height: screenHeight / 1.4,
          width: screenWidth,
          margin: const EdgeInsets.only(bottom: 50),
          child: PageView.builder(
              controller: _pageController,
              itemBuilder: (context, index) {
                int page = index % 5;

                return SizedBox(
                  width: screenWidth / 2,
                  height: screenHeight / 1.4,
                  child: ImageDescription(
                    listImages[page][0],
                    description: listImages[page][1],
                    link: listImages[page][2],
                    isCurrent: currentPage == page,
                  ),
                );
              }),
        ),
      ],
    );
  }
}

class ImageDescription extends StatefulWidget {
  final String image;
  final String description;
  final bool isCurrent;
  final String link;

  const ImageDescription(this.image,
      {Key? key, this.description = "", this.isCurrent = false, this.link = ""})
      : super(key: key);

  @override
  State<ImageDescription> createState() => _ImageDescriptionState();
}

class _ImageDescriptionState extends State<ImageDescription> {
  bool isHover = false;

  @override
  Widget build(BuildContext context) {
    double sigma = isHover ? 2 : 0.5;
    double opacity = 1;
    if (isHover) {
      opacity = 0.15;
    } else {
      opacity = widget.isCurrent ? 1 : 0.5;
    }

    return BlocHomePage.currentType == LayoutType.phone
        ? buildPhone(sigma, opacity)
        : buildWeb(sigma, opacity);
  }

  Widget buildPhone(double sigma, double opacity) {
    return InkWell(
      onTap: () {
        setState(() {
          isHover = !isHover;
        });
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Stack(
          fit: StackFit.expand,
          children: [
            AnimatedOpacity(
              duration: const Duration(milliseconds: 200),
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
                    child: SizedBox(
                      width: 250,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            widget.description,
                            textAlign: TextAlign.center,
                            style: MyAssetFonts.descriptionProjects,
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          widget.link.isEmpty
                              ? Container()
                              : InkWell(
                                  onTap: () {
                                    Common.launch(widget.link);
                                  },
                                  child: Text(
                                    "More info",
                                    style: MyAssetFonts.descriptionNameLink,
                                  ),
                                ),
                        ],
                      ),
                    ),
                  )
                : Container()
          ],
        ),
      ),
    );
  }

  Widget buildWeb(double sigma, double opacity) {
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
              duration: const Duration(milliseconds: 200),
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
                    child: SizedBox(
                      width: 250,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            widget.description,
                            textAlign: TextAlign.center,
                            style: MyAssetFonts.descriptionName,
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          widget.link.isEmpty
                              ? Container()
                              : InkWell(
                                  onTap: () {
                                    Common.launch(widget.link);
                                  },
                                  child: Text(
                                    "More info",
                                    style: MyAssetFonts.descriptionNameLink,
                                  ),
                                ),
                        ],
                      ),
                    ),
                  )
                : Container()
          ],
        ),
      ),
    );
  }
}
