import 'dart:convert';
import 'dart:io';

import 'package:bet_yaferaw/Model/user.dart';
import 'package:bet_yaferaw/Provider/MasterProvider.dart';
import 'package:bet_yaferaw/Service/shared_pref.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

class HttpCalls {
  //production server
  static const String _baseUrl = "https://bet-yaferaw.herokuapp.com";

  //local server
  // static const String _baseUrl = "https://localhost:5000";
  // static const String imageHolderUrl = "http://144.126.193.76:5000/api/Images/";
  //End points
  //Posts
  static const String _createUserImage = "/userimage";
  static const String _createUser = "/user";
  static const String _login = "/login";
  static const String _createRecipe = "/recipe";
  static const String _createRecipeImage = "/recipeimage";

  //Gets
  static const String _getUserById = "/user/id";
  static const String _getRecipeById = "/recipe/id";

  //Post Requests

  // Put token in to header
  static Map<String, String> _getRequestHeader({String token = ""}) {
    if (token == "") {
      return {"Content-type": "application/json", 'Charset': 'utf-8'};
    }
    return {
      "Content-type": "application/json",
      HttpHeaders.authorizationHeader: "Bearer $token"
    };
  }

  static Future<int> login(
      String email, String password, MasterProvider masterProvider) async {
    return await http
        .post(Uri.parse(_baseUrl + _login),
            headers: _getRequestHeader(),
            body: jsonEncode({"email": email, "password": password}))
        .then((value) async {
      print(Uri.parse(_baseUrl + _login));
      print(value.statusCode);
      if (value.statusCode == 200) {
        var response = jsonDecode(value.body);
        var token = response["token"];
        print(token);
        await SharedPref.storeToken(token.toString());
      }
      return value.statusCode;
    }).catchError((onError) {
      print(onError.stackTrace);
      handleOnError(onError, masterProvider);
      return -1;
    });
  }

  static Future<int> createUser(
      UserData userData, MasterProvider masterProvider) async {
    return await http
        .post(Uri.parse(_baseUrl + _createUser),
            headers: _getRequestHeader(), body: jsonEncode(userData.toJson()))
        .then((value) async {
      print(value.body);
      if (value.statusCode == 200) {
        var response = jsonDecode(value.body);
        var id = response["id"];
        print(id.toString());
      }
      return value.statusCode;
    }).catchError((onError) {
      print(onError);
      handleOnError(onError, masterProvider);
      return -1;
    });
  }

  static Future<int> getMyAccount(
      UserData userData, MasterProvider masterProvider) async {
    Map<String, dynamic> payload = JwtDecoder.decode(masterProvider.getToken);
    String id = payload["id"];

    return await http
        .get(Uri.parse(_baseUrl + _getUserById + id),
            headers: _getRequestHeader(token: masterProvider.getToken))
        .then((value) async {
      if (value.statusCode == 200) {
        var response = jsonDecode(value.body);
        userData = UserData.fromJson(response);
        masterProvider.setUserdata = userData;
        await SharedPref.storeMyData(
            "myUserData", json.encode(userData.toJson()));
        print(userData.toJson());
      }

      return value.statusCode;
    }).catchError((onError) {
      handleOnError(onError, masterProvider);

      print(onError);
      return -1;
    });
  }

  static handleOnError(dynamic onError, MasterProvider masterProvider) {
    print(onError);
    if (onError is SocketException) {
      masterProvider.setLoading = false;
      Fluttertoast.showToast(
          msg: "You are offline, Please connect to the internet first!",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.grey[850],
          textColor: Colors.white,
          fontSize: 15.0);
    }
  }
}
