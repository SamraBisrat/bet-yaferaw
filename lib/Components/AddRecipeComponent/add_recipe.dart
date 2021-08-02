import 'package:bet_yaferaw/ReusableComponents/bottom_navigation.dart';
import 'package:flutter/material.dart';

class AddRecipe extends StatefulWidget {
  const AddRecipe({Key key}) : super(key: key);

  @override
  _AddRecipeState createState() => _AddRecipeState();
}

class _AddRecipeState extends State<AddRecipe> {
  int selectedIndex = 1;
  String categoryController;
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      bottomNavigationBar: YRBottomNavigation(),
      body: Container(
          child: ListView(children: [
        Card(
            clipBehavior: Clip.antiAlias,
            child: Column(children: [
              Stack(alignment: Alignment.center, children: [
                Container(
                  height: screenHeight / 2.5,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image:
                              AssetImage("assets/images/post_background.jpg"),
                          fit: BoxFit.fitWidth)),
                ),
                Align(
                  alignment: Alignment.center,
                  child: Container(
                      width: 150,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.0),
                          color: Colors.grey.shade800.withOpacity(0.66)),
                      child: ListTile(
                        dense: true,
                        horizontalTitleGap: 0,
                        leading: Icon(
                          Icons.camera_alt_sharp,
                          color: Colors.white,
                        ),
                        title: const Text(
                          'Add Picture',
                          style: TextStyle(color: Colors.white),
                        ),
                      )),
                )
              ]),
              Card(
                  margin: EdgeInsets.symmetric(horizontal: 10),
                  elevation: 0,
                  clipBehavior: Clip.antiAlias,
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        TextFormField(
                          decoration: InputDecoration(
                              enabledBorder: UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: Color(0xffC4C4C4)),
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: Color(0xffFD6637)),
                              ),
                              isDense: true,
                              alignLabelWithHint: true,
                              border: UnderlineInputBorder(),
                              labelText: 'Title Here',
                              labelStyle: TextStyle(color: Color(0xffFD6637))),
                        ),
                        Padding(
                            padding: EdgeInsets.only(top: 12, bottom: 12),
                            child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Category",
                                      style: TextStyle(
                                          color: Color(0xffFD6637),
                                          decorationStyle:
                                              TextDecorationStyle.dashed)),
                                  Container(
                                      width: screenWidth / 2,
                                      child: DropdownButtonFormField(
                                        decoration: InputDecoration.collapsed(
                                            hintText: ""),
                                        value: categoryController,
                                        onChanged: (String newValue) {
                                          categoryController = newValue;
                                        },
                                        items: <String>[
                                          'Breakfast',
                                          'Lunch',
                                          'Dinner',
                                          'Brunch',
                                          'Snack',
                                        ].map<DropdownMenuItem<String>>(
                                            (String value) {
                                          return DropdownMenuItem<String>(
                                            value: value,
                                            child: Text(
                                              value,
                                              textWidthBasis:
                                                  TextWidthBasis.parent,
                                              style: TextStyle(
                                                  color: Color(0xffFD6637)),
                                            ),
                                          );
                                        }).toList(),
                                      )),
                                ])),
                        Divider(
                          color: Color(0xffC4C4C4),
                          thickness: 1,
                          height: 0,
                        ),
                        Padding(
                            padding: EdgeInsets.only(top: 12, bottom: 12),
                            child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Cooking",
                                      style: TextStyle(
                                          color: Color(0xffFD6637),
                                          decorationStyle:
                                              TextDecorationStyle.dashed)),
                                  Container(
                                      width: screenWidth / 2,
                                      child: DropdownButtonFormField(
                                        decoration: InputDecoration.collapsed(
                                            hintText: ""),
                                        value: categoryController,
                                        onChanged: (String newValue) {
                                          categoryController = newValue;
                                        },
                                        items: <String>[
                                          'less than 30 mintues',
                                          '30 minutes',
                                          '45 minutes',
                                          '1 hour',
                                          '1:30 hour',
                                          '2 hours',
                                          'Above 2 hours'
                                        ].map<DropdownMenuItem<String>>(
                                            (String value) {
                                          return DropdownMenuItem<String>(
                                            value: value,
                                            child: Text(
                                              value,
                                              textWidthBasis:
                                                  TextWidthBasis.parent,
                                              style: TextStyle(
                                                  color: Color(0xffFD6637)),
                                            ),
                                          );
                                        }).toList(),
                                      )),
                                ])),
                        Divider(
                          color: Color(0xffC4C4C4),
                          thickness: 1,
                          height: 0,
                        ),
                        Padding(
                            padding: EdgeInsets.only(top: 12, bottom: 12),
                            child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Serving",
                                      style: TextStyle(
                                          color: Color(0xffFD6637),
                                          decorationStyle:
                                              TextDecorationStyle.dashed)),
                                  Container(
                                      width: screenWidth / 2,
                                      child: DropdownButtonFormField(
                                        decoration: InputDecoration.collapsed(
                                            hintText: ""),
                                        value: categoryController,
                                        onChanged: (String newValue) {
                                          categoryController = newValue;
                                        },
                                        items: <String>['1', '2']
                                            .map<DropdownMenuItem<String>>(
                                                (String value) {
                                          return DropdownMenuItem<String>(
                                            value: value,
                                            child: Text(
                                              value,
                                              textWidthBasis:
                                                  TextWidthBasis.parent,
                                              style: TextStyle(
                                                  color: Color(0xffFD6637)),
                                            ),
                                          );
                                        }).toList(),
                                      )),
                                ])),
                        Divider(
                          color: Color(0xffC4C4C4),
                          thickness: 1,
                          height: 0,
                        ),
                        ListTile(
                            contentPadding: EdgeInsets.symmetric(horizontal: 0),
                            title: const Text(
                              'Add new ingredients',
                              style: TextStyle(
                                color: Color(0xff0BCE83),
                              ),
                            ),
                            trailing: Icon(
                              Icons.add_circle_rounded,
                              color: Colors.greenAccent.shade400,
                            )),
                      ]))
            ]))
      ])),
    );
  }
}
