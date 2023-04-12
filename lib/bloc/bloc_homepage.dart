import 'dart:async';

import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

import '../utils/remote_config.dart';
import 'bloc_base.dart';

class BlocHomePage extends BlocBase {
  BlocHomePage() : remoteConfigUtils = RemoteConfigUtils();

  RemoteConfigUtils remoteConfigUtils;

  static LayoutType currentType = LayoutType.web;

  late ItemScrollController itemScrollController;
  int currentPage = 0;

  final StreamController<int> _pageStreamController =
      StreamController.broadcast();

  Stream<int> get pageStream => _pageStreamController.stream;

  bool isShadow = false;
  final StreamController<bool> _appBarShadowController =
      StreamController.broadcast();

  Stream<bool> get appBarShadowStream => _appBarShadowController.stream;

  void updateLayoutType(double screenWidth) {
    if (screenWidth > 950) {
      currentType = LayoutType.web;
      return;
    }

    if (screenWidth > 600) {
      currentType = LayoutType.tablet;
      return;
    }

    currentType = LayoutType.phone;
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
          index: index, duration: const Duration(milliseconds: 300));
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
  web,
  tablet,
  phone,
}
