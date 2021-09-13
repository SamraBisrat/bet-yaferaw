import 'package:equatable/equatable.dart';

abstract class HomeEvents extends Equatable {
  const HomeEvents();
}

class InitializeExplore extends HomeEvents {
  InitializeExplore();

  @override
  List<Object> get props => [];
}

class SearchButtonPressed extends HomeEvents {
  final List ingredients;
  SearchButtonPressed(this.ingredients);

  @override
  List<Object> get props => [ingredients];
}

