import 'package:bet_yaferaw/Model/recipe.dart';
import 'package:equatable/equatable.dart';

abstract class AddRecipeEvent extends Equatable {
  const AddRecipeEvent();
}

class AddRecipeButtonPressed extends AddRecipeEvent {
  const AddRecipeButtonPressed({this.recipeData});

  final RecipeData recipeData;

  @override
  List<Object> get props => [recipeData];
}
