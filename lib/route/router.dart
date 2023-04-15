import 'package:flutter/material.dart';

import '../screens/home/view/page.dart';

Route<dynamic>? generateRoute(RouteSettings routeSettings) {
  switch (routeSettings.name) {
    case HomePage.routeName:
      return MaterialPageRoute(
          settings: routeSettings, builder: (context) => const HomePage());
    default:
      return null;
  }
}
