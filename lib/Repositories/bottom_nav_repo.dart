import 'dart:convert';
import 'package:bet_yaferaw/Model/user.dart';
import 'package:bet_yaferaw/Service/shared_pref.dart';

class BottomNavRepository {
  var user;
  getUserData() async {
    await SharedPref.getMyData("userData").then((value) {
      if (!(value == "")) {
        Map<String, dynamic> userData = jsonDecode(value);
        user = UserData.fromJson(userData);
        print(user["firstname"]);
        print("insidse bottom nav repo");
        return user;
      } else {
        return null;
      }
    }).catchError((onError) {
      return null;
    });
  }
}
