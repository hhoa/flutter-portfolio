part of 'my_app_bar_cubit.dart';

abstract class MyAppBarState extends Equatable {
  @override
  List<Object> get props => [];
}

class MyAppBarInitial extends MyAppBarState {}

class MyAppBarHover extends MyAppBarState {
  MyAppBarHover({required this.isHover});

  final bool isHover;

  @override
  List<Object> get props => [isHover];
}
