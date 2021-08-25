import 'package:bet_yaferaw/Model/recipe.dart';
import 'package:bet_yaferaw/Model/user.dart';
import 'package:flutter/material.dart';

class MasterProvider extends ChangeNotifier {
// setter and getter for user data

  String _token = "";
  String get getToken => _token;
  set setToken(String value) {
    _token = value;
    notifyListeners();
  }

  UserData _userData = UserData();
  UserData get getUserData => _userData;
  set setUserdata(UserData value) {
    _userData = value;
    notifyListeners();
  }

  // setter and getter for recipe data
  RecipeData _recipeData = RecipeData();
  RecipeData get getRecipeData => _recipeData;
  set setRecipeData(RecipeData value) {
    _recipeData = value;
    notifyListeners();
  }

  bool _liked = false;
  bool get getliked => _liked;
  set setliked(bool value) {
    _liked = value;
    notifyListeners();
  }

  bool _loading = false;
  bool get getLoading => _loading;
  set setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  void checkIfFavorite(bool liked) {
    if (liked == true) {
      setliked = false;
    } else {
      setliked = true;
    }
    notifyListeners();
  }
}
