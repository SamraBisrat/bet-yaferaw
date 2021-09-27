// import 'package:bet_yaferaw/Provider/MasterProvider.dart';
import 'package:bet_yaferaw/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

class RecipeShortDescription extends StatefulWidget {
  final String image;
  final String recipeName;
  final bool liked;
  final int likes;
  final String cookTime;
  final int serving;

  RecipeShortDescription(
      {this.image,
      this.recipeName,
      this.liked,
      this.likes,
      this.cookTime,
      this.serving});

  @override
  _RecipeShortDescriptionState createState() => _RecipeShortDescriptionState();
}

class _RecipeShortDescriptionState extends State<RecipeShortDescription> {
  // List<Widget> rows = [];

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Center(
      child: ClipRRect(
          borderRadius: BorderRadius.circular(10.0),
          child: Stack(fit: StackFit.loose, children: [
            Image.asset(
              widget.image,
              fit: BoxFit.fitWidth,
              width: width,
            ),
            Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  decoration: BoxDecoration(
                      color: Color(0xff282727).withOpacity(0.70),
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(12),
                          topRight: Radius.circular(12))),
                  height: height / 8,
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text(
                                widget.recipeName == null
                                    ? ""
                                    : widget.recipeName,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: AppTheme.fontName,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                            Column(children: [
                              Icon(
                                widget.liked
                                    ? Icons.favorite
                                    : Icons.favorite_outline_sharp,
                                color: Color(0xffFD6637),
                              ),
                              Text(
                                widget.likes.toString(),
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              )
                            ]),
                          ],
                        ),
                        Row(
                          children: [
                            Expanded(
                                child: Text(
                              "${widget.cookTime} hours",
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            )),
                            Container(
                                height: 12,
                                child: VerticalDivider(
                                  thickness: 2,
                                  color: Colors.white,
                                )),
                            Text(
                              "${widget.serving} Servings",
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ],
                        )
                      ]),
                ))
          ])),
    );
  }
}
