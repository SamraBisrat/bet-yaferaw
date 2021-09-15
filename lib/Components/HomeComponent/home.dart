import 'package:bet_yaferaw/Components/HomeComponent/bloc/home_bloc.dart';
import 'package:bet_yaferaw/Components/HomeComponent/bloc/home_state.dart';
import 'package:bet_yaferaw/Components/RecipeDetailComponent/recipe_detail.dart';
import 'package:bet_yaferaw/Components/SearchResultComponent/search_result.dart';
import 'package:bet_yaferaw/Repositories/home_repo.dart';
import 'package:bet_yaferaw/ReusableComponents/bottom_navigation.dart';
import 'package:bet_yaferaw/ReusableComponents/camera_scanner_information.dart';
import 'package:bet_yaferaw/ReusableComponents/recipe_short_description.dart';
import 'package:bet_yaferaw/ReusableComponents/snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:textfield_tags/textfield_tags.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController _searchController = new TextEditingController();
  List<String> ingredients = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: BlocProvider(
              create: (context) => HomeBloc(homeRepository: HomeRepository()),
              child: BlocConsumer<HomeBloc, HomeState>(
                  builder: buildForState,
                  listener: (blocContext, blocState) {}))),
    );
  }

  Widget buildForState(blocContext, HomeState blocState) {
    if (blocState.isLoading) {
      return Center(child: CircularProgressIndicator());
    }
    return Scaffold(
        resizeToAvoidBottomInset: false,
        extendBody: true,
        bottomNavigationBar: YRBottomNavigation(),
        body: SingleChildScrollView(
            child: Container(
          margin: MediaQuery.of(context).padding,
          color: Color(0xffF6F5F5),
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                  padding: EdgeInsets.only(top: 40),
                  child: Text(
                    "Hello",
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
              Container(
                  padding: EdgeInsets.only(top: 20),
                  width: MediaQuery.of(context).size.width,
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                            child: TextFieldTags(
                          tagsStyler: TagsStyler(
                            showHashtag: false,
                            tagMargin: const EdgeInsets.only(right: 4.0),
                            tagCancelIcon: Icon(Icons.cancel,
                                size: 18.0, color: Colors.white),
                            tagCancelIconPadding:
                                EdgeInsets.only(left: 4.0, top: 2.0),
                            tagPadding: EdgeInsets.only(
                                top: 2.0, bottom: 4.0, left: 8.0, right: 4.0),
                            tagDecoration: BoxDecoration(
                              color: Colors.orange,
                              border: Border.all(
                                color: Colors.grey.shade300,
                              ),
                              borderRadius: const BorderRadius.all(
                                Radius.circular(20.0),
                              ),
                            ),
                            tagTextStyle: TextStyle(
                                fontWeight: FontWeight.normal,
                                color: Colors.white),
                            tagTextPadding: EdgeInsets.all(4),
                          ),
                          textFieldStyler: TextFieldStyler(
                              cursorColor: Color(0xff07110A),
                              textFieldFilledColor:
                                  Color(0xffC4C4C4).withOpacity(0.18),
                              hintText: "Search Ingredients",
                              isDense: true,
                              textFieldEnabledBorder: InputBorder.none,
                              textFieldFilled: true,
                              textFieldFocusedBorder: InputBorder.none,
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 15, horizontal: 10)),
                          onDelete: (tag) {
                            ingredients.remove(tag);
                          },
                          onTag: (tag) {
                            if ((ingredients.singleWhere((it) => it == tag,
                                    orElse: () => null)) !=
                                null) {
                              print('Already exists!');
                              YRSnackBar(
                                      title: "Ingredient Already Exists",
                                      errorMessage:
                                          "Please enter a different ingredient.")
                                  .showSnachkBar(context);
                            } else {
                              ingredients.add(tag);
                            }
                          },
                        )),
                        GestureDetector(
                       child: Container(
                            padding: EdgeInsets.only(bottom: 20, left: 10),
                            child: Icon(Icons.search_outlined,
                                color: Colors.orange, size: 30)),
                                onTap: (){
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                SearchResult(ingredients)));
                                },)
                      ])),
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
                child: CustomScrollView(
                    // padding: EdgeInsets.only(bottom: bottom),
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
                            children: blocState.exploredRecipe.map((e) {
                              return GestureDetector(
                                  child: RecipeShortDescription(
                                      image: "assets/images/sample_food.jpeg",
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
              ),
            ],
          ),
        )));
  }
}
