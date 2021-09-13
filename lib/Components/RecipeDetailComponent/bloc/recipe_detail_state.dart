import 'package:bet_yaferaw/Model/recipe.dart';
import 'package:bet_yaferaw/Model/user.dart';
import 'package:equatable/equatable.dart';

class RecipeDetailState extends Equatable {
  const RecipeDetailState({
    this.userData,
    this.exceptionError,
    this.isLoading,
    this.recipeData,
  });

  final bool isLoading;
  final String exceptionError;
  final UserData userData;
  final RecipeData recipeData;
  @override
  List<Object> get props => [isLoading, exceptionError, userData, recipeData];

  RecipeDetailState copyWith(
      {bool isLoading,
      String exceptionError,
      UserData userData,
      RecipeData recipeData}) {
    return RecipeDetailState(
        isLoading: isLoading ?? this.isLoading,
        exceptionError: exceptionError ?? this.exceptionError,
        userData: userData ?? this.userData,
        recipeData: recipeData ?? this.recipeData);
  }
}
