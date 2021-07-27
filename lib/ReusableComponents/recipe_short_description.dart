import 'package:bet_yaferaw/Provider/MasterProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
  List<Widget> rows = [];

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = double.infinity;

    rows.add(Padding(
        padding: EdgeInsets.only(top: 10),
        child: Stack(
          children: [
            Container(
              width: width,
              child: Image(
                image: AssetImage(widget.image),
                fit: BoxFit.cover,
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                  height: 80,
                  color: Color(0xff282727).withOpacity(0.70),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            widget.recipeName == null ? "" : widget.recipeName,
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
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
                          Text(
                            "${widget.cookTime} mins",
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
                            "${widget.serving} Servings",
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ],
                      )
                    ],
                  )),
            )
          ],
        )));
    return Container(
        height: height / 3,
        child: CustomScrollView(
          shrinkWrap: true,
          slivers: <Widget>[
            SliverPadding(
              sliver: SliverGrid.count(
                  crossAxisCount: 2,
                  crossAxisSpacing: 3,
                  mainAxisSpacing: 3,
                  children: rows),
              padding: EdgeInsets.all(0),
            )
          ],
        ));
  }
}
