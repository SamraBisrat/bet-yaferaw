import 'dart:async';

import 'package:bet_yaferaw/Components/RecipeDetailComponent/recipe_detail.dart';
import 'package:bet_yaferaw/ReusableComponents/bottom_navigation.dart';
import 'package:bet_yaferaw/ReusableComponents/recipe_short_description.dart';
import 'package:bet_yaferaw/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class SearchResult extends StatefulWidget {
  @override
  _SearchResultState createState() => _SearchResultState();
}

class _SearchResultState extends State<SearchResult> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

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
                      "Found {1} recipes matching the ingredients you have...",
                      style: TextStyle(
                          color: Color(0xff9586A8),
                          fontSize: 17,
                          fontWeight: FontWeight.w400),
                      textAlign: TextAlign.left,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).pop();
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => RecipeDetail()));
                      },
                      child: CustomScrollView(
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
                                children: [
                                  RecipeShortDescription(
                                      image: "assets/images/sample_food.jpeg",
                                      recipeName: "Spaghetti  Shrimp Sauce",
                                      liked: false,
                                      likes: 20,
                                      cookTime: "20",
                                      serving: 2),
                                ],
                              ),
                            ),
                          ]),
                    ),
                  ],
                )
                //   ],
                // ),
                // ),
                // )
                )));
  }
}
