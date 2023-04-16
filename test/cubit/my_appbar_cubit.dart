import 'package:flutter_app_web/screens/home/sections/my_appbar/cubit/my_app_bar_cubit.dart';
import 'package:flutter_test/flutter_test.dart';

import '../mocks/remote_config_mock.dart';

void main() {
  group('test cubit', () {
    late MyAppBarCubit myAppBarCubit;

    setUp(() {
      myAppBarCubit = MyAppBarCubit(MockRemoteConfigRepository());
    });

    test('initial state is MyAppBarInitial', () {
      expect(myAppBarCubit.state, MyAppBarInitial());
    });

    test('updateHover', () {
      myAppBarCubit.updateHover(isHover: true);
      expect(myAppBarCubit.state, MyAppBarHover(isHover: true));

      myAppBarCubit.updateHover(isHover: false);
      expect(myAppBarCubit.state, MyAppBarHover(isHover: false));
    });
  });
}
