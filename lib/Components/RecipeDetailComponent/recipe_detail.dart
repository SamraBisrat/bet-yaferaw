import 'dart:ui';

import 'package:bet_yaferaw/Provider/MasterProvider.dart';
import 'package:bet_yaferaw/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RecipeDetail extends StatefulWidget {
  @override
  _RecipeDetailState createState() => _RecipeDetailState();
}

class _RecipeDetailState extends State<RecipeDetail> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = double.infinity;
    return Scaffold(
        body: Container(
      color: Color(0xffF6F5F5),
      margin: MediaQuery.of(context).padding,
      child: Column(
        children: [
          Container(
              height: height / 3,
              width: width,
              child: Image(
                  image: AssetImage("assets/images/splashscreen.png"),
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
                    Wrap(children: [
                      Text(
                        "Spaghetti with Shrimp Sauce",
                        style: AppTheme.headline,
                      ),
                    ]),
                    Column(children: [
                      Consumer<MasterProvider>(
                          builder: ((context, provider, child) {
                        return GestureDetector(
                          child: provider.getliked
                              ? Icon(
                                  Icons.favorite_sharp,
                                  color: Color(0xffFD6637),
                                )
                              : Icon(
                                  Icons.favorite_outline_sharp,
                                  color: Color(0xffFD6637),
                                ),
                          onTap: () {
                            provider.checkIfFavorite(provider.getliked);
                          },
                        );
                      })),
                      Text(
                        '20',
                        style: TextStyle(
                          color: Color(0xffD9D0E3),
                        ),
                      )
                    ]),
                  ],
                ),
                Row(
                  children: [
                    Text("30 mins", style: AppTheme.normaltext),
                    Container(
                        height: 12,
                        child: VerticalDivider(
                            thickness: 2, color: AppTheme.textSecondary)),
                    SizedBox(height: 30),
                    Text(
                      "2 Servings",
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
                Wrap(children: [Text("")]),
                ElevatedButton(
                    onPressed: () {},
                    child: Text("Done",
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.white)),
                    style: ButtonStyle(
                        padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                            EdgeInsets.fromLTRB(50, 20, 50, 20)),
                        alignment: Alignment.center,
                        backgroundColor: MaterialStateProperty.all<Color>(
                            AppTheme.buttonSecondary),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8)))))
              ],
            ),
          )
        ],
      ),
    ));
  }
}
