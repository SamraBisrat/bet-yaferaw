import 'package:flutter/material.dart';

class YRBottomNavigation extends StatelessWidget {
  const YRBottomNavigation({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30.0),
          topRight: Radius.circular(30.0),
        ),
        child: BottomNavigationBar(
          elevation: 5.0,
          unselectedItemColor: Color(0xffFD6637),
          selectedItemColor: Color(0xfffea04d),
          iconSize: 25,
          onTap: (int index) {
            // index = selectedIndex;
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
          // currentIndex: selectedIndex == null ? 0 : selectedIndex,
          showUnselectedLabels: false,
          showSelectedLabels: false,
          type: BottomNavigationBarType.fixed,
        ));
  }
}
