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
  UpdateRecipeDetail();

  @override
  List<Object> get props => [];
}

class SaveRecipeDetail extends RecipeDetailEvents {
  SaveRecipeDetail();

  @override
  List<Object> get props => [];
}
