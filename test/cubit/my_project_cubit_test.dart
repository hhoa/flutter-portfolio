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
      myProjectCubit.updateCurrentProject(myProjectCubit.projectLength - 1);
      expect(myProjectCubit.state, MyProjectInitial());

      myProjectCubit.updateCurrentProject(1);
      expect(myProjectCubit.state, MyProjectUpdateCurrentPage(currentPage: 1));
    });
  });
}
