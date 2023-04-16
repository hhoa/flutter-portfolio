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
    this.hasShadow = false,
  });

  final int index;
  final bool isScroll;
  final bool hasShadow;

  @override
  List<Object> get props => [
        index,
        isScroll,
        hasShadow,
      ];
}
