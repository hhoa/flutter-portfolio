import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../enum/remote_config.dart';
import '../../../res/colors.dart';
import '../../../res/constants.dart';
import '../../../utils/remote_config.dart';
import '../../../widgets/base_widget.dart';
import '../../../widgets/normal_text.dart';
import '../../../widgets/special_name.dart';
import '../cubit/home_cubit.dart';

class MyAppBar extends BaseWidget {
  MyAppBar({Key? key}) : super(key: key) {
    titleAppBar = RemoteConfigUtils.getValueString(
            RemoteConfigEnum.listAppBarTitleText.key)
        .split(',');
  }

  late final List<String> titleAppBar;

  @override
  Widget buildPhone(BuildContext context) {
    return MyAppBarMobile(titleAppBar);
  }

  @override
  Widget buildWeb(BuildContext context) {
    return MyAppBarWeb(titleAppBar);
  }

  @override
  Widget buildTablet(BuildContext context) {
    return MyAppBarWeb(titleAppBar);
  }
}

class MyAppBarMobile extends StatelessWidget {
  const MyAppBarMobile(this.titleAppBar, {Key? key}) : super(key: key);

  final List<String> titleAppBar;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: true,
      bottom: false,
      child: BlocBuilder<HomeCubit, HomeState>(
        buildWhen: (HomeState prev, HomeState current) =>
            current is HomeUpdateShadow,
        builder: (context, state) {
          bool isShadow = false;
          if (state is HomeUpdateShadow) {
            isShadow = state.isShadow;
          }
          return Container(
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
                const SpecialTextName(),
                IconButton(
                    icon: Icon(
                      Icons.menu,
                      color: MyAssetColor.appColor,
                    ),
                    onPressed: () => openDialog(context)),
              ],
            ),
          );
        },
      ),
    );
  }

  void openDialog(BuildContext context) {
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
                          const SpecialTextName(),
                          IconButton(
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

class MyAppBarWeb extends StatefulWidget {
  const MyAppBarWeb(this.titleAppBar, {Key? key}) : super(key: key);

  final List<String> titleAppBar;

  @override
  State<MyAppBarWeb> createState() => _MyAppBarWebState();
}

class _MyAppBarWebState extends State<MyAppBarWeb> {
  bool isHover = false;

  List<String> get titleAppBar => widget.titleAppBar;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) {
        if (mounted) {
          setState(() {
            isHover = true;
          });
        }
      },
      onExit: (_) {
        if (mounted) {
          setState(() {
            isHover = false;
          });
        }
      },
      child: BlocBuilder<HomeCubit, HomeState>(
        buildWhen: (HomeState prev, HomeState current) =>
            current is HomeUpdateShadow,
        builder: (context, state) {
          bool isShadow = false;
          if (state is HomeUpdateShadow) {
            isShadow = state.isShadow;
          }

          return Container(
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
            child: BlocBuilder<HomeCubit, HomeState>(
              buildWhen: (prev, current) => current is HomeUpdateCurrentSection,
              builder: (context, state) {
                int currentSection = 0;
                if (state is HomeUpdateCurrentSection) {
                  currentSection = state.index;
                }

                final int nameIndex = titleAppBar.length ~/ 2;
                return ListView.builder(
                  padding: EdgeInsets.zero,
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (_, int index) {
                    if (index == nameIndex) {
                      return const SpecialTextName();
                    }

                    final int appBarIndex =
                        index < nameIndex ? index : index - 1;
                    return NormalText(
                      titleAppBar[appBarIndex],
                      onTap: () => tapPage(appBarIndex),
                      isChosen: appBarIndex == currentSection,
                    );
                  },
                  itemCount: titleAppBar.length + 1,
                );
              },
            ),
          );
        },
      ),
    );
  }

  void tapPage(int index) {
    context.read<HomeCubit>().changePageIndex(index);
  }
}
