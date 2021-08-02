import 'package:bet_yaferaw/Components/AddRecipeComponent/add_recipe.dart';
import 'package:bet_yaferaw/Components/HomeComponent/home.dart';
import 'package:flutter/material.dart';

class YRBottomNavigation extends StatefulWidget {
  const YRBottomNavigation({
    Key key,
  }) : super(key: key);

  @override
  _YRBottomNavigationState createState() => _YRBottomNavigationState();
}

class _YRBottomNavigationState extends State<YRBottomNavigation> {
  int indexSelected = 0;
  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(30), topLeft: Radius.circular(30)),
          boxShadow: [
            BoxShadow(color: Colors.black38, spreadRadius: 0, blurRadius: 10),
          ],
        ),
        child: ClipRRect(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30.0),
              topRight: Radius.circular(30.0),
            ),
            child: BottomNavigationBar(
              elevation: 40,
              unselectedItemColor: Color(0xffFD6637),
              selectedItemColor: Color(0xfffea04d),
              iconSize: 25,
              onTap: (int index) {
                setState(() {
                  indexSelected = index;
                });
                switch (index) {
                  case 0:
                    {
                      //
                      print(index);

                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Home()));
                    }
                    break;
                  case 1:
                    {
                      //
                      print(index);

                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => AddRecipe()));
                    }
                    break;
                  case 2:
                    {
                      //
                      print(index);
                    }
                }
              },
              items: <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.home_outlined,
                  ),
                  label: 'Home',
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.add,
                  ),
                  label: 'Post',
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.account_circle,
                  ),
                  label: 'Account',
                ),
              ],
              currentIndex: indexSelected,
              showUnselectedLabels: false,
              showSelectedLabels: false,
              type: BottomNavigationBarType.fixed,
            )));
  }
}
