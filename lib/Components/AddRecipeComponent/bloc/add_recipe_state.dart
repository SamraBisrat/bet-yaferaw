import 'dart:io';

import 'package:bet_yaferaw/Model/recipe.dart';
import 'package:bet_yaferaw/Model/user.dart';
import 'package:equatable/equatable.dart';

class AddRecipeState extends Equatable {
  const AddRecipeState(
      {this.recipeData,
      this.exceptionError,
      this.isLoading,
      this.image,
      this.userData,
      this.imageFile,
      this.created});
  final RecipeData recipeData;
  final bool isLoading;
  final String exceptionError;
  final String image;
  final File imageFile;
  final bool created;
  final UserData userData;

  @override
  List<Object> get props => [
        recipeData,
        isLoading,
        exceptionError,
        image,
        imageFile,
        created,
        userData
      ];

  AddRecipeState copyWith(
      {RecipeData recipeData,
      String exceptionError,
      bool isLoading,
      String image,
      File imageFile,
      bool created,
      UserData userData}) {
    return AddRecipeState(
        recipeData: recipeData ?? this.recipeData,
        isLoading: isLoading ?? this.isLoading,
        exceptionError: exceptionError ?? this.exceptionError,
        image: image ?? this.image,
        imageFile: imageFile ?? this.imageFile,
        created: created ?? this.created,
        userData: userData ?? this.userData);
  }
}
