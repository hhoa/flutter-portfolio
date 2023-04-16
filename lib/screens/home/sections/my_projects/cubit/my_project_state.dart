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

class MyProjectUpdateDotAnimation extends MyProjectState {
  MyProjectUpdateDotAnimation({
    required this.offset,
    required this.currentPage,
    required this.nextPage,
    required this.length,
    this.isSwipeRight = true,
  });

  final double offset;
  final int currentPage;
  final int nextPage;
  final bool isSwipeRight;
  final int length;

  @override
  List<Object> get props => [
        offset,
        currentPage,
        nextPage,
        isSwipeRight,
        length,
      ];
}
