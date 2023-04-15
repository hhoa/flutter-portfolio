import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../enum/layout_type.dart';
import '../../../enum/remote_config.dart';
import '../../../repository/remote_config.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit(this._remoteConfig) : super(HomeInitial());

  final RemoteConfigRepository _remoteConfig;
  LayoutType currentType = LayoutType.web;
  int currentSection = 0;
  bool _isShadow = false;

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
    final bool isFirstSection = index == 0;
    if (isFirstSection && _isShadow) {
      _isShadow = false;
      emit(HomeUpdateShadow(isShadow: _isShadow));
    } else if (!isFirstSection && !_isShadow) {
      _isShadow = true;
      emit(HomeUpdateShadow(isShadow: _isShadow));
    }
  }

  void changePageIndex(int index, {bool isScroll = true}) {
    if (index != currentSection) {
      currentSection = index;
      emit(HomeUpdateCurrentSection(index: index, isScroll: isScroll));
    }
  }

  String getRemoteConfigString(RemoteConfigEnum remoteConfigEnum) =>
      _remoteConfig.getValueString(remoteConfigEnum.key);
}
