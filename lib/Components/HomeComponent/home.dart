import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          Text("Hello, Monete"),
          Text("What do you want to cook today?"),
          TextFormField(
            keyboardType: TextInputType.text,
            ),
          Container(
            //recipe card 
          )
        ],
      ),
    );
  }
}
