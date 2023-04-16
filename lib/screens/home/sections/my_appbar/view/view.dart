import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../res/colors.dart';
import '../../../../../res/constants.dart';
import '../../../../../widgets/base_widget.dart';
import '../../../../../widgets/normal_text.dart';
import '../../../../../widgets/special_name.dart';
import '../../../cubit/home_cubit.dart';
import '../cubit/my_app_bar_cubit.dart';

class MyAppBarView extends BaseWidget {
  const MyAppBarView({Key? key}) : super(key: key);

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

class MyAppBarMobile extends StatelessWidget {
  const MyAppBarMobile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<String> titleAppBar = context.read<MyAppBarCubit>().titleAppBar;
    final String myName = context.read<MyAppBarCubit>().myName;

    return SafeArea(
      top: true,
      bottom: false,
      child: Builder(
        builder: (context) {
          final bool isShadow =
              context.select((HomeCubit cubit) => cubit.isShadow);
          return Container(
            key: const Key('container-appbar-mobile'),
            height: MyConstants.heightAppBar,
            decoration: BoxDecoration(
                color: MyAssetColor.backgroundColor,
                boxShadow: isShadow
                    ? [
                        const BoxShadow(
                          color: Colors.black12,
                          offset: Offset(0, 4),
                          blurRadius: 4,
                        )
                      ]
                    : null),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const SizedBox(width: 48),
                SpecialTextName(myName),
                IconButton(
                    key: const Key('appbar-icon-menu'),
                    icon: Icon(
                      Icons.menu,
                      color: MyAssetColor.appColor,
                    ),
                    onPressed: () => openDialog(context, myName, titleAppBar)),
              ],
            ),
          );
        },
      ),
    );
  }

  void openDialog(
      BuildContext context, String myName, List<String> titleAppBar) {
    final currentSection = context.read<HomeCubit>().currentSection;

    showGeneralDialog(
        context: context,
        barrierDismissible: true,
        barrierLabel: "App Bar Dialog",
        transitionDuration: const Duration(milliseconds: 200),
        pageBuilder: (ctx, anim1, anim2) {
          final double paddingTop = MediaQuery.of(ctx).padding.top;
          return GestureDetector(
            onTap: () => Navigator.pop(ctx),
            child: Scaffold(
              backgroundColor: MyAssetColor.backgroundColor.withOpacity(0.5),
              body: Container(
                color: MyAssetColor.backgroundColor,
                padding: EdgeInsets.only(top: paddingTop),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      height: MyConstants.heightAppBar,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const SizedBox(width: 48),
                          SpecialTextName(myName),
                          IconButton(
                            key: const Key('appbar-icon-close'),
                            icon:
                                Icon(Icons.close, color: MyAssetColor.appColor),
                            onPressed: () {
                              Navigator.pop(ctx);
                            },
                          ),
                        ],
                      ),
                    ),
                    ListView.separated(
                      primary: false,
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      itemBuilder: (_, int index) {
                        return NormalText(
                          titleAppBar[index],
                          key: Key('normalText-${titleAppBar[index]}'),
                          onTap: () => tapPage(context, index),
                          isChosen: index == currentSection,
                        );
                      },
                      separatorBuilder: (_, __) => const SizedBox(height: 20),
                      itemCount: titleAppBar.length,
                      shrinkWrap: true,
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }

  void tapPage(BuildContext context, int index) {
    context.read<HomeCubit>().changePageIndex(index);
    Navigator.pop(context);
  }
}

class MyAppBarWeb extends StatelessWidget {
  const MyAppBarWeb({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) {
        context.read<MyAppBarCubit>().updateHover(isHover: true);
      },
      onExit: (_) {
        context.read<MyAppBarCubit>().updateHover(isHover: false);
      },
      child: Builder(builder: (context) {
        final bool isShadow =
            context.select((HomeCubit cubit) => cubit.isShadow);
        final int currentSection =
            context.select((HomeCubit cubit) => cubit.currentSection);
        final bool isHover = context.select((MyAppBarCubit cubit) =>
            (cubit.state is MyAppBarHover &&
                (cubit.state as MyAppBarHover).isHover));

        return Container(
          key: const Key('container-appbar-web'),
          height: MyConstants.heightAppBar,
          alignment: Alignment.center,
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
          child: _buildListTitle(context, currentSection),
        );
      }),
    );
  }

  Widget _buildListTitle(BuildContext context, int currentSection) {
    final List<String> titleAppBar = context.read<MyAppBarCubit>().titleAppBar;
    final String myName = context.read<MyAppBarCubit>().myName;

    final int nameIndex = titleAppBar.length ~/ 2;
    return ListView.builder(
      padding: EdgeInsets.zero,
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      scrollDirection: Axis.horizontal,
      itemBuilder: (_, int index) {
        if (index == nameIndex) {
          return SpecialTextName(myName);
        }

        final int appBarIndex = index < nameIndex ? index : index - 1;
        return NormalText(
          titleAppBar[appBarIndex],
          key: Key('normalText-${titleAppBar[appBarIndex]}'),
          onTap: () => tapPage(context, appBarIndex),
          isChosen: appBarIndex == currentSection,
        );
      },
      itemCount: titleAppBar.length + 1,
    );
  }

  void tapPage(BuildContext context, int index) {
    context.read<HomeCubit>().changePageIndex(index);
  }
}
