import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../enum/remote_config.dart';
import '../../../../../repository/remote_config.dart';

part 'my_app_bar_state.dart';

class MyAppBarCubit extends Cubit<MyAppBarState> {
  MyAppBarCubit(this._remoteConfig) : super(MyAppBarInitial());

  final RemoteConfigRepository _remoteConfig;

  List<String> get titleAppBar => _remoteConfig
      .getValueString(RemoteConfigEnum.listAppBarTitleText.key)
      .split(',');

  String get myName =>
      _remoteConfig.getValueString(RemoteConfigEnum.myNameText.key);

  void updateHover({required bool isHover}) {
    emit(MyAppBarHover(isHover: isHover));
  }
}
