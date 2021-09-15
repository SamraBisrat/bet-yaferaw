import 'package:bet_yaferaw/Components/ProfileComponent/bloc/profile_event.dart';
import 'package:bet_yaferaw/Components/ProfileComponent/bloc/profile_state.dart';
import 'package:bet_yaferaw/Model/recipe.dart';
import 'package:bet_yaferaw/Model/user.dart';
import 'package:bet_yaferaw/Repositories/login_repo.dart';
import 'package:bet_yaferaw/Repositories/profile_repo.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileBloc extends Bloc<ProfileEvents, ProfileState> {
  // UserRepository userRepository = UserRepository();
  ProfileRepository profileRepository = ProfileRepository();

  ProfileBloc({@required this.profileRepository})
      : super(ProfileState(isLoading: true)) {
    add(InitiliazeProfile());
  }

  @override
  Stream<ProfileState> mapEventToState(ProfileEvents event) async* {
    UserData response;
    List<RecipeData> myRecipeResponse;
    List<RecipeData> mySavedRecipeResponse;

    if (event is InitiliazeProfile) {
      yield state.copyWith(isLoading: true);

      response = await profileRepository.getAccount();
      myRecipeResponse = await profileRepository.getMyRecipes();
      mySavedRecipeResponse = await profileRepository.getMySavedRecipes();

      if (response != null) {
        yield state.copyWith(
            isLoading: false,
            userData: response,
            myRecipes: myRecipeResponse,
            mySavedRecipes: mySavedRecipeResponse);
      } else {
        yield state.copyWith(
            isLoading: false,
            userData: response,
            myRecipes: myRecipeResponse,
            mySavedRecipes: mySavedRecipeResponse,
            exceptionError: "Unable to get account");
      }

      print(
          "profile bloc user response is \n $response  my saved recipe response is \n $mySavedRecipeResponse my recipe response is \n $myRecipeResponse");
    } else if (event is CreatedRecipesPressed) {
      yield state.copyWith(isLoading: true);

      List<RecipeData> myRecipeResponse =
          await profileRepository.getMyRecipes();

      if (myRecipeResponse != null) {
        print(myRecipeResponse);
        yield state.copyWith(
            isLoading: false, myRecipes: myRecipeResponse, userData: response);
      } else {
        yield state.copyWith(
            isLoading: false,
            myRecipes: myRecipeResponse,
            exceptionError: "unable to load");
      }
    } else if (event is SavedRecipesPressed) {
      List<RecipeData> mySavedRecipeResponse =
          await profileRepository.getMySavedRecipes();

      if (mySavedRecipeResponse != null) {
        print(mySavedRecipeResponse);
        yield state.copyWith(
            isLoading: false,
            mySavedRecipes: mySavedRecipeResponse,
            userData: response);
      } else {
        yield state.copyWith(
            isLoading: false,
            mySavedRecipes: mySavedRecipeResponse,
            exceptionError: "Unable to get account");
      }
    }
  }
}
