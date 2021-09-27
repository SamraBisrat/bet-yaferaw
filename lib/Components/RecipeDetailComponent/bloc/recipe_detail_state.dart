import 'package:bet_yaferaw/Model/recipe.dart';
import 'package:bet_yaferaw/Model/user.dart';
import 'package:equatable/equatable.dart';

class RecipeDetailState extends Equatable {
  const RecipeDetailState(
      {this.userData,
      this.exceptionError,
      this.isLoading,
      this.recipeData,
      this.done,
      this.deleted});

  final bool isLoading;
  final String exceptionError;
  final UserData userData;
  final RecipeData recipeData;
  final bool done;
  final bool deleted;
  @override
  List<Object> get props =>
      [isLoading, exceptionError, userData, recipeData, done];

  RecipeDetailState copyWith(
      {bool isLoading,
      String exceptionError,
      UserData userData,
      RecipeData recipeData,
      bool done,
      bool deleted}) {
    return RecipeDetailState(
        isLoading: isLoading ?? this.isLoading,
        exceptionError: exceptionError ?? this.exceptionError,
        userData: userData ?? this.userData,
        recipeData: recipeData ?? this.recipeData,
        done: done ?? this.done,
        deleted: deleted ?? false);
  }
}
