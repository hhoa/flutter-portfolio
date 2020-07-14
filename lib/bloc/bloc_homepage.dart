import 'dart:async';

import 'package:flutter_app_web/bloc/bloc_base.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class BlocHomePage extends BlocBase {
  static LayoutType currentType = LayoutType.Web;

  ItemScrollController itemScrollController;
  int currentPage = 0;

  StreamController<int> _pageStreamController = StreamController.broadcast();
  Stream<int> get pageStream => _pageStreamController.stream;

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

  void changePageIndex(int index, {bool isScroll = true}) {
    currentPage = index;
    if (isScroll) {
      itemScrollController.scrollTo(
          index: index, duration: Duration(milliseconds: 300));
    }
    _pageStreamController.add(currentPage);
  }

  @override
  void dispose() {
    _pageStreamController.close();
  }
}

enum LayoutType {
  Web,
  Tablet,
  Phone,
}
