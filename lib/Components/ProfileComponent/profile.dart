import 'package:bet_yaferaw/Components/LoginComponent/login.dart';
import 'package:bet_yaferaw/Components/RecipeDetailComponent/recipe_detail.dart';
import 'package:bet_yaferaw/Provider/MasterProvider.dart';
import 'package:bet_yaferaw/ReusableComponents/bottom_navigation.dart';
import 'package:bet_yaferaw/ReusableComponents/recipe_short_description.dart';
import 'package:bet_yaferaw/theme/app_theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    MasterProvider masterProvider =
        Provider.of<MasterProvider>(context, listen: false);
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
        bottomNavigationBar: YRBottomNavigation(),
        body: Container(
            color: AppTheme.primaryColor,
            width: width,
            height: height,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Stack(children: [
                    Container(
                      padding: const EdgeInsets.only(top: 30),
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
                                Text("230",
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
                                "Monte Claire",
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
                                Text("40",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 30,
                                        fontFamily: AppTheme.fontName)),
                                Text(
                                  "Likes",
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
                            return {'Logout'}.map((String choice) {
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
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 20),
                    width: width,
                    height: height * 0.65,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            topLeft: const Radius.circular(40),
                            topRight: const Radius.circular(40))),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          "Posts",
                          style: AppTheme.header,
                          textAlign: TextAlign.left,
                        ),
                        Expanded(
                          flex: 1,
                          child: ListView(
                            shrinkWrap: true,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              RecipeDetail()));
                                },
                                child: CustomScrollView(
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
                                          children: [
                                            RecipeShortDescription(
                                                image:
                                                    "assets/images/sample_food.jpeg",
                                                recipeName:
                                                    "Spaghetti  Shrimp Sauce",
                                                liked: masterProvider.getliked,
                                                likes: 20,
                                                cookTime: "20",
                                                serving: 2),
                                            RecipeShortDescription(
                                                image:
                                                    "assets/images/sample_food.jpeg",
                                                recipeName:
                                                    "Spaghetti  Shrimp Sauce",
                                                liked: masterProvider.getliked,
                                                likes: 20,
                                                cookTime: "20",
                                                serving: 2),
                                            RecipeShortDescription(
                                                image:
                                                    "assets/images/sample_food.jpeg",
                                                recipeName:
                                                    "Spaghetti  Shrimp Sauce",
                                                liked: masterProvider.getliked,
                                                likes: 20,
                                                cookTime: "20",
                                                serving: 2),
                                            RecipeShortDescription(
                                                image:
                                                    "assets/images/sample_food.jpeg",
                                                recipeName:
                                                    "Spaghetti  Shrimp Sauce",
                                                liked: masterProvider.getliked,
                                                likes: 20,
                                                cookTime: "20",
                                                serving: 2),
                                            RecipeShortDescription(
                                                image:
                                                    "assets/images/sample_food.jpeg",
                                                recipeName:
                                                    "Spaghetti  Shrimp Sauce",
                                                liked: masterProvider.getliked,
                                                likes: 20,
                                                cookTime: "20",
                                                serving: 2),
                                            RecipeShortDescription(
                                                image:
                                                    "assets/images/sample_food.jpeg",
                                                recipeName:
                                                    "Spaghetti  Shrimp Sauce",
                                                liked: masterProvider.getliked,
                                                likes: 20,
                                                cookTime: "20",
                                                serving: 2),
                                            RecipeShortDescription(
                                                image:
                                                    "assets/images/sample_food.jpeg",
                                                recipeName:
                                                    "Spaghetti  Shrimp Sauce",
                                                liked: masterProvider.getliked,
                                                likes: 20,
                                                cookTime: "20",
                                                serving: 2),
                                            RecipeShortDescription(
                                                image:
                                                    "assets/images/sample_food.jpeg",
                                                recipeName:
                                                    "Spaghetti  Shrimp Sauce",
                                                liked: masterProvider.getliked,
                                                likes: 20,
                                                cookTime: "20",
                                                serving: 2),
                                          ],
                                        ),
                                      )
                                    ]),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            )));
  }

  void choiceAction(String value) async {
    if (value == "Edit") {
      // Navigator.push(context,
      //     MaterialPageRoute(builder: (context) => EditEquberProfile()));
    } else if (value == "Logout") {
      Navigator.push(context, MaterialPageRoute(builder: (context) => Login()));
    }
  }
}
