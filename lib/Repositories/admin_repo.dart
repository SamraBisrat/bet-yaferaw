import 'package:bet_yaferaw/Service/http_calls.dart';

class AdminRepository {
  HttpCalls _httpCalls = HttpCalls();
  Future<int> deleteUser(String id) => _httpCalls.deleteUser(id);
}
  