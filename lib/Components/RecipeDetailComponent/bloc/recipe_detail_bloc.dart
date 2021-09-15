import 'dart:convert';

import 'package:bet_yaferaw/Components/ProfileComponent/bloc/profile_event.dart';
import 'package:bet_yaferaw/Components/RecipeDetailComponent/bloc/recipe_detail_event.dart';
import 'package:bet_yaferaw/Components/RecipeDetailComponent/bloc/recipe_detail_state.dart';
import 'package:bet_yaferaw/Model/recipe.dart';
import 'package:bet_yaferaw/Model/user.dart';
import 'package:bet_yaferaw/Repositories/recipe_detail_repo.dart';
import 'package:bet_yaferaw/Service/shared_pref.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RecipeDetailBloc extends Bloc<RecipeDetailEvents, RecipeDetailState> {
  RecipeDetailRepository recipeDetailRepository = RecipeDetailRepository();

  RecipeDetailBloc(String id) : super(RecipeDetailState(isLoading: true)) {
    add(InitializeRecipeDetail(id));
  }

  @override
  Stream<RecipeDetailState> mapEventToState(RecipeDetailEvents event) async* {
    // String userData = await SharedPref.getMyData("userData");
    // UserData decodedData = UserData.fromJson(jsonDecode(userData));
    RecipeData recipeDataResponse;
    // print(decodedData);
    if (event is InitializeRecipeDetail) {
      recipeDataResponse = await recipeDetailRepository.getRecipeData(event.id);

      yield state.copyWith(
        isLoading: false,
        recipeData: recipeDataResponse,
      );
    } else {
      yield state.copyWith(
          isLoading: false, recipeData: null, exceptionError: null);
    }
  }
}
