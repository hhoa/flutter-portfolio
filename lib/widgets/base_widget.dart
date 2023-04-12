import 'package:flutter/material.dart';
import '../bloc/bloc_homepage.dart';

abstract class BaseWidget extends StatelessWidget {
  const BaseWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (BlocHomePage.currentType == LayoutType.web) {
      return buildWeb(context);
    } else if (BlocHomePage.currentType == LayoutType.tablet) {
      return buildTablet(context);
    } else {
      return buildPhone(context);
    }
  }

  Widget buildWeb(BuildContext context);

  Widget buildTablet(BuildContext context);

  Widget buildPhone(BuildContext context);

}