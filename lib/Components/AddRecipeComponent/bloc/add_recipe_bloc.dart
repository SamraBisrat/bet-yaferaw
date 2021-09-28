import 'dart:convert';

import 'package:bet_yaferaw/Components/AddRecipeComponent/bloc/add_recipe_event.dart';
import 'package:bet_yaferaw/Components/AddRecipeComponent/bloc/add_recipe_state.dart';
import 'package:bet_yaferaw/Model/user.dart';
import 'package:bet_yaferaw/Repositories/add_recipe_repo.dart';
import 'package:bet_yaferaw/Service/shared_pref.dart';
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
      var user;
      yield state.copyWith(isLoading: true, recipeData: event.recipeData);
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
      String imageResponse =
          await addRecipeRepositories.uploadProfileImage(event.image);
      print(imageResponse);
      if (imageResponse.toString() != null) {
        event.recipeData.imageid = imageResponse;
        String response =
            await addRecipeRepositories.createRecipe(event.recipeData);
        print("response");
        print(event.recipeData.toJson());
        if (response != null) {
          print(response);
          yield state.copyWith(
              isLoading: false,
              recipeData: event.recipeData,
              image: imageResponse,
              created: true, 
              userData: user);
        } else {
          yield state.copyWith(
              isLoading: false, recipeData: null, created: false, image: null, userData: user);
        }
      } else {
        yield state.copyWith(
            isLoading: false, exceptionError: "unable to create recipe");
      }
    }
  }
}
