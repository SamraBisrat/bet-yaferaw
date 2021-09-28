import 'dart:io';

import 'package:bet_yaferaw/Model/recipe.dart';
import 'package:equatable/equatable.dart';

abstract class AddRecipeEvent extends Equatable {
  const AddRecipeEvent();
}

class AddRecipeButtonPressed extends AddRecipeEvent {
  const AddRecipeButtonPressed({this.recipeData, this.image});

  final RecipeData recipeData;
  final File image;

  @override
  List<Object> get props => [recipeData, image];
}
