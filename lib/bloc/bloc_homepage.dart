import 'dart:async';

import 'package:flutter_app_web/bloc/bloc_base.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class BlocHomePage extends BlocBase {
  static LayoutType currentType = LayoutType.Web;

  late ItemScrollController itemScrollController;
  int currentPage = 0;

  StreamController<int> _pageStreamController = StreamController.broadcast();
  Stream<int> get pageStream => _pageStreamController.stream;

  bool isShadow = false;
  StreamController<bool> _appBarShadowController = StreamController.broadcast();
  Stream<bool> get appBarShadowStream => _appBarShadowController.stream;

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

  void updateShadow(int index) {
    bool isContainZero = index == 0;
    if (isContainZero && isShadow) {
      isShadow = false;
      _appBarShadowController.add(isShadow);
    } else if (!isContainZero && !isShadow) {
      isShadow = true;
      _appBarShadowController.add(isShadow);
    }
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
    _appBarShadowController.close();
  }
}

enum LayoutType {
  Web,
  Tablet,
  Phone,
}
