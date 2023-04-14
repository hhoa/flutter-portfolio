part of 'home_cubit.dart';

abstract class HomeState extends Equatable {
  @override
  List<Object> get props => [];
}

class HomeInitial extends HomeState {}

class HomeUpdateCurrentSection extends HomeState {
  HomeUpdateCurrentSection({
    required this.index,
    this.isScroll = false,
  });

  final int index;
  final bool isScroll;

  @override
  List<Object> get props => [
        index,
        isScroll,
      ];
}

class HomeUpdateShadow extends HomeState {
  HomeUpdateShadow({
    required this.isShadow,
  });

  final bool isShadow;

  @override
  List<Object> get props => [isShadow];
}
