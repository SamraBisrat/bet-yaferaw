import 'package:bet_yaferaw/Provider/MasterProvider.dart';
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
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Wrap(children: [
                      Text(
                        "Spaghetti with Shrimp Sauce",
                        style: TextStyle(
                          color: Color(0xffFD6637),
                        ),
                      )
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
                    Text(
                      "30 mins",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    Container(
                        height: 12,
                        child: VerticalDivider(
                          thickness: 2,
                          color: Colors.white,
                        )),
                    Text(
                      "2 Servings",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                Wrap(children: [Text("")]),
                MaterialButton(onPressed: () {
                  Text(
                    "Done",
                    textAlign: TextAlign.center,
                  );
                })
              ],
            ),
          )
        ],
      ),
    ));
  }
}
