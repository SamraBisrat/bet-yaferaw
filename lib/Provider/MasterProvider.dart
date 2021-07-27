import 'package:flutter/material.dart';

class MasterProvider extends ChangeNotifier {
  bool _liked = false;
  bool get getliked => _liked;
  set setliked(bool value) {
    _liked = value;
    notifyListeners();
  }

  void checkIfFavorite(bool liked) {
    if (liked == true) {
      setliked = false;
    } else {
      setliked = true;
    }
    notifyListeners();
  }
}
