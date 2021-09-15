import 'package:bet_yaferaw/Model/recipe.dart';
import 'package:bet_yaferaw/Service/http_calls.dart';

class AddRecipeRepositories {
  HttpCalls _httpCalls = HttpCalls();
  Future<String> createRecipe(RecipeData recipeData) =>
      _httpCalls.createRecipe(recipeData);
}
