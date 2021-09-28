import 'dart:convert';

import 'package:bet_yaferaw/Model/user.dart';
import 'package:bet_yaferaw/Repositories/bottom_nav_repo.dart';
import 'package:bet_yaferaw/ReusableComponents/bloc/bottom_nav_event.dart';
import 'package:bet_yaferaw/ReusableComponents/bloc/bottom_nav_state.dart';
import 'package:bet_yaferaw/Service/shared_pref.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BottomNavBloc extends Bloc<BottomNavEvent, BottomNavState> {
  BottomNavRepository bottomNavRepository = BottomNavRepository();

  BottomNavBloc() : super(BottomNavState(index: 0, isInitialStart: true)) {
    add(BottomNavIcon());
  }

  @override
  Stream<BottomNavState> mapEventToState(BottomNavEvent event) async* {
    var user;
    await SharedPref.getMyData("userData").then((value) {
      if (!(value == "")) {
        Map<String, dynamic> userData = jsonDecode(value);
        user = UserData.fromJson(userData);
        print(user["firstname"]);
        print("insidse bottom nav repo");
        return user;
      } else {
        return user;
      }
    }).catchError((onError) {
      return null;
    });
    if (event is BottomNavIcon) {
      print("response in bottom nav bloc");
      // print(response);
      if (user != null) {
        yield state.copyWith(userData: user);
      } else {
        yield state.copyWith(userData: null);
      }
    } else if (event is ChangeIndex) {
      yield state.copyWith(
          index: event.index, isInitialStart: false, userData: user);
    }
  }
}
