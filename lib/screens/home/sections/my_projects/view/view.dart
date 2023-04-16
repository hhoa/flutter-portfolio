import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../model/project_model.dart';
import '../../../../../widgets/base_widget.dart';
import '../../../../../widgets/my_title.dart';
import '../cubit/my_project_cubit.dart';
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
      cubit.updateCurrentProject(_pageController.page!.toInt());
    });
  }

  @override
  Widget build(BuildContext context) {
    final MyProjectCubit cubit = context.read<MyProjectCubit>();
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;

    return Column(
      children: [
        MyTitle(cubit.recentProjectsTitle),
        Container(
          height: screenHeight / 1.4,
          width: screenWidth,
          margin: const EdgeInsets.only(bottom: 50),
          child: BlocBuilder<MyProjectCubit, MyProjectState>(
            buildWhen: (prev, current) => current is MyProjectUpdateCurrentPage,
            builder: (context, state) {
              return PageView.builder(
                  controller: _pageController,
                  itemBuilder: (context, index) {
                    final int page = cubit.calculatePage(index);
                    final ProjectModel model = cubit.projects[page];

                    return SizedBox(
                      width: screenWidth / 2,
                      height: screenHeight / 1.4,
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
      ],
    );
  }
}
