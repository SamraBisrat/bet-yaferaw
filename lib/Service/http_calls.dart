import 'dart:convert';
import 'dart:io';

import 'package:bet_yaferaw/Components/LoginComponent/bloc/login_event.dart';
import 'package:bet_yaferaw/Components/LoginComponent/bloc/login_state.dart';
import 'package:bet_yaferaw/Model/recipe.dart';
import 'package:bet_yaferaw/Model/user.dart';
import 'package:bet_yaferaw/Provider/MasterProvider.dart';
import 'package:bet_yaferaw/Service/shared_pref.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:path/path.dart' as p;

class HttpCalls {
  //production server
  static const String _baseUrl = "https://bet-yaferaw.herokuapp.com";

  //local server
  // static const String _baseUrl = "https://localhost:5000";
  // static const String imageHolderUrl = "http://144.126.193.76:5000/api/Images/";
  //End points
  //Posts
  static const String _createUser = "/user";
  static const String _login = "/login";
  static const String _myAccount = "/account";
  static const String _createRecipe = "/recipe";

  //Patch
  static const String _updateRecipe = "/updateRecipe/recipeid";
  static const String _updateUser = "/updateUser/userid";

  //Gets
  static const String _getUserById = "/user/id";
  static const String _getRecipeById = "/recipe/id";
  static const String _getUsers = "/get/users";
  static const String _getRecipes = "/get/recipes";
  static const String _getMyRecipes = "/recipes/userid";
  static const String _getMySavedRecipes = "/recipes/saved";

  //Search

  static const String _searchRecipe = "/search/recipe";

  //Post Requests

  // Put token in to header
  static Map<String, String> _getRequestHeader({String token = ""}) {
    if (token == "") {
      return {
        "Content-type": "application/json",
        'Charset': 'utf-8',
      };
    }
    return {
      "Content-type": "application/json",
      HttpHeaders.authorizationHeader: "Bearer $token"
    };
  }

  Future<String> getToken() async {
    return await SharedPref.getToken();
  }

