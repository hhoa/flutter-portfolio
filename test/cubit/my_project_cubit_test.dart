import 'package:flutter_app_web/screens/home/sections/my_projects/cubit/my_project_cubit.dart';
import 'package:flutter_test/flutter_test.dart';

import '../mocks/remote_config_mock.dart';

void main() {
  group('test cubit', () {
    late MyProjectCubit myProjectCubit;

    setUp(() {
      myProjectCubit = MyProjectCubit(MockRemoteConfigRepository());
    });

    test('initial state is MyProjectInitial', () {
      expect(myProjectCubit.state, MyProjectInitial());
    });

    test('updateFocus', () {
      const String wrongImage = 'abc.png';
      myProjectCubit.updateFocus(image: wrongImage, isFocus: true);
      expect(myProjectCubit.state, MyProjectInitial());
      const String image =
          'https://firebasestorage.googleapis.com/v0/b/flutter-portfolio-e116e.appspot.com/o/dailydeal_screen.jpeg?alt=media&token=08e5fcd3-d0a3-48a6-a6dc-2893b3459844';
      myProjectCubit.updateFocus(image: image, isFocus: true);
      expect(
          myProjectCubit.state, MyProjectInFocus(image: image, isFocus: true));
    });

    test('updateCurrentProject', () {
      myProjectCubit.handleScroll(-1);
      expect(myProjectCubit.state, MyProjectInitial());

      myProjectCubit.handleScroll(5);
      expect(myProjectCubit.state, MyProjectUpdateCurrentPage(currentPage: 5));

      myProjectCubit.handleScroll(5.2);
      expect(
          myProjectCubit.state,
          MyProjectUpdateDotAnimation(
            offset: 0.20000000000000018,
            currentPage: 5,
            nextPage: 6,
            isSwipeRight: true,
            length: 7,
          ));

      myProjectCubit.handleScroll(4.8);
      expect(
          myProjectCubit.state,
          MyProjectUpdateDotAnimation(
            offset: 0.7999999999999998,
            currentPage: 5,
            nextPage: 4,
            isSwipeRight: false,
            length: 7,
          ));

      myProjectCubit.handleScroll(6);
      expect(myProjectCubit.state, MyProjectUpdateCurrentPage(currentPage: 6));

      myProjectCubit.handleScroll(6.2);
      expect(
          myProjectCubit.state,
          MyProjectUpdateDotAnimation(
            offset: 0.20000000000000018,
            currentPage: 6,
            nextPage: 0,
            isSwipeRight: true,
            length: 7,
          ));
    });
  });
}
