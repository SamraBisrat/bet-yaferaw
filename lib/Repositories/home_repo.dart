import 'package:bet_yaferaw/Model/recipe.dart';
import 'package:bet_yaferaw/Service/http_calls.dart';

class HomeRepository {
  HttpCalls _httpCalls = HttpCalls();
  Future<List<RecipeData>> searchRecipe(List ingredients) =>
      _httpCalls.searchRecipe(ingredients);

  Future<List<RecipeData>> exploreRecipe() => _httpCalls.getExploreRecipe();
}
