import 'package:equatable/equatable.dart';

abstract class SearchEvents extends Equatable {
  const SearchEvents();
}

class InitializeSearchResults extends SearchEvents {
  final List ingredients;
  InitializeSearchResults(this.ingredients);

  @override
  List<Object> get props => [ingredients];
}