  Future<String> login(String email, String password) async {
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
        await SharedPref.storeToken(token.toString());
        return token.toString();
      }
      return null;
    }).catchError((onError) {
      // handleOnError(onError);
      return null;
    });
  }

  Future<String> createUser(UserData userData) async {
    return await http
        .post(Uri.parse(_baseUrl + _createUser),
            headers: _getRequestHeader(), body: jsonEncode(userData.toJson()))
        .then((value) async {
      print(value.body);
      if (value.statusCode == 200) {
        var response = jsonDecode(value.body);
        var id = response["id"];
        print(id.toString());
        return response.toString();
      }
    }).catchError((onError) {
      print(onError);
      // handleOnError(onError, masterProvider);
      return null;
    });
  }

  Future<String> uploadProfileImage(File image) async {
    StorageReference storageReference = FirebaseStorage.instance
        .ref()
        .child('profiles/${p.basename(image.path)}}');
    StorageUploadTask uploadTask = storageReference.putFile(image);

    StorageTaskSnapshot taskSnapshot = await uploadTask.onComplete;
    String downloadUrl = await (await taskSnapshot.ref.getDownloadURL());
    return downloadUrl;
  }

  // static Future<int> createRecipe(
  //     RecipeData recipeData, MasterProvider masterProvider, String id) async {
  //   return await http
  //       .post(Uri.parse(_baseUrl + _createRecipe + id),
  //           headers: _getRequestHeader(token: masterProvider.getToken),
  //           body: jsonEncode(recipeData.toJson()))
  //       .then((value) async {
  //     print(value.statusCode);
  //     if (value.statusCode == 200) {
  //       var response = jsonDecode(value.body);
  //       recipeData = RecipeData.fromJson(response);
  //       masterProvider.setRecipeData = recipeData;

  //     }

  //     return value.statusCode;
  //   }).catchError((onError) {
  //     handleOnError(onError, masterProvider);
  //     print(onError);
  //     return -1;
  //   });
  // }

  Future<UserData> getMyAccount(UserData userData) async {
    return await http
        .get(Uri.parse(_baseUrl + _myAccount),
            headers: _getRequestHeader(token: await getToken()))
        .then((value) async {
      if (value.statusCode == 200) {
        var response = jsonDecode(value.body);
        userData = UserData.fromJson(response);
        // masterProvider.setUserdata = userData;
        await SharedPref.storeMyData(
            "userData", json.encode(userData.toJson()));
        print(userData.toJson());
        return response;
      }
    }).catchError((onError) {
      // handleOnError(onError, masterProvider);
      print(onError);
      return -1;
    });
  }

  // Future<int> updateUser(
  //     UserData userData, MasterProvider masterProvider) async {
  //   Map<String, dynamic> payload = JwtDecoder.decode(masterProvider.getToken);
  //   String id = payload["id"];
  //   return await http
  //       .patch(Uri.parse(_baseUrl + _updateUser + id),
  //           headers: _getRequestHeader(token: masterProvider.getToken))
  //       .then((value) async {
  //     if (value.statusCode == 200) {
  //       var response = jsonDecode(value.body);
  //       userData = UserData.fromJson(response);
  //       masterProvider.setUserdata = userData;
  //       await SharedPref.storeMyData(
  //           "userData", json.encode(userData.toJson()));
  //       print(userData.toJson());
  //     }
  //     return value.statusCode;
  //   }).catchError((onError) {
  //     handleOnError(onError, masterProvider);
  //     print(onError);
  //     return -1;
  //   });
  // }

  // Future<int> updateRecipe(RecipeData recipeData, MasterProvider masterProvider,
  //     String recipeId) async {
  //   return await http
  //       .patch(Uri.parse(_baseUrl + _updateRecipe + recipeId),
  //           headers: _getRequestHeader(token: masterProvider.getToken))
  //       .then((value) async {
  //     if (value.statusCode == 200) {
  //       var response = jsonDecode(value.body);
  //       recipeData = RecipeData.fromJson(response);
  //       masterProvider.setRecipeData = recipeData;
  //       print(recipeData.toJson());
  //     }
  //     return value.statusCode;
  //   }).catchError((onError) {
  //     handleOnError(onError, masterProvider);
  //     print(onError);
  //     return -1;
  //   });
  // }

  // static Future<int> getUsersById(
  //     UserData userData, MasterProvider masterProvider, String id) async {
  //   return await http
  //       .get(Uri.parse(_baseUrl + _getUserById + id),
  //           headers: _getRequestHeader(token: masterProvider.getToken))
  //       .then((value) async {
  //     if (value.statusCode == 200) {
  //       var response = jsonDecode(value.body);
  //       userData = UserData.fromJson(response);
  //       masterProvider.setUserdata = userData;
  //     }
  //     return value.statusCode;
  //   }).catchError((onError) {
  //     handleOnError(onError, masterProvider);
  //     print(onError);
  //     return -1;
  //   });
  // }

  Future<List<RecipeData>> searchRecipe(List ingredients) async {
    List recipeDatas = [];
    return await http
        .post(Uri.parse(_baseUrl + _searchRecipe),
            headers: _getRequestHeader(),
            body: jsonEncode({"keywords": ingredients}))
        .then((value) async {
      if (value.statusCode == 200) {
        var response = jsonDecode(value.body);
        for (var recipelists in response) {
          recipeDatas.add(RecipeData.fromJson(recipelists));
        }

        return recipeDatas;
      }
    }).catchError((onError) {
      // handleOnError(onError);
      print(onError);
      return null;
    });
  }

  // static Future<int> getUsers(
  //     UserData userData, MasterProvider masterProvider) async {
  //   return await http
  //       .get(Uri.parse(_baseUrl + _getUsers),
  //           headers: _getRequestHeader(token: masterProvider.getToken))
  //       .then((value) async {
  //     if (value.statusCode == 200) {
  //       var response = jsonDecode(value.body);
  //       userData = UserData.fromJson(response);
  //       masterProvider.setUserdata = userData;
  //     }
  //     return value.statusCode;
  //   }).catchError((onError) {
  //     handleOnError(onError, masterProvider);
  //     print(onError);
  //     return -1;
  //   });
  // }

  // static Future<int> getRecipes(
  //     RecipeData recipeData, MasterProvider masterProvider) async {
  //   return await http
  //       .get(Uri.parse(_baseUrl + _getRecipes),
  //           headers: _getRequestHeader(token: masterProvider.getToken))
  //       .then((value) async {
  //     if (value.statusCode == 200) {
  //       var response = jsonDecode(value.body);
  //       recipeData = RecipeData.fromJson(response);
  //       masterProvider.setRecipeData = recipeData;
  //     }
  //     return value.statusCode;
  //   }).catchError((onError) {
  //     handleOnError(onError, masterProvider);
  //     print(onError);
  //     return -1;
  //   });
  // }

  // static Future<int> getMyRecipes(
  //     RecipeData recipeData, MasterProvider masterProvider, String id) async {
  //   Map<String, dynamic> payload = JwtDecoder.decode(masterProvider.getToken);
  //   String id = payload["id"];
  //   return await http
  //       .get(Uri.parse(_baseUrl + _getMyRecipes + id),
  //           headers: _getRequestHeader(token: masterProvider.getToken))
  //       .then((value) async {
  //     if (value.statusCode == 200) {
  //       var response = jsonDecode(value.body);
  //       recipeData = RecipeData.fromJson(response);
  //       masterProvider.setRecipeData = recipeData;
  //     }
  //     return value.statusCode;
  //   }).catchError((onError) {
  //     handleOnError(onError, masterProvider);
  //     print(onError);
  //     return -1;
  //   });
  // }

  // static Future<int> getMySavedRecipes(
  //     RecipeData recipeData, MasterProvider masterProvider, String id) async {
  //   Map<String, dynamic> payload = JwtDecoder.decode(masterProvider.getToken);
  //   String id = payload["id"];
  //   return await http
  //       .get(Uri.parse(_baseUrl + _getMySavedRecipes + id),
  //           headers: _getRequestHeader(token: masterProvider.getToken))
  //       .then((value) async {
  //     if (value.statusCode == 200) {
  //       var response = jsonDecode(value.body);
  //       recipeData = RecipeData.fromJson(response);
  //       masterProvider.setRecipeData = recipeData;
  //     }
  //     return value.statusCode;
  //   }).catchError((onError) {
  //     handleOnError(onError, masterProvider);
  //     print(onError);
  //     return -1;
  //   });
  // }

  static handleOnError(dynamic onError) {
    print(onError);
    if (onError is SocketException) {
      // masterProvider.setLoading = false;
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
