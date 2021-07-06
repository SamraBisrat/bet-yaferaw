import 'package:bet_yaferaw/ReusableComponents/camera_scanner_information.dart';
import 'package:flutter/material.dart';
import 'package:search_widget/search_widget.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController _searchController = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
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
                  borderRadius: BorderRadius.circular(6.0),
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 30),
            child: CameraScannerInformation(),
          )
        ],
      ),
    ));
  }
}
