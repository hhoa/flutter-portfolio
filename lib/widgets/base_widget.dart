import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../enum/layout_type.dart';
import '../screens/home/cubit/home_cubit.dart';

abstract class BaseWidget extends StatelessWidget {
  const BaseWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final LayoutType currentType = context.read<HomeCubit>().currentType;
    switch (currentType) {
      case LayoutType.web:
        return buildWeb(context);
      case LayoutType.tablet:
        return buildTablet(context);
      case LayoutType.phone:
        return buildPhone(context);
    }
  }

  Widget buildWeb(BuildContext context);

  Widget buildTablet(BuildContext context);

  Widget buildPhone(BuildContext context);
}
