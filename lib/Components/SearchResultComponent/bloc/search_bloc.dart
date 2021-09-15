import 'package:bet_yaferaw/Components/SearchResultComponent/bloc/search_event.dart';
import 'package:bet_yaferaw/Components/SearchResultComponent/bloc/search_state.dart';
import 'package:bet_yaferaw/Model/recipe.dart';
import 'package:bet_yaferaw/Repositories/search_repo.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchBloc extends Bloc<SearchEvents, SearchState> {
  SearchResultRepositories searchResultRepositories =
      SearchResultRepositories();

  SearchBloc(List ingredients) : super(SearchState(isLoading: true)) {
    add(InitializeSearchResults(ingredients));
  }

  @override
  Stream<SearchState> mapEventToState(SearchEvents event) async* {
    // String userData = await SharedPref.getMyData("userData");
    // UserData decodedData = UserData.fromJson(jsonDecode(userData));
    if (event is InitializeSearchResults) {
      yield state.copyWith(isLoading: true);

      List<RecipeData> searchedRecipeResponse =
          await searchResultRepositories.getSearchResult(event.ingredients);

      if (searchedRecipeResponse != null) {
        print(searchedRecipeResponse);
        yield state.copyWith(
            isLoading: false, recipeData: searchedRecipeResponse);
      } else {
        yield state.copyWith(
            isLoading: false,
            recipeData: searchedRecipeResponse,
            exceptionError: "unable to load");
      }
    } else {
      yield state.copyWith(isLoading: false);
    }
  }
}
