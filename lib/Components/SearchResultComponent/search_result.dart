import 'dart:async';
import 'package:bet_yaferaw/Components/RecipeDetailComponent/recipe_detail.dart';
import 'package:bet_yaferaw/Components/SearchResultComponent/bloc/search_bloc.dart';
import 'package:bet_yaferaw/Components/SearchResultComponent/bloc/search_state.dart';
import 'package:bet_yaferaw/ReusableComponents/bottom_navigation.dart';
import 'package:bet_yaferaw/ReusableComponents/recipe_short_description.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchResult extends StatefulWidget {
  final List ingredients;
  SearchResult(this.ingredients, {Key key}) : super(key: key);

  @override
  _SearchResultState createState() => _SearchResultState();
}

class _SearchResultState extends State<SearchResult> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: BlocProvider(
              create: (context) => SearchBloc(widget.ingredients),
              child: BlocConsumer<SearchBloc, SearchState>(
                  builder: buildForState,
                  listener: (blocContext, blocState) {}))),
    );
  }

  Widget buildForState(blocContext, SearchState blocState) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    if (blocState.isLoading) {
      return Center(child: CircularProgressIndicator());
    }
    return Scaffold(
        resizeToAvoidBottomInset: false,
        extendBody: true,
        bottomNavigationBar: YRBottomNavigation(),
        body: SingleChildScrollView(
            child: Container(
                width: width,
                margin: MediaQuery.of(context).padding,
                color: Color(0xffF6F5F5),
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                // child: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      "Found ${blocState.recipeData == null ? '0' : blocState.recipeData.length} recipes matching the ingredients you have",
                      style: TextStyle(
                          color: Color(0xff9586A8),
                          fontSize: 17,
                          fontWeight: FontWeight.w400),
                      textAlign: TextAlign.left,
                    ),
                    CustomScrollView(
                        physics: ScrollPhysics(),
                        shrinkWrap: true,
                        slivers: <Widget>[
                          SliverPadding(
                            padding: const EdgeInsets.only(
                                bottom: 80.0, left: 0, right: 0, top: 5),

                            // padding:
                            //     EdgeInsets.symmetric(vertical: 2, horizontal: 0),
                            sliver: SliverGrid.count(
                                childAspectRatio: 0.7,
                                crossAxisCount: 2,
                                mainAxisSpacing: 5,
                                crossAxisSpacing: 5,
                                children: blocState.recipeData.map((e) {
                                  return GestureDetector(
                                      child: RecipeShortDescription(
                                          image:
                                              "assets/images/sample_food.jpeg",
                                          recipeName: e.recipename,
                                          liked: false,
                                          likes: e.usersliked == null
                                              ? 0
                                              : e.usersliked.length,
                                          cookTime: e.cookingtime,
                                          serving: e.serves),
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    RecipeDetail(e.id)));
                                      });
                                }).toList()),
                          ),
                        ]),
                  ],
                ))));
  }
}
