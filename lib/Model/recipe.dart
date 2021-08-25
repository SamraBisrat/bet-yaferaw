import 'dart:convert';

List<RecipeData> recipeDataFromJson(String str) =>
    List<RecipeData>.from(json.decode(str).map((x) => RecipeData.fromJson(x)));

String recipeDataToJson(List<RecipeData> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class RecipeData {
  RecipeData(
      {this.id,
      this.categories,
      this.recipename,
      this.directions,
      this.ingredients,
      this.serves,
      this.cookingtime});

  String id;
  List categories;
  String recipename;
  String directions;
  List ingredients;
  int serves;
  String cookingtime;

  factory RecipeData.fromJson(Map<String, dynamic> json) => RecipeData(
      id: json["id"],
      categories: json["categories"],
      recipename: json["recipename"],
      directions: json["directions"],
      ingredients: json["ingredients"],
      serves: json["serves"],
      cookingtime: json["cookingtime"]);

  Map<String, dynamic> toJson() => {
        "categories": categories,
        "recipename": recipename,
        "directions": directions,
        "ingredients": ingredients,
        "serves": serves,
        "cookingtime": cookingtime
      };
}
