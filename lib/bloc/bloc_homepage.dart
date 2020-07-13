import 'package:flutter_app_web/bloc/bloc_base.dart';

class BlocHomePage extends BlocBase {
  static LayoutType currentType = LayoutType.Web;

  void updateLayoutType(double screenWidth) {
    if (screenWidth > 950) {
      currentType = LayoutType.Web;
      return;
    }

    if (screenWidth > 600) {
      currentType = LayoutType.Tablet;
      return;
    }

    currentType = LayoutType.Phone;
  }

  @override
  void dispose() {
  }

}

enum LayoutType {
  Web,
  Tablet,
  Phone,
}