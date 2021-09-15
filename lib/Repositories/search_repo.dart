import 'package:bet_yaferaw/Model/recipe.dart';
import 'package:bet_yaferaw/Service/http_calls.dart';

class SearchResultRepositories {
  HttpCalls _httpCalls = HttpCalls();
  Future<List<RecipeData>> getSearchResult(List ingredients) =>
      _httpCalls.searchRecipe(ingredients);
}
