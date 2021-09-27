import 'dart:io';

import 'package:equatable/equatable.dart';

abstract class HomeEvents extends Equatable {
  const HomeEvents();
}

class InitializeExplore extends HomeEvents {
  InitializeExplore();

  @override
  List<Object> get props => [];
}

class ScanIngredients extends HomeEvents {
  ScanIngredients(this.image);
  final File image;
  @override
  List<Object> get props => [image];
}

// class ScannedResponse extends ScanEvents {
//   ScannedResponse(this.ingredients);
//   final List ingredients;
//   @override
//   List<Object> get props => [ingredients];
// }

