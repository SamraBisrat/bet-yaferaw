import 'package:bet_yaferaw/Provider/MasterProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'Components/SplashScreenComponent/splash_screen.dart';



void main() {
  runApp(
    ChangeNotifierProvider(
      create: (BuildContext context) => MasterProvider(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: SplashScreen());
  }
}