import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../model/project_model.dart';
import '../../../../../widgets/base_widget.dart';
import '../../../../../widgets/my_title.dart';
import '../cubit/my_project_cubit.dart';
import '../widgets/dots_animation.dart';
import '../widgets/project_image_description.dart';

class MyProjectsView extends BaseWidget {
  const MyProjectsView({Key? key}) : super(key: key);

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

  @override
  void initState() {
    super.initState();

    final MyProjectCubit cubit = context.read<MyProjectCubit>();
    _pageController = PageController(
        initialPage: cubit.currentPage, viewportFraction: widget.viewPort);
    _pageController.addListener(() {
      if (_pageController.hasClients) {
        cubit.handleScroll(_pageController.page!);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final double projectHeight = MediaQuery.of(context).size.height / 1.4;
    final double screenWidth = MediaQuery.of(context).size.width;

    return Column(
      children: [
        Builder(builder: (context) {
          final String recentProjectsTitle = context
              .select((MyProjectCubit cubit) => cubit.recentProjectsTitle);
          return MyTitle(recentProjectsTitle);
        }),
        SizedBox(
          height: projectHeight,
          width: screenWidth,
          child: BlocBuilder<MyProjectCubit, MyProjectState>(
            buildWhen: (prev, current) => current is MyProjectUpdateCurrentPage,
            builder: (context, state) {
              return PageView.builder(
                  key: const Key('project-pageview'),
                  controller: _pageController,
                  itemBuilder: (context, index) {
                    final MyProjectCubit cubit = context.read<MyProjectCubit>();
                    final int page = index % cubit.projectLength;
                    final ProjectModel model = cubit.projects[page];

                    return SizedBox(
                      width: screenWidth / 2,
                      height: projectHeight,
                      child: ProjectImageDescription(
                        model.image,
                        description: model.description,
                        link: model.link,
                        isCurrent: cubit.currentPage == page,
                      ),
                    );
                  });
            },
          ),
        ),
        BlocBuilder<MyProjectCubit, MyProjectState>(
          buildWhen: (prev, current) => current is MyProjectUpdateDotAnimation,
          builder: (context, state) {
            if (state is! MyProjectUpdateDotAnimation) {
              return Container();
            }

            return Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: DotsAnimation(
                listLength: state.length,
                currentPage: state.currentPage,
                nextPage: state.nextPage,
                isSwipeRight: state.isSwipeRight,
                offset: state.offset,
              ),
            );
          },
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}
