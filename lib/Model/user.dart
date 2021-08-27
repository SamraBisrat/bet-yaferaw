import 'dart:convert';

List<UserData> userDataFromJson(String str) =>
    List<UserData>.from(json.decode(str).map((x) => UserData.fromJson(x)));

String userDataToJson(List<UserData> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class UserData {
  UserData({this.id, this.firstname, this.lastname, this.password, this.email});

  String id;
  String firstname;
  String lastname;
  String password;
  String email;

  factory UserData.fromJson(Map<String, dynamic> json) => UserData(
      id: json["id"],
      firstname: json["firstname"],
      lastname: json["lastname"],
      password: json["password"],
      email: json["email"]);

  Map<String, dynamic> toJson() => {
        "firstname": firstname,
        "lastname": lastname,
        "password": password,
        "email": email
      };
}
