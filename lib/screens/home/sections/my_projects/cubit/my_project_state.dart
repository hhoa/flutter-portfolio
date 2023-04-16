part of 'my_project_cubit.dart';

abstract class MyProjectState extends Equatable {
  @override
  List<Object> get props => [];
}

class MyProjectInitial extends MyProjectState {}

class MyProjectInFocus extends MyProjectState {
  MyProjectInFocus({required this.isFocus, required this.image});

  final bool isFocus;
  final String image;

  @override
  List<Object> get props => [isFocus, image];
}

class MyProjectUpdateCurrentPage extends MyProjectState {
  MyProjectUpdateCurrentPage({required this.currentPage});

  final int currentPage;

  @override
  List<Object> get props => [currentPage];
}
