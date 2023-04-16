import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../enum/layout_type.dart';
import '../../../enum/remote_config.dart';
import '../../../model/contact_model.dart';
import '../../../model/experience_model.dart';
import '../../../repository/remote_config.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit(this._remoteConfig)
      : myName = _remoteConfig.getValueString(RemoteConfigEnum.myNameText.key),
        followMeText =
            _remoteConfig.getValueString(RemoteConfigEnum.followMeText.key),
        contacts = contactModelFromJson(
            _remoteConfig.getValueString(RemoteConfigEnum.followMe.key)),
        experiences = experienceModelFromJson(
            _remoteConfig.getValueString(RemoteConfigEnum.experience.key)),
        expTitle = _remoteConfig
            .getValueString(RemoteConfigEnum.workExperienceText.key),
        nameTitle =
            _remoteConfig.getValueString(RemoteConfigEnum.nameTitleText.key),
        introductionTitle = _remoteConfig
            .getValueString(RemoteConfigEnum.myselfIntroductionText.key),
        downloadCvTitle =
            _remoteConfig.getValueString(RemoteConfigEnum.downloadCvText.key),
        super(HomeInitial());

  final RemoteConfigRepository _remoteConfig;
  final String myName;
  final String followMeText;
  final List<ContactModel> contacts;
  final String expTitle;
  final List<ExperienceModel> experiences;
  final String nameTitle;
  final String introductionTitle;
  final String downloadCvTitle;

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

  void _updateShadow(int index) {
    final bool isFirstSection = index == 0;
    if (isFirstSection && isShadow) {
      isShadow = false;
    } else if (!isFirstSection && !isShadow) {
      isShadow = true;
    }
  }

  void changePageIndex(int index, {bool isScroll = true}) {
    if (index != currentSection) {
      currentSection = index;
      _updateShadow(index);
      emit(HomeUpdateCurrentSection(
        index: index,
        isScroll: isScroll,
        hasShadow: isShadow,
      ));
    }
  }

  String getRemoteConfigString(RemoteConfigEnum remoteConfigEnum) =>
      _remoteConfig.getValueString(remoteConfigEnum.key);
}
