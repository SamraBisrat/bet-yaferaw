import 'package:bet_yaferaw/Model/recipe.dart';
import 'package:bet_yaferaw/Model/user.dart';
import 'package:equatable/equatable.dart';

class ProfileState extends Equatable {
  const ProfileState(
      {this.userData,
      this.exceptionError,
      this.isLoading,
      this.myRecipes,
      this.mySavedRecipes});

  final bool isLoading;
  final String exceptionError;
  final UserData userData;
  final List<RecipeData> myRecipes;
  final List<RecipeData> mySavedRecipes;
  @override
  List<Object> get props =>
      [isLoading, exceptionError, userData, myRecipes, mySavedRecipes];

  ProfileState copyWith(
      {bool isLoading,
      String exceptionError,
      UserData userData,
      List<RecipeData> myRecipes,
      List<RecipeData> mySavedRecipes}) {
    return ProfileState(
        isLoading: isLoading ?? this.isLoading,
        exceptionError: exceptionError ?? this.exceptionError,
        userData: userData ?? this.userData,
        myRecipes: myRecipes ?? this.myRecipes,
        mySavedRecipes: mySavedRecipes ?? this.mySavedRecipes);
  }
}
