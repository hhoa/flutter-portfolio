import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../enum/remote_config.dart';
import '../../../../../model/project_model.dart';
import '../../../../../repository/remote_config.dart';

part 'my_project_state.dart';

class MyProjectCubit extends Cubit<MyProjectState> {
  MyProjectCubit(this.remoteConfigRepository) : super(MyProjectInitial()) {
    projects = projectModelFromJson(
        remoteConfigRepository.getValueString(RemoteConfigEnum.project.key));
    currentPage = projectLength - 1;
  }

  final RemoteConfigRepository remoteConfigRepository;
  late final List<ProjectModel> projects;
  int currentPage = 0;
  int currentFocus = -1;

  int get projectLength => projects.length;

  String get recentProjectsTitle => remoteConfigRepository
      .getValueString(RemoteConfigEnum.recentProjectsText.key);

  void updateFocus({required String image, required bool isFocus}) {
    final int index = projects.indexWhere((element) => element.image == image);
    if (index != -1) {
      currentFocus = index;
      emit(MyProjectInFocus(isFocus: isFocus, image: image));
    }
  }

  int calculatePage(int index) {
    if (projectLength % 2 == 0) {
      return index % projectLength - 1;
    }
    return index % projectLength;
  }

  void updateCurrentPage(int index) {
    final int page = calculatePage(index);
    if (page != currentPage) {
      currentPage = page;
      emit(MyProjectUpdateCurrentPage(currentPage: currentPage));
    }
  }
}
