import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../enum/layout_type.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());

  LayoutType currentType = LayoutType.web;
  int currentSection = 0;
  bool isShadow = false;

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
    if (isFirstSection && isShadow) {
      isShadow = false;
      emit(HomeUpdateShadow(isShadow: isShadow));
    } else if (!isFirstSection && !isShadow) {
      isShadow = true;
      emit(HomeUpdateShadow(isShadow: isShadow));
    }
  }

  void changePageIndex(int index, {bool isScroll = true}) {
    if (index != currentSection) {
      currentSection = index;
      emit(HomeUpdateCurrentSection(index: index, isScroll: isScroll));
    }
  }
}
