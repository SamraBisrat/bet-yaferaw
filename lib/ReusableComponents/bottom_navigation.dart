import 'package:bet_yaferaw/Components/AddRecipeComponent/add_recipe.dart';
import 'package:bet_yaferaw/Components/HomeComponent/home.dart';
import 'package:bet_yaferaw/Components/LoginComponent/login.dart';
import 'package:bet_yaferaw/Components/ProfileComponent/profile.dart';
import 'package:bet_yaferaw/ReusableComponents/bloc/bottom_nav_bloc.dart';
import 'package:bet_yaferaw/ReusableComponents/bloc/bottom_nav_event.dart';
import 'package:bet_yaferaw/ReusableComponents/bloc/bottom_nav_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class YRBottomNavigation extends StatefulWidget {
  const YRBottomNavigation({
    Key key,
  }) : super(key: key);

  @override
  _YRBottomNavigationState createState() => _YRBottomNavigationState();
}

class _YRBottomNavigationState extends State<YRBottomNavigation> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => BottomNavBloc(),
        child: BlocConsumer<BottomNavBloc, BottomNavState>(
            builder: buildForState,
            listener: (blocContext, blocState) async {
              //null always a
              // if (blocState.userData == null || blocState.userData != null) {
              if (blocState.userData == null &&
                  (blocState.index == 1 || blocState.index == 2) &&
                  !blocState.isInitialStart) {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => Login()));
              } else if (blocState.index == 0 && !blocState.isInitialStart) {
                print('This is being called');
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => Home()));
              } else if (blocState.index == 1 && !blocState.isInitialStart) {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => AddRecipe()));
              } else if (blocState.index == 2 && !blocState.isInitialStart) {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Profile()));
              }
            }));
  }

  Widget buildForState(blocContext, BottomNavState blocState) {
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
              onTap: (int index) async {
                if (blocState.index != index) {
                  BlocProvider.of<BottomNavBloc>(blocContext)
                      .add(ChangeIndex(index));
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
              currentIndex: blocState.index,
              showUnselectedLabels: false,
              showSelectedLabels: false,
              type: BottomNavigationBarType.fixed,
            )));
  }
}
