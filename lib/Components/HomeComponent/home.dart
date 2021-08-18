import 'package:bet_yaferaw/Components/RecipeDetailComponent/recipe_detail.dart';
import 'package:bet_yaferaw/Provider/MasterProvider.dart';
import 'package:bet_yaferaw/ReusableComponents/bottom_navigation.dart';
import 'package:bet_yaferaw/ReusableComponents/camera_scanner_information.dart';
import 'package:bet_yaferaw/ReusableComponents/recipe_short_description.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController _searchController = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    MasterProvider masterProvider =
        Provider.of<MasterProvider>(context, listen: false);
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
        extendBody: true,
        bottomNavigationBar: YRBottomNavigation(),
        body:SingleChildScrollView(
            child:  Container(
          margin: MediaQuery.of(context).padding,
          color: Color(0xffF6F5F5),
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                  padding: EdgeInsets.only(top: 40),
                  child: Text(
                    "Hello, Monete",
                    style: TextStyle(
                        color: Color(0xffFD6637),
                        fontSize: 25,
                        fontWeight: FontWeight.bold),
                  )),
              Padding(
                padding: EdgeInsets.only(top: 10),
                child: Text(
                  "What do you want to cook today?",
                  style: TextStyle(
                      color: Color(0xff9586A8),
                      fontSize: 15,
                      fontWeight: FontWeight.normal),
                ),
              ),
              Padding(
                  padding: EdgeInsets.only(top: 20),
                  child: TextFormField(
                    cursorColor: Color(0xff07110A),
                    controller: _searchController,
                    decoration: InputDecoration(
                      focusedBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      errorBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,
                      fillColor: Color(0xffC4C4C4).withOpacity(0.18),
                      filled: true,
                      // labelText: "Search",
                      hintText: "Search Recipes",
                      hintStyle: TextStyle(color: Color(0xff9586A8)),
                      prefixIcon: Icon(
                        Icons.search,
                        color: Color(0xff07110A),
                      ),
                      suffixIcon: IconButton(
                          icon: Icon(Icons.clear, color: Color(0xff07110A)),
                          onPressed: () {
                            _searchController.clear();
                          }),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.transparent),
                        borderRadius: BorderRadius.circular(18.0),
                      ),
                    ),
                  )),
              Padding(
                padding: EdgeInsets.only(top: 20),
                child: CameraScannerInformation(),
              ),
              Padding(
                padding: EdgeInsets.only(top: 20),
                child: Text(
                  "Trending Recipes",
                  style: TextStyle(
                      color: Color(0xff2D0C57),
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Container(
                child: Expanded(
                  flex: 1,
                  child: ListView(
                    shrinkWrap: true,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => RecipeDetail()));
                        },
                      child:
                      CustomScrollView(shrinkWrap: true, slivers: <Widget>[
                        SliverPadding(
                          padding:
                              EdgeInsets.symmetric(vertical: 2, horizontal: 0),
                          sliver: SliverGrid.count(
                            childAspectRatio: 0.7,
                            crossAxisCount: 2,
                            mainAxisSpacing: 5,
                            crossAxisSpacing: 5,
                            children: [
                              RecipeShortDescription(
                                  image: "assets/images/sample_food.jpeg",
                                  recipeName: "Spaghetti  Shrimp Sauce",
                                  liked: masterProvider.getliked,
                                  likes: 20,
                                  cookTime: "20",
                                  serving: 2),
                              RecipeShortDescription(
                                  image: "assets/images/sample_food.jpeg",
                                  recipeName: "Spaghetti  Shrimp Sauce",
                                  liked: masterProvider.getliked,
                                  likes: 20,
                                  cookTime: "20",
                                  serving: 2),
                              RecipeShortDescription(
                                  image: "assets/images/sample_food.jpeg",
                                  recipeName: "Spaghetti  Shrimp Sauce",
                                  liked: masterProvider.getliked,
                                  likes: 20,
                                  cookTime: "20",
                                  serving: 2),
                              RecipeShortDescription(
                                  image: "assets/images/sample_food.jpeg",
                                  recipeName: "Spaghetti  Shrimp Sauce",
                                  liked: masterProvider.getliked,
                                  likes: 20,
                                  cookTime: "20",
                                  serving: 2),
                              RecipeShortDescription(
                                  image: "assets/images/sample_food.jpeg",
                                  recipeName: "Spaghetti  Shrimp Sauce",
                                  liked: masterProvider.getliked,
                                  likes: 20,
                                  cookTime: "20",
                                  serving: 2),
                              RecipeShortDescription(
                                  image: "assets/images/sample_food.jpeg",
                                  recipeName: "Spaghetti  Shrimp Sauce",
                                  liked: masterProvider.getliked,
                                  likes: 20,
                                  cookTime: "20",
                                  serving: 2),
                              RecipeShortDescription(
                                  image: "assets/images/sample_food.jpeg",
                                  recipeName: "Spaghetti  Shrimp Sauce",
                                  liked: masterProvider.getliked,
                                  likes: 20,
                                  cookTime: "20",
                                  serving: 2),
                              RecipeShortDescription(
                                  image: "assets/images/sample_food.jpeg",
                                  recipeName: "Spaghetti  Shrimp Sauce",
                                  liked: masterProvider.getliked,
                                  likes: 20,
                                  cookTime: "20",
                                  serving: 2),
                            ],
                          ),
                        ),
                      ]),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        )));
  }
}
