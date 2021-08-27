import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPref {
  static Future<String> getToken() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    if (pref.containsKey("token")) {
      return pref.getString("token");
    } else {
      return "";
    }
  }

  static Future<bool> storeToken(String value) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return await pref.setString("token", value);
  }

  static Future<String> getMyData(String key) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    if (pref.containsKey(key)) {
      return json.decode(pref.getString(key));
    } else {
      return "";
    }
  }

  static Future<bool> storeMyData(String key, value) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.setString(key, json.encode(value));
  }
}
