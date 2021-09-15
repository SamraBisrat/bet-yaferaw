import 'package:bet_yaferaw/Model/recipe.dart';
import 'package:equatable/equatable.dart';

class AddRecipeState extends Equatable {
  const AddRecipeState({this.recipeData, this.exceptionError, this.isLoading});
  final RecipeData recipeData;
  final bool isLoading;
  final String exceptionError;

  @override
  List<Object> get props => [recipeData, isLoading, exceptionError];

  AddRecipeState copyWith({
    RecipeData recipeData,
    String exceptionError,
    bool isLoading,
  }) {
    return AddRecipeState(
      recipeData: recipeData ?? this.recipeData,
      isLoading: isLoading ?? this.isLoading,
      exceptionError: exceptionError ?? this.exceptionError,
    );
  }
}
