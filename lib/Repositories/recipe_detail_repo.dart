import 'package:bet_yaferaw/Model/recipe.dart';
import 'package:bet_yaferaw/Model/user.dart';
import 'package:bet_yaferaw/Service/http_calls.dart';

class RecipeDetailRepository {
  HttpCalls _httpCalls = HttpCalls();
  Future<RecipeData> getRecipeData(String id) => _httpCalls.getRecipeById(id);
//UPDATE RECIPE
  Future<int> updateRecipe(List liked, String id) =>
      _httpCalls.updateRecipe(liked, id);
//SAVE RECIPE

  Future<int> updateUser(UserData userData) => _httpCalls.updateUser(userData);
  Future<int> deleteRecipe(String id) => _httpCalls.deleteRecipe(id);
}
