import 'package:bet_yaferaw/Model/recipe.dart';
import 'package:bet_yaferaw/Service/http_calls.dart';

class RecipeDetailRepository {
  HttpCalls _httpCalls = HttpCalls();
  Future<RecipeData> getRecipeData(String id) => _httpCalls.getRecipeById(id);
//UPDATE RECIPE
//SAVE RECIPE
}
