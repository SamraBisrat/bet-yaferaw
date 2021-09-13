import 'package:bet_yaferaw/Model/recipe.dart';
import 'package:bet_yaferaw/Model/user.dart';
import 'package:equatable/equatable.dart';

class HomeState extends Equatable {
  const HomeState(
      {this.exceptionError,
      this.isLoading,
      this.searchedRecipe,
      this.exploredRecipe});

  final bool isLoading;
  final String exceptionError;
  final List<RecipeData> searchedRecipe;
  final List<RecipeData> exploredRecipe;
  @override
  List<Object> get props =>
      [isLoading, exceptionError, searchedRecipe, exploredRecipe];

  HomeState copyWith(
      {bool isLoading,
      String exceptionError,
      List<RecipeData> searchedRecipe,
      List<RecipeData> exploredRecipe}) {
    return HomeState(
        isLoading: isLoading ?? this.isLoading,
        exceptionError: exceptionError ?? this.exceptionError,
        searchedRecipe: searchedRecipe ?? this.searchedRecipe,
        exploredRecipe: exploredRecipe ?? this.exploredRecipe);
  }
}
