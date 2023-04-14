import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

import '../../../res/colors.dart';
import '../cubit/home_cubit.dart';
import '../sections/my_appbar.dart';
import '../sections/my_contact.dart';
import '../sections/my_experience.dart';
import '../sections/my_profile.dart';
import '../sections/my_projects.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final ItemScrollController itemScrollController = ItemScrollController();

  final ItemPositionsListener itemPositionsListener =
      ItemPositionsListener.create();

  @override
  void initState() {
    super.initState();

    itemPositionsListener.itemPositions.addListener(listenItemPosition);
  }

  void listenItemPosition() {
    final List<ItemPosition> itemPositions =
        itemPositionsListener.itemPositions.value.toList();
    final int firstIndex = itemPositions[0].index;

    context.read<HomeCubit>().updateShadow(firstIndex);
    context.read<HomeCubit>().changePageIndex(firstIndex, isScroll: false);
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraint) {
        context.read<HomeCubit>().updateLayoutType(constraint.maxWidth);
        return Scaffold(
            backgroundColor: MyAssetColor.backgroundColor,
            body: BlocListener<HomeCubit, HomeState>(
              listener: (context, state) {
                if (state is HomeUpdateCurrentSection) {
                  if (state.isScroll) {
                    itemScrollController.scrollTo(
                      index: state.index,
                      duration: const Duration(milliseconds: 300),
                    );
                  }
                }
              },
              listenWhen: (HomeState prev, HomeState current) =>
                  current is HomeUpdateCurrentSection,
              child: Column(
                children: [
                  MyAppBar(),
                  Expanded(child: _buildPageView()),
                ],
              ),
            ));
      },
    );
  }

  Widget _buildPageView() {
    return ScrollablePositionedList.builder(
      itemCount: 4,
      scrollDirection: Axis.vertical,
      physics: const ClampingScrollPhysics(),
      itemScrollController: itemScrollController,
      itemPositionsListener: itemPositionsListener,
      itemBuilder: (context, index) {
        switch (index) {
          case 0:
            return const MyProfile();
          case 1:
            return const MyExperience();
          case 2:
            return const MyProjects();
          case 3:
            return MyContact();
          default:
            return Container();
        }
      },
    );
  }

  @override
  void dispose() {
    itemPositionsListener.itemPositions.removeListener(listenItemPosition);
    super.dispose();
  }
}
