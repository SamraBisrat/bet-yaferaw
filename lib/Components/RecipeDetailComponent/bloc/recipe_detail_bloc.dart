import 'dart:convert';

import 'package:bet_yaferaw/Components/ProfileComponent/bloc/profile_event.dart';
import 'package:bet_yaferaw/Components/RecipeDetailComponent/bloc/recipe_detail_event.dart';
import 'package:bet_yaferaw/Components/RecipeDetailComponent/bloc/recipe_detail_state.dart';
import 'package:bet_yaferaw/Model/recipe.dart';
import 'package:bet_yaferaw/Model/user.dart';
import 'package:bet_yaferaw/Repositories/home_repo.dart';
import 'package:bet_yaferaw/Repositories/recipe_detail_repo.dart';
import 'package:bet_yaferaw/Service/shared_pref.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RecipeDetailBloc extends Bloc<RecipeDetailEvents, RecipeDetailState> {
  RecipeDetailRepository recipeDetailRepository = RecipeDetailRepository();
  HomeRepository homeRepository = HomeRepository();

  RecipeDetailBloc(String id) : super(RecipeDetailState(isLoading: true)) {
    add(InitializeRecipeDetail(id));
  }

  @override
  Stream<RecipeDetailState> mapEventToState(RecipeDetailEvents event) async* {
    // String userData = await SharedPref.getMyData("userData");
    // UserData decodedData = UserData.fromJson(jsonDecode(userData));
    RecipeData recipeDataResponse;
    int updateResponse;
    var exploreResponse;
    var user;

    if (event is InitializeRecipeDetail) {
      await SharedPref.getMyData("userData").then((value) {
        if (!(value == "")) {
          Map<String, dynamic> userData = jsonDecode(value);
          user = UserData.fromJson(userData);
          // print(user["firstname"]);
          print("inside bottom nav repo");
          return user;
        } else {
          user = null;
        }
      }).catchError((onError) {
        user = null;
      });
      recipeDataResponse = await recipeDetailRepository.getRecipeData(event.id);
      yield state.copyWith(
          isLoading: false, recipeData: recipeDataResponse, userData: user);
    } else if (event is UpdateRecipeDetail) {
      yield state.copyWith(isLoading: true);
      updateResponse =
          await recipeDetailRepository.updateRecipe(event.liked, event.id);
      print("update recipe error");
      print(updateResponse);
      if (updateResponse == 200) {
        recipeDataResponse =
            await recipeDetailRepository.getRecipeData(event.id);

        yield state.copyWith(
          isLoading: false,
          userData: user,
          recipeData: recipeDataResponse,
        );
      } else {
        yield state.copyWith(
          isLoading: false,
          recipeData: recipeDataResponse,
          exceptionError: null,
          userData: user,
        );
      }
    } else if (event is DoneButtonPressed) {
      yield state.copyWith(isLoading: true);

      exploreResponse = homeRepository.exploreRecipe();
      if (exploreResponse != null) {
        yield state.copyWith(done: true, isLoading: true);
      } else {
        yield state.copyWith(done: false, isLoading: false);
      }
    } else if (event is SaveRecipeDetail) {
      yield state.copyWith(isLoading: true);

      var savedResponse =
          await recipeDetailRepository.updateUser(event.userData);

      if (savedResponse == 200) {
        await SharedPref.getMyData("userData").then((value) {
          if (!(value == "")) {
            Map<String, dynamic> userData = jsonDecode(value);
            user = UserData.fromJson(userData);
            // print(user["firstname"]);
            print("inside bottom nav repo");
            return user;
          } else {
            user = null;
          }
        }).catchError((onError) {
          user = null;
        });

        yield state.copyWith(
            userData: user, isLoading: false, recipeData: recipeDataResponse);
      }
    } else if (event is DeleteRecipeDetail) {
      yield state.copyWith(isLoading: true);
      var deleteResponse = await recipeDetailRepository.deleteRecipe(event.id);
      if (deleteResponse == 200) {
        await SharedPref.getMyData("userData").then((value) {
          if (!(value == "")) {
            Map<String, dynamic> userData = jsonDecode(value);
            user = UserData.fromJson(userData);
            // print(user["firstname"]);
            print("inside bottom nav repo");
            return user;
          } else {
            user = null;
          }
        }).catchError((onError) {
          user = null;
        });
        yield state.copyWith(isLoading: false, userData: user, deleted: true);
      } else {
        yield state.copyWith(isLoading: false, deleted: false);
      }
    } else {
      yield state.copyWith(
          isLoading: false,
          recipeData: null,
          exceptionError: null,
          userData: user);
    }
  }
}
