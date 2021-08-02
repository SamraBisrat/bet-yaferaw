import 'package:bet_yaferaw/ReusableComponents/bottom_navigation.dart';
import 'package:flutter/material.dart';

class Settings extends StatefulWidget {
  // const Settings({Key key}) : super(key: key);

  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: Icon(Icons.chevron_left),
          color: Color(0xff2D0C57),
          iconSize: 25,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        elevation: 0,
        automaticallyImplyLeading: true,
      ),
      body: Container(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
        Text(
          "Settings",
          textAlign: TextAlign.left,
          style: TextStyle(
              color: Color(0XFFFD6637),
              fontWeight: FontWeight.w700,
              fontFamily: "Source Sans Pro",
              fontSize: 20),
        ),
        Divider(thickness: 1, height: 0, color: Colors.blueGrey.shade100),
        ListTile(
            horizontalTitleGap: 0,
            contentPadding: EdgeInsets.all(0),
            leading: Icon(
              Icons.lock_open,
              size: 24,
              color: Color(0xffFD6637),
            ),
            title: Text(
              "Change Password",
              style: TextStyle(
                  color: Color(0xff2D0C57),
                  fontFamily: " Source Sans Pro",
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  letterSpacing: 0.41),
            ),
            trailing: Icon(Icons.chevron_right)),
        Divider(thickness: 1, height: 0, color: Colors.blueGrey.shade100),
        ListTile(
            horizontalTitleGap: 0,
            contentPadding: EdgeInsets.all(0),
            leading: Icon(
              Icons.manage_accounts_outlined,
              size: 24,
              color: Color(0xffFD6637),
            ),
            title: Text(
              "Edit Name",
              style: TextStyle(
                  color: Color(0xff2D0C57),
                  fontFamily: " Source Sans Pro",
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  letterSpacing: 0.41),
            ),
            trailing: Icon(Icons.chevron_right)),
        Divider(thickness: 1, height: 0, color: Colors.blueGrey.shade100),
        ListTile(
            horizontalTitleGap: 0,
            contentPadding: EdgeInsets.all(0),
            leading: Icon(
              Icons.exit_to_app_outlined,
              size: 24,
              color: Color(0xffFD6637),
            ),
            title: Text(
              "Sign Out",
              style: TextStyle(
                  color: Color(0xff2D0C57),
                  fontFamily: " Source Sans Pro",
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  letterSpacing: 0.41),
            ),
            trailing: Icon(Icons.chevron_right)),
        Divider(thickness: 1, height: 0, color: Colors.blueGrey.shade100),
      ])),
      bottomNavigationBar: YRBottomNavigation(),
    );
  }
}
