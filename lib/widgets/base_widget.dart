import 'package:flutter/material.dart';
import 'package:flutter_app_web/bloc/bloc_homepage.dart';

abstract class BaseWidget extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    if (BlocHomePage.currentType == LayoutType.Web) {
      return buildWeb(context);
    } else if (BlocHomePage.currentType == LayoutType.Tablet) {
      return buildTablet(context);
    } else {
      return buildPhone(context);
    }
  }

  Widget buildWeb(BuildContext context);

  Widget buildTablet(BuildContext context);

  Widget buildPhone(BuildContext context);

}