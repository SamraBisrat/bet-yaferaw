import 'dart:ui';

// import 'package:bet_yaferaw/Provider/MasterProvider.dart';
import 'package:bet_yaferaw/Components/RecipeDetailComponent/bloc/recipe_detail_bloc.dart';
import 'package:bet_yaferaw/Components/RecipeDetailComponent/bloc/recipe_detail_state.dart';
import 'package:bet_yaferaw/Repositories/recipe_detail_repo.dart';
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: BlocProvider(
              create: (context) => RecipeDetailBloc(widget.id),
              child: BlocConsumer<RecipeDetailBloc, RecipeDetailState>(
                  builder: buildForState,
                  listener: (blocContext, blocState) {}))),
    );
  }

  Widget buildForState(blocContext, RecipeDetailState blocState) {
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
                child: Image(
                    image: AssetImage("assets/images/sample_food.jpeg"),
                    fit: BoxFit.cover)),
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
                      Column(children: [
                        // Consumer<MasterProvider>(
                        //     builder: ((context, provider, child) {
                        //   return

                        GestureDetector(
                          child: Icon(
                            Icons.favorite_outline_sharp,
                            color: Color(0xffFD6637),
                          ),
                          onTap: () {},
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
                      ]),
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
                        "${blocState.recipeData.serves.toString()} servings" ,
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
                      "PASTA 100GM, SUAGR 20GM, WATER 1/2L".toUpperCase(),
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
                          Navigator.of(context).pop();
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
            )
          ],
        ),
      ),
    ));
  }
}
