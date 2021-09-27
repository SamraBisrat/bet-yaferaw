import 'dart:io';

import 'package:bet_yaferaw/Model/recipe.dart';
import 'package:bet_yaferaw/Service/http_calls.dart';

class ScannerRepo {
  HttpCalls _httpCalls = HttpCalls();
  Future<List<RecipeData>> getSearchResult(List ingredients) =>
      _httpCalls.searchRecipe(ingredients);
  Future<List<dynamic>> getScannedIngredients(File image) =>
      _httpCalls.scannedIngregients(image);
}
