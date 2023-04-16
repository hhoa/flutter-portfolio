import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../enum/remote_config.dart';
import '../../../../../model/project_model.dart';
import '../../../../../repository/remote_config.dart';

part 'my_project_state.dart';

class MyProjectCubit extends Cubit<MyProjectState> {
  MyProjectCubit(RemoteConfigRepository remoteConfigRepository)
      : recentProjectsTitle = remoteConfigRepository
            .getValueString(RemoteConfigEnum.recentProjectsText.key),
        moreInfoTitle = remoteConfigRepository
            .getValueString(RemoteConfigEnum.moreInfoText.key),
        projects = projectModelFromJson(remoteConfigRepository
            .getValueString(RemoteConfigEnum.project.key)),
        super(MyProjectInitial()) {
    currentPage = projects.length - 1;
  }

  final List<ProjectModel> projects;
  final String recentProjectsTitle;
  final String moreInfoTitle;
  int currentPage = 0;
  int currentFocus = -1;

  int _nextPage = 0;
  double _lastOffset = 0;
  bool _isSwipeRight = true;

  int get projectLength => projects.length;

  void updateFocus({required String image, required bool isFocus}) {
    final int index = projects.indexWhere((element) => element.image == image);
    if (index != -1) {
      currentFocus = index;
      emit(MyProjectInFocus(isFocus: isFocus, image: image));
    }
  }

  void handleScroll(double page) {
    if (page < 0) {
      return;
    }

    final cPage = currentPage;
    final double offsetPage = page % projectLength;
    if (offsetPage > _lastOffset) {
      _nextPage = offsetPage.ceil();
      currentPage = offsetPage.floor();
      _isSwipeRight = true;
    } else if (offsetPage < _lastOffset) {
      _nextPage = offsetPage.floor();
      currentPage = offsetPage.ceil();
      _isSwipeRight = false;
    } else {
      _nextPage = currentPage;
    }
    if (_nextPage >= projectLength) {
      _nextPage = 0;
    }
    if (currentPage >= projectLength) {
      currentPage = 0;
    }

    final double offsetOnePage = offsetPage - offsetPage.floor();
    emit(MyProjectUpdateDotAnimation(
      offset: offsetOnePage,
      currentPage: currentPage,
      nextPage: _nextPage,
      isSwipeRight: _isSwipeRight,
      length: projectLength,
    ));

    _lastOffset = offsetPage;
    if (cPage != currentPage) {
      emit(MyProjectUpdateCurrentPage(currentPage: currentPage));
    }
  }
}
