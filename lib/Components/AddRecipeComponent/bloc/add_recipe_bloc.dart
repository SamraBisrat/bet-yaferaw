import 'package:bet_yaferaw/Components/AddRecipeComponent/bloc/add_recipe_event.dart';
import 'package:bet_yaferaw/Components/AddRecipeComponent/bloc/add_recipe_state.dart';
import 'package:bet_yaferaw/Repositories/add_recipe_repo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddRecipeBloc extends Bloc<AddRecipeEvent, AddRecipeState> {
  AddRecipeRepositories addRecipeRepositories = AddRecipeRepositories();

  AddRecipeBloc({@required this.addRecipeRepositories})
      : super(AddRecipeState(isLoading: false));

  // LoginState get initialState => LoginState(isLoading: false);

  @override
  Stream<AddRecipeState> mapEventToState(AddRecipeEvent event) async* {
    if (event is AddRecipeButtonPressed) {
      yield state.copyWith(isLoading: true, recipeData: event.recipeData);

      String response =
          await addRecipeRepositories.createRecipe(event.recipeData);
      print(response);

      if (response != null) {
        print(response);
        yield state.copyWith(isLoading: false, recipeData: event.recipeData);
      } else {
        yield state.copyWith(
            isLoading: false, exceptionError: "unable to signup");
      }
    }
  }
}
