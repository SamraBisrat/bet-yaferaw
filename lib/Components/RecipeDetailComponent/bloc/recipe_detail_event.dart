import 'package:bet_yaferaw/Model/recipe.dart';
import 'package:bet_yaferaw/Model/user.dart';
import 'package:equatable/equatable.dart';

abstract class RecipeDetailEvents extends Equatable {
  const RecipeDetailEvents();
}

class InitializeRecipeDetail extends RecipeDetailEvents {
  final String id;
  InitializeRecipeDetail(this.id);

  @override
  List<Object> get props => [id];
}

class UpdateRecipeDetail extends RecipeDetailEvents {
  final String id;
  final List liked;
  final bool liking;
  UpdateRecipeDetail(this.liked, this.id, this.liking);

  @override
  List<Object> get props => [liked, id, liking];
}

class DoneButtonPressed extends RecipeDetailEvents {
  DoneButtonPressed();

  @override
  List<Object> get props => [];
}

class SaveRecipeDetail extends RecipeDetailEvents {
  final UserData userData;
  SaveRecipeDetail({this.userData});

  @override
  List<Object> get props => [userData];
}

class DeleteRecipeDetail extends RecipeDetailEvents {
  final String id;
  DeleteRecipeDetail(this.id);

  @override
  List<Object> get props => [id];
}
