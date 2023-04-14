import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../enum/layout_type.dart';
import '../../../enum/remote_config.dart';
import '../../../model/project_model.dart';
import '../../../res/fonts.dart';
import '../../../utils/common.dart';
import '../../../utils/remote_config.dart';
import '../../../widgets/base_widget.dart';
import '../../../widgets/my_title.dart';
import '../cubit/home_cubit.dart';

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
  late final List<ProjectModel> projects;
  int currentPage = 0;

  int get projectLength => projects.length;

  @override
  void initState() {
    super.initState();

    projects = projectModelFromJson(
        RemoteConfigUtils.getValueString(RemoteConfigEnum.project.key));
    currentPage = (projectLength / 2).round();
    _pageController = PageController(
        initialPage: currentPage, viewportFraction: widget.viewPort);
    _pageController.addListener(() {
      final int page = _pageController.page!.toInt() % (projectLength - 1);
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
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;
    final String recentProjectsTitle = RemoteConfigUtils.getValueString(
        RemoteConfigEnum.recentProjectsText.key);

    return Column(
      children: [
        MyTitle(recentProjectsTitle),
        Container(
          height: screenHeight / 1.4,
          width: screenWidth,
          margin: const EdgeInsets.only(bottom: 50),
          child: PageView.builder(
              controller: _pageController,
              itemBuilder: (context, index) {
                final int page = index % (projectLength - 1);
                final ProjectModel model = projects[page];

                return SizedBox(
                  width: screenWidth / 2,
                  height: screenHeight / 1.4,
                  child: ImageDescription(
                    model.image,
                    description: model.description,
                    link: model.link,
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
  final bool isCurrent;
  final String? description;
  final String? link;

  const ImageDescription(
    this.image, {
    Key? key,
    this.description,
    this.isCurrent = false,
    this.link,
  }) : super(key: key);

  @override
  State<ImageDescription> createState() => _ImageDescriptionState();
}

class _ImageDescriptionState extends State<ImageDescription> {
  bool isHover = false;

  @override
  Widget build(BuildContext context) {
    final LayoutType currentType = context.read<HomeCubit>().currentType;
    final double sigma = isHover ? 2 : 0.5;
    double opacity = 1;
    if (isHover) {
      opacity = 0.15;
    } else {
      opacity = widget.isCurrent ? 1 : 0.5;
    }

    return currentType == LayoutType.phone
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
            _buildImage(opacity),
            _buildFilter(sigma),
            if (isHover)
              Align(
                alignment: Alignment.center,
                child: SizedBox(
                  width: 250,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        widget.description ?? '',
                        textAlign: TextAlign.center,
                        style: MyAssetFonts.descriptionProjects,
                      ),
                      const SizedBox(height: 8),
                      _buildMoreInfoButton(),
                    ],
                  ),
                ),
              )
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
            _buildImage(opacity),
            _buildFilter(sigma),
            if (isHover)
              Align(
                alignment: Alignment.center,
                child: SizedBox(
                  width: 250,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        widget.description ?? '',
                        textAlign: TextAlign.center,
                        style: MyAssetFonts.descriptionName,
                      ),
                      const SizedBox(height: 8),
                      _buildMoreInfoButton(),
                    ],
                  ),
                ),
              )
          ],
        ),
      ),
    );
  }

  Widget _buildImage(double opacity) {
    return AnimatedOpacity(
      duration: const Duration(milliseconds: 200),
      opacity: opacity,
      child: Image.network(
        widget.image,
        fit: BoxFit.fitHeight,
      ),
    );
  }

  Widget _buildFilter(double sigma) {
    return BackdropFilter(
      filter: ImageFilter.blur(
        sigmaX: sigma,
        sigmaY: sigma,
      ),
      child: Container(),
    );
  }

  Widget _buildMoreInfoButton() {
    if (widget.link != null && widget.link!.isEmpty) {
      return Container();
    }

    final String moreInfoTitle = RemoteConfigUtils.getValueString(
        RemoteConfigEnum.recentProjectsText.key);
    return InkWell(
      onTap: () {
        Common.launch(widget.link!);
      },
      child: Text(
        moreInfoTitle,
        style: MyAssetFonts.descriptionNameLink,
      ),
    );
  }
}
