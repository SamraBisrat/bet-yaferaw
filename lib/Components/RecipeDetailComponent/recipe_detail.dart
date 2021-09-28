import 'dart:ui';
import 'package:bet_yaferaw/Components/HomeComponent/home.dart';
import 'package:bet_yaferaw/Components/RecipeDetailComponent/bloc/recipe_detail_bloc.dart';
import 'package:bet_yaferaw/Components/RecipeDetailComponent/bloc/recipe_detail_event.dart';
import 'package:bet_yaferaw/Components/RecipeDetailComponent/bloc/recipe_detail_state.dart';
import 'package:bet_yaferaw/Model/user.dart';
import 'package:bet_yaferaw/ReusableComponents/snack_bar.dart';
import 'package:bet_yaferaw/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
//import 'package:provider/provider.dart';

class RecipeDetail extends StatefulWidget {
  final String id;
  RecipeDetail(this.id, {Key key}) : super(key: key);

  @override
  _RecipeDetailState createState() => _RecipeDetailState();
}

class _RecipeDetailState extends State<RecipeDetail> {
  bool done;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: BlocProvider(
              create: (context) => RecipeDetailBloc(widget.id),
              child: BlocConsumer<RecipeDetailBloc, RecipeDetailState>(
                  builder: buildForState,
                  listener: (blocContext, blocState) {
                    if (blocState.done == null) {
                      print("blocState.done is null");
                    } else {
                      // if (blocState.done == true) {
                      //   BlocProvider.of<HomeBloc>(blocContext)
                      //       .add(InitializeExplore());
                      // } else {
                      //   done = false;
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Home()));
                          if(blocState.deleted == true){
                              Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Home()));
                          }
                          else{

                          }
                    }
                  }))),
    );
  }

  Widget buildForState(blocContext, RecipeDetailState blocState) {
    // List<String> newUserLike = blocState.recipeData.usersliked == null
    //     ? " "
    //     : blocState.recipeData.usersliked;
    if (blocState.isLoading) {
      return Center(
        child: CircularProgressIndicator(),
      );
    }
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
        body: SingleChildScrollView(
      child: Container(
        margin: MediaQuery.of(context).padding,
        color: Color(0xffF6F5F5),
        child: Column(
          children: [
            Container(
                color: Colors.orange,
                width: width,
                
                child: blocState.recipeData.imageid == null? Image(
                    image: AssetImage("assets/images/sample_food.jpeg"),
                    fit: BoxFit.cover):
                    Image.network(blocState.recipeData.imageid, fit: BoxFit.cover)),
            Container(
              color: Color(0xffF6F5F5),
              padding: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text("${blocState.recipeData.recipename}",
                            style: AppTheme.headline,
                            overflow: TextOverflow.ellipsis),
                      ),
                      Row(children: [
                        Column(
                          children: [
                            GestureDetector(
                              child: (blocState.recipeData.usersliked !=
                                          null) &&
                                      (blocState.userData != null &&
                                          blocState.recipeData.usersliked
                                              .contains(blocState.userData.id))
                                  ? Icon(
                                      Icons.favorite,
                                      color: Color(0xffFD6637),
                                    )
                                  : Icon(
                                      Icons.favorite_outline_sharp,
                                      color: Color(0xffFD6637),
                                    ),
                              onTap: () {
                                List newUserLike = [];
                                if (blocState.userData != null) {
                                  if (blocState.recipeData.usersliked != null) {
                                    newUserLike.addAll(
                                        blocState.recipeData.usersliked);
                                    if (newUserLike
                                        .contains(blocState.userData.id)) {
                                      YRSnackBar(
                                          errorMessage:
                                              "Already engaged with this recipe").showSnachkBar(context);
                                      return newUserLike;
                                    } else {
                                      print("userData");
                                      newUserLike.add(blocState.userData.id);
                                    }
                                  } else {
                                    newUserLike.add(blocState.userData.id);
                                  }
                                  print(newUserLike);
                                } else {
                                  //PUT POP UP MESSAGE HERE THAT SAYS LOGIN TO ENGAGE WITH RECIPES
                                  YRSnackBar(
                                      errorMessage:
                                          "Login to engage with recipes").showSnachkBar(context);
                                  print(newUserLike);
                                }
                                if (blocState.userData != null) {
                                  print(newUserLike);
                                  BlocProvider.of<RecipeDetailBloc>(blocContext)
                                      .add(UpdateRecipeDetail(newUserLike,
                                          blocState.recipeData.id, true));
                                }
                              },
                            ),
                            Text(
                              blocState.recipeData.usersliked == null
                                  ? '0'
                                  : (blocState.recipeData.usersliked.length)
                                      .toString(),
                              style: TextStyle(
                                color: Color(0xffD9D0E3),
                              ),
                            )
                          ],
                        ),
                        //SAVE ICON
                        //do tomorrow
                        //check if recipe id is in save if not save
                        Column(children: [
                          GestureDetector(
                            child: (blocState.userData != null &&
                                        blocState.userData.savedrecipes !=
                                            null) &&
                                    (blocState.userData.savedrecipes
                                        .contains(blocState.recipeData.id))
                                ? Icon(
                                    Icons.bookmark,
                                    color: Color(0xffFD6637),
                                  )
                                : Icon(
                                    Icons.bookmark_border_outlined,
                                    color: Color(0xffFD6637),
                                  ),
                            onTap: () {
                              print("saved");
                              print(blocState.recipeData.id);

                              List savedRecipes = [];
                              if (blocState.userData != null) {
                                if (blocState.userData.savedrecipes != null) {
                                  savedRecipes
                                      .addAll(blocState.userData.savedrecipes);
                                  if (savedRecipes
                                      .contains(blocState.recipeData.id)) {
                                    YRSnackBar(
                                      errorMessage:
                                          "Already engaged with this recipe").showSnachkBar(context);
                                    print("user exists");
                                    return savedRecipes;
                                  } else {
                                    print("userData");
                                    savedRecipes.add(blocState.recipeData.id);
                                  }
                                } else {
                                  savedRecipes.add(blocState.recipeData.id);
                                }
                                print(savedRecipes);
                              } else {
                                //PUT POP UP MESSAGE HERE THAT SAYS LOGIN TO ENGAGE WITH RECIPES
                                YRSnackBar(
                                    errorMessage:
                                        "LOGIN TO ENGAGE WITH RECIPES").showSnachkBar(context);
                                print(savedRecipes);
                              }
                              if (blocState.userData != null) {
                                print(savedRecipes);
                                BlocProvider.of<RecipeDetailBloc>(blocContext)
                                    .add(SaveRecipeDetail(
                                        userData: UserData(
                                            firstname:
                                                blocState.userData.firstname,
                                            lastname:
                                                blocState.userData.lastname,
                                            imageid: blocState.userData.imageid,
                                            totallikes: 0,
                                            recipescreated: blocState
                                                .userData.recipescreated,
                                            savedrecipes: savedRecipes)));
                              }
                            },
                          ),
                          Text(
                            '',
                            style: TextStyle(
                              color: Color(0xffD9D0E3),
                            ),
                          )
                        ]),

                        Column(children: [
                          GestureDetector(
                            child: (blocState.recipeData != null &&
                                        blocState.userData != null) &&
                                    (blocState.recipeData.userid ==
                                        blocState.userData.id && blocState.userData.role == 'AA00BET')
                                ? Icon(
                                    Icons.delete_forever,
                                    color: Color(0xffFD6637),
                                  )
                                : Container(),
                            onTap: () {
                              if (blocState.recipeData != null &&
                                  blocState.userData != null) {
                                BlocProvider.of<RecipeDetailBloc>(blocContext)
                                    .add(DeleteRecipeDetail(
                                        blocState.recipeData.id));
                              }
                            },
                          ),
                          Text(
                            '',
                            style: TextStyle(
                              color: Color(0xffD9D0E3),
                            ),
                          )
                        ]),
                      ])
                    ],
                  ),
                  Row(
                    children: [
                      Text(blocState.recipeData.cookingtime,
                          style: AppTheme.normaltext),
                      Container(
                          height: 12,
                          child: VerticalDivider(
                              thickness: 2, color: AppTheme.textSecondary)),
                      SizedBox(height: 30),
                      Text(
                        "${blocState.recipeData.serves.toString()} servings",
                        style: AppTheme.normaltext,
                      ),
                    ],
                  ),
                  Text(
                    "Steps",
                    style: AppTheme.header,
                    textAlign: TextAlign.left,
                  ),
                  SizedBox(height: 20),
                  Wrap(children: [
                    Text(
                      blocState.recipeData.ingredients
                          .join(' | ')
                          .toUpperCase(),
                      style: AppTheme.regularGreen,
                    ),
                  ]),
                  SizedBox(height: 20),
                  // Wrap(chil/dren: [
                  Text(blocState.recipeData.directions,
                      textAlign: TextAlign.justify
                      // ]),
                      ),

                  SizedBox(height: 20),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: ElevatedButton(
                        onPressed: () {
                          BlocProvider.of<RecipeDetailBloc>(blocContext)
                              .add(DoneButtonPressed());
                        },
                        child: Text("Done",
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.white)),
                        style: ButtonStyle(
                            padding:
                                MaterialStateProperty.all<EdgeInsetsGeometry>(
                                    EdgeInsets.fromLTRB(50, 20, 50, 20)),
                            alignment: Alignment.center,
                            backgroundColor: MaterialStateProperty.all<Color>(
                                AppTheme.buttonSecondary),
                            shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8))))),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
