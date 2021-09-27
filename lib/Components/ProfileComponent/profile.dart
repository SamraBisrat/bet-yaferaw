import 'package:bet_yaferaw/Components/LoginComponent/login.dart';
import 'package:bet_yaferaw/Components/ProfileComponent/bloc/profile_bloc.dart';
import 'package:bet_yaferaw/Components/ProfileComponent/bloc/profile_event.dart';
import 'package:bet_yaferaw/Components/ProfileComponent/bloc/profile_state.dart';
import 'package:bet_yaferaw/Components/RecipeDetailComponent/recipe_detail.dart';
import 'package:bet_yaferaw/Components/SettingsComponent/settings.dart';
import 'package:bet_yaferaw/Repositories/profile_repo.dart';
import 'package:bet_yaferaw/ReusableComponents/bottom_navigation.dart';
import 'package:bet_yaferaw/ReusableComponents/recipe_short_description.dart';
import 'package:bet_yaferaw/ReusableComponents/snack_bar.dart';
import 'package:bet_yaferaw/theme/app_theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: BlocProvider(
              create: (context) =>
                  ProfileBloc(profileRepository: ProfileRepository()),
              child: BlocConsumer<ProfileBloc, ProfileState>(
                  builder: buildForState,
                  listener: (blocContext, blocState) {}))),
    );
  }

  Widget buildForState(blocContext, ProfileState blocState) {
    // MasterProvider masterProvider =
    //     Provider.of<MasterProvider>(context, listen: false);

    if (blocState.isLoading) {
      return Center(child: CircularProgressIndicator());
    }

    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return DefaultTabController(
        length: 2,
        child: Scaffold(
            bottomNavigationBar: YRBottomNavigation(),
            body: SingleChildScrollView(
                child: Container(
              color: AppTheme.primaryColor,
              margin: MediaQuery.of(context).padding,
              child: Column(
                children: [
                  Stack(children: [
                    Container(
                      // padding: const EdgeInsets.only(top: 30),
                      width: width,
                      height: height * 0.35,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image:
                                  AssetImage('assets/images/Ellipses-new.png'),
                              fit: BoxFit.fill)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                    blocState.userData.recipescreated == null
                                        ? '0'
                                        : blocState
                                            .userData.recipescreated.length,
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 30,
                                        fontFamily: AppTheme.fontName)),
                                Text(
                                  "Posts",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 15,
                                      fontFamily: AppTheme.fontName),
                                )
                              ],
                            ),
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CircleAvatar(
                                radius: 75.0,
                                backgroundImage: AssetImage(
                                    "assets/images/sample_profile.jpeg"),
                                backgroundColor: Colors.transparent,
                              ),
                              SizedBox(height: 20),
                              Text(
                                "${blocState.userData.firstname} ${blocState.userData.lastname}",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 25,
                                    fontFamily: AppTheme.fontName,
                                    fontWeight: FontWeight.bold),
                              )
                            ],
                          ),
                          Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                    blocState.userData.savedrecipes == null
                                        ? '0'
                                        : blocState.userData.savedrecipes.length
                                            .toString(),
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 30,
                                        fontFamily: AppTheme.fontName)),
                                Text(
                                  "Saved",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 15,
                                      fontFamily: AppTheme.fontName),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    AppBar(
                      automaticallyImplyLeading: false,
                      backgroundColor: Colors.transparent,
                      elevation: 0.0,
                      actions: <Widget>[
                        PopupMenuButton<String>(
                          onSelected: choiceAction,
                          itemBuilder: (BuildContext context) {
                            return {'Settings', 'Logout'}.map((String choice) {
                              return PopupMenuItem<String>(
                                value: choice,
                                child: Text(choice),
                              );
                            }).toList();
                          },
                        ),
                      ],
                    ),
                  ]),
                  Container(
                    height: height,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 20),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            topLeft: const Radius.circular(40),
                            topRight: const Radius.circular(40),
                            bottomLeft: const Radius.circular(40),
                            bottomRight: const Radius.circular(40))),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Posts",
                          style: AppTheme.header,
                          textAlign: TextAlign.left,
                        ),
                        SizedBox(
                          child: TabBar(
                            indicatorColor: AppTheme.primaryColor,
                            tabs: [
                              GestureDetector(
                                child: Tab(
                                    icon: Icon(
                                      Icons.grid_on,
                                      color: AppTheme.primaryColor,
                                    ),
                                    child: Text("Posted Recipes",
                                        style: TextStyle(
                                            color: AppTheme.primaryColor))),
                                onTap: () {
                                  print("created");
                                  BlocProvider.of<ProfileBloc>(blocContext)
                                      .add(CreatedRecipesPressed());
                                },
                              ),
                              GestureDetector(
                                child: Tab(
                                  icon: Icon(
                                    Icons.bookmark_border_sharp,
                                    color: AppTheme.primaryColor,
                                  ),
                                  child: Text("Saved Recipes",
                                      style: TextStyle(
                                          color: AppTheme.primaryColor)),
                                ),
                                onTap: () {
                                  print("saved");
                                  BlocProvider.of<ProfileBloc>(blocContext)
                                      .add(SavedRecipesPressed());
                                },
                              )
                            ],
                          ),
                        ),
                        Flexible(
                          child: TabBarView(
                            children: [
                              Container(
                                child: CustomScrollView(
                                    physics: ScrollPhysics(),
                                    shrinkWrap: true,
                                    slivers: <Widget>[
                                      SliverPadding(
                                        padding: EdgeInsets.symmetric(
                                            vertical: 2, horizontal: 0),
                                        sliver: SliverGrid.count(
                                            childAspectRatio: 0.7,
                                            crossAxisCount: 2,
                                            mainAxisSpacing: 5,
                                            crossAxisSpacing: 5,
                                            children:
                                                blocState.myRecipes.map((e) {
                                              return GestureDetector(
                                                child: RecipeShortDescription(
                                                    image:
                                                        "assets/images/sample_food.jpeg",
                                                    recipeName: e.recipename,
                                                    liked: e.usersliked == null
                                                        ? false
                                                        : e.usersliked.contains(
                                                            blocState
                                                                .userData.id),
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
                                                              RecipeDetail(
                                                                  e.id)));
                                                },
                                              );
                                            }).toList()),
                                      )
                                    ]),
                              ),
                              Container(
                                // height: height,
                                child: CustomScrollView(
                                    physics: ScrollPhysics(),
                                    shrinkWrap: true,
                                    slivers: <Widget>[
                                      SliverPadding(
                                        padding: EdgeInsets.symmetric(
                                            vertical: 2, horizontal: 0),
                                        sliver: SliverGrid.count(
                                            childAspectRatio: 0.7,
                                            crossAxisCount: 2,
                                            mainAxisSpacing: 5,
                                            crossAxisSpacing: 5,
                                            children: blocState.mySavedRecipes
                                                .map((e) {
                                              return GestureDetector(
                                                child: RecipeShortDescription(
                                                    image:
                                                        "assets/images/sample_food.jpeg",
                                                    recipeName: e.recipename,
                                                    liked: e.usersliked == null
                                                        ? false
                                                        : e.usersliked.contains(
                                                            blocState
                                                                .userData.id),
                                                    likes: e.usersliked == null
                                                        ? 0
                                                        : e.usersliked.length,
                                                    cookTime: e.cookingtime,
                                                    serving: e.serves),
                                                onTap: () {
                                                  print(e.toJson());
                                                  print(e.id);
                                                  Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              RecipeDetail(
                                                                  e.id)));
                                                },
                                              );
                                            }).toList()),
                                      )
                                    ]),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            )

                //     ),
                //   ),
                // ],

                )));
  }

  void choiceAction(String value) async {
    if (value == "Settings") {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => Settings()));
    } else if (value == "Logout") {
      Navigator.push(context, MaterialPageRoute(builder: (context) => Login()));
    }
  }
}
