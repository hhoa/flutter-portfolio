import 'package:flutter_app_web/enum/layout_type.dart';
import 'package:flutter_app_web/screens/home/cubit/home_cubit.dart';
import 'package:flutter_test/flutter_test.dart';

import '../mocks/remote_config_mock.dart';

void main() {
  group('test cubit', () {
    late HomeCubit homeCubit;

    setUp(() {
      homeCubit = HomeCubit(MockRemoteConfigRepository());
    });

    test('initial state is HomeInitial', () {
      expect(homeCubit.state, HomeInitial());
    });

    test('updateLayoutType', () {
      homeCubit.updateLayoutType(300);
      expect(homeCubit.currentType, LayoutType.phone);
      homeCubit.updateLayoutType(700);
      expect(homeCubit.currentType, LayoutType.tablet);
      homeCubit.updateLayoutType(1280);
      expect(homeCubit.currentType, LayoutType.web);
    });

    test('changePageIndex', () {
      homeCubit.changePageIndex(1);
      expect(
          homeCubit.state,
          HomeUpdateCurrentSection(
            index: 1,
            hasShadow: true,
            isScroll: true,
          ));

      homeCubit.changePageIndex(2, isScroll: false);
      expect(
          homeCubit.state,
          HomeUpdateCurrentSection(
            index: 2,
            hasShadow: true,
            isScroll: false,
          ));

      homeCubit.changePageIndex(0, isScroll: false);
      expect(
          homeCubit.state,
          HomeUpdateCurrentSection(
            index: 0,
            hasShadow: false,
            isScroll: false,
          ));
    });
  });
}
