import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../enum/remote_config.dart';
import '../../../../../repository/remote_config.dart';

part 'my_app_bar_state.dart';

class MyAppBarCubit extends Cubit<MyAppBarState> {
  MyAppBarCubit(RemoteConfigRepository remoteConfig)
      : titleAppBar = remoteConfig
            .getValueString(RemoteConfigEnum.listAppBarTitleText.key)
            .split(','),
        super(MyAppBarInitial());

  late final List<String> titleAppBar;

  void updateHover({required bool isHover}) {
    emit(MyAppBarHover(isHover: isHover));
  }
}
