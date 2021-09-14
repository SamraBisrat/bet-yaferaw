import 'dart:io';

import 'package:bet_yaferaw/Model/user.dart';
import 'package:bet_yaferaw/Service/http_calls.dart';

class UserRepository {
  HttpCalls _httpCalls = HttpCalls();

  Future<String> login(String email, String password) =>
      _httpCalls.login(email, password);

  Future<String> createUser(UserData userData) =>
      _httpCalls.createUser(userData);
  Future<String> uploadProfileImage(File image) =>
      _httpCalls.uploadProfileImage(image);
}
