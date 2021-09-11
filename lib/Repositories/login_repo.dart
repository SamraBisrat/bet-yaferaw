import 'package:bet_yaferaw/Model/user.dart';
import 'package:bet_yaferaw/Service/http_calls.dart';

class UserRepository {
  HttpCalls _httpCalls = HttpCalls();

  Future<String> login(String email, String password) =>
      _httpCalls.login(email, password);

  Future<UserData> createUser(UserData userData) =>
      _httpCalls.createUser(userData);
}
