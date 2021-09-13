import 'package:bet_yaferaw/Model/recipe.dart';
import 'package:bet_yaferaw/Model/user.dart';
import 'package:bet_yaferaw/Service/http_calls.dart';

class ProfileRepository {
  HttpCalls _httpCalls = HttpCalls();

  Future<UserData> getAccount() => _httpCalls.getMyAccount();

  Future<List<RecipeData>> getMyRecipes() => _httpCalls.getMyRecipes();

  Future<List<RecipeData>> getMySavedRecipes() =>
      _httpCalls.getMySavedRecipes();
}
