import 'package:bet_yaferaw/Components/HomeComponent/bloc/home_event.dart';
import 'package:bet_yaferaw/Components/HomeComponent/bloc/home_state.dart';
import 'package:bet_yaferaw/Model/recipe.dart';
import 'package:bet_yaferaw/Repositories/home_repo.dart';
import 'package:bet_yaferaw/Service/shared_pref.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeBloc extends Bloc<HomeEvents, HomeState> {
  // UserRepository userRepository = UserRepository();
  HomeRepository homeRepository = HomeRepository();

  HomeBloc({@required this.homeRepository})
      : super(HomeState(isLoading: true)) {
    add(InitializeExplore());
  }

  @override
  Stream<HomeState> mapEventToState(HomeEvents event) async* {
    // var scannedResponse;
    // var searchResponse;
    if (event is InitializeExplore) {
      yield state.copyWith(isLoading: true);

      String userData = await SharedPref.getMyData("userData");
      print("user data from shared pref");
      print(userData);
      // UserData decodedData = UserData.fromJson(jsonDecode(userData));
      // print("decoded shared pref");
      // print(decodedData);
      List<RecipeData> exploredRecipeResponse =
          await homeRepository.exploreRecipe();

      if (exploredRecipeResponse != null) {
        yield state.copyWith(
            isLoading: false, exploredRecipe: exploredRecipeResponse);
      } else {
        yield state.copyWith(
            isLoading: false,
            exploredRecipe: null,
            exceptionError: "Unable to get recipe");
      }

      print("profile bloc user response is \n $exploredRecipeResponse");
    } else if (event is ScanIngredients) {
      List<String> ingredients = [];
      yield state.copyWith(isLoading: true);
      var scannedResponse =
          await homeRepository.getScannedIngredients(event.image);

      if (scannedResponse != null) {
        for (var scanned in scannedResponse) {
          for (var ingredient in scanned) {
            if (ingredient is String) {
              ingredients.add(ingredient);
            }
          }
        }
        print("string values");
        print(ingredients);
        yield state.copyWith(
            isLoading: false, ingredients: ingredients, navToSearch: true);
      } else {
        yield state.copyWith(
            isLoading: false,
            exceptionError: 'could not identify image, please scan again');
      }
    }
  }
}
