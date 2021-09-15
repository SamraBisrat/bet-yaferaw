import 'package:bet_yaferaw/Components/AddRecipeComponent/add_recipe.dart';
import 'package:bet_yaferaw/Model/recipe.dart';
import 'package:bet_yaferaw/Model/user.dart';
import 'package:equatable/equatable.dart';

class SearchState extends Equatable {
  const SearchState(
      {this.exceptionError, this.isLoading, this.recipeData, this.ingredients});

  final bool isLoading;
  final String exceptionError;
  final List<RecipeData> recipeData;
  final List<String> ingredients;
  @override
  List<Object> get props =>
      [isLoading, exceptionError, recipeData, ingredients];

  SearchState copyWith(
      {bool isLoading,
      String exceptionError,
      final List<RecipeData> recipeData,
      final List<String> ingredients}) {
    return SearchState(
        isLoading: isLoading ?? this.isLoading,
        exceptionError: exceptionError ?? this.exceptionError,
        recipeData: recipeData ?? this.recipeData,
        ingredients: ingredients ?? null);
  }
}
