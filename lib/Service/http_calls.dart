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
  static const String _getRecipeById = "/recipe/id?recipeid=";
  static const String _getUsers = "/get/users";
  static const String _getRecipes = "/get/recipes";
  static const String _getMyRecipes = "/recipes/userid";
  static const String _getMySavedRecipes = "/recipes/saved";
  static const String _getExploreRecipe = "/get/explore/recipe";

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
        print("token in shared pref login");
        print(await SharedPref.getToken());
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
      return null;
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
  Future<String> createRecipe(RecipeData recipeData) async {
    return await http
        .post(Uri.parse(_baseUrl + _createRecipe),
            headers: _getRequestHeader(token: await getToken()),
            body: jsonEncode(recipeData.toJson()))
        .then((value) async {
      print(value.statusCode);
      if (value.statusCode == 200) {
        var response = jsonDecode(value.body);
        print(response);
        return response;
      }
      return null;
    }).catchError((onError) {
      print(onError);
      return null;
    });
  }

  Future<RecipeData> getRecipeById(String id) async {
    print(_baseUrl + _getRecipeById + id);
    return await http
        .get(Uri.parse(_baseUrl + _getRecipeById + id),
            headers: _getRequestHeader())
        .then((value) async {
      print("header");
      print(value.statusCode);
      if (value.statusCode == 200) {
        var response = jsonDecode(value.body);
        RecipeData recipeData = RecipeData.fromJson(response);
        print(recipeData);
        return recipeData;
      }
      return null;
    }).catchError((onError) {
      print(onError);
      return null;
    });
  }

  Future<UserData> getMyAccount() async {
    return await http
        .get(Uri.parse(_baseUrl + _myAccount),
            headers: _getRequestHeader(token: await getToken()))
        .then((value) async {
      print("header");
      print(await getToken());

      print(value.statusCode);
      if (value.statusCode == 200) {
        var response = jsonDecode(value.body);
        UserData userData = UserData.fromJson(response);
        // masterProvider.setUserdata = userData;
        await SharedPref.storeMyData(
            "userData", json.encode(userData.toJson()));
        print(userData.toJson());

        return userData;
      }
      return null;
    }).catchError((onError) {
      // handleOnError(onError, masterProvider);
      print(onError);
      return null;
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
    List<RecipeData> recipeDatas = [];
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
      return null;
    }).catchError((onError) {
      // handleOnError(onError);
      print(onError);
      return null;
    });
  }

  Future<List<RecipeData>> getExploreRecipe() async {
    List<RecipeData> exploredRecipes = [];
    return await http
        .get(Uri.parse(_baseUrl + _getExploreRecipe),
            headers: _getRequestHeader())
        .then((value) async {
      if (value.statusCode == 200) {
        var response = jsonDecode(value.body);
        for (var recipelists in response) {
          exploredRecipes.add(RecipeData.fromJson(recipelists));
        }
        print(exploredRecipes);
        return exploredRecipes;
      }
      return null;
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

  Future<List<RecipeData>> getMyRecipes() async {
    List<RecipeData> myRecipes = [];

    return await http
        .get(Uri.parse(_baseUrl + _getMyRecipes),
            headers: _getRequestHeader(token: await getToken()))
        .then((value) async {
      if (value.statusCode == 200) {
        var response = jsonDecode(value.body);
        for (var recipelists in response) {
          myRecipes.add(RecipeData.fromJson(recipelists));
        }
        return myRecipes;
      }

      return null;
    }).catchError((onError) {
      print(onError);
      return null;
    });
  }

  Future<List<RecipeData>> getMySavedRecipes() async {
    List<RecipeData> savedRecipes = [];
    return await http
        .get(Uri.parse(_baseUrl + _getMySavedRecipes),
            headers: _getRequestHeader(token: await getToken()))
        .then((value) async {
      if (value.statusCode == 200) {
        var response = jsonDecode(value.body);
        for (var recipelists in response) {
          savedRecipes.add(RecipeData.fromJson(recipelists));
        }
        return savedRecipes;
      }
      return null;
    }).catchError((onError) {
      print(onError);
      return null;
    });
  }

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
