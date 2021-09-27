import 'package:bet_yaferaw/Model/recipe.dart';
import 'package:equatable/equatable.dart';

class HomeState extends Equatable {
  const HomeState(
      {this.exceptionError,
      this.isLoading,
      this.searchedRecipe,
      this.exploredRecipe,
      this.ingredients,
      this.navToSearch});

  final bool isLoading;
  final String exceptionError;
  final List<RecipeData> searchedRecipe;
  final List<RecipeData> exploredRecipe;
  final List<String> ingredients;
  final bool navToSearch;

  @override
  List<Object> get props => [
        isLoading,
        exceptionError,
        searchedRecipe,
        exploredRecipe,
        ingredients,
        navToSearch
      ];

  HomeState copyWith(
      {bool isLoading,
      String exceptionError,
      List<RecipeData> searchedRecipe,
      List<RecipeData> exploredRecipe,
      List<String> ingredients,
      bool navToSearch}) {
    return HomeState(
        isLoading: isLoading ?? this.isLoading,
        exceptionError: exceptionError ?? this.exceptionError,
        searchedRecipe: searchedRecipe ?? this.searchedRecipe,
        exploredRecipe: exploredRecipe ?? this.exploredRecipe,
        ingredients: ingredients ?? this.ingredients,
        navToSearch: navToSearch ?? false);
  }
}
