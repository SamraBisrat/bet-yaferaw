import 'dart:convert';

List<UserData> userDataFromJson(String str) =>
    List<UserData>.from(json.decode(str).map((x) => UserData.fromJson(x)));

String userDataToJson(List<UserData> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class UserData {
  UserData(
      {this.id,
      this.firstname,
      this.lastname,
      this.password,
      this.email,
      this.imageid,
      this.recipescreated,
      this.savedrecipes,
      this.totallikes});

  String id;
  String firstname;
  String lastname;
  String password;
  String email;
  String imageid;
  List totallikes;
  List recipescreated;
  List savedrecipes;

  factory UserData.fromJson(Map<String, dynamic> json) => UserData(
      id: json["id"],
      firstname: json["firstname"],
      lastname: json["lastname"],
      password: json["password"],
      email: json["email"],
      imageid: json["imageid"],
      totallikes: json["totallikes"],
      recipescreated: json["recipescreated"],
      savedrecipes: json["savedrecipes"]);

  Map<String, dynamic> toJson() => {
        "firstname": firstname,
        "lastname": lastname,
        "password": password,
        "email": email,
        "imageid": imageid,
        "totallikes": totallikes,
        "recipescreated": recipescreated,
        "savedrecipes": savedrecipes
      };
}
