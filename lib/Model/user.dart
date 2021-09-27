import 'dart:convert';

List<UserData> userDataFromJson(String str) =>
    List<UserData>.from(json.decode(str).map((x) => UserData.fromJson(x)));

String userDataToJson(List<UserData> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class UserData {
  UserData(
      {this.id,
      this.intid,
      this.firstname,
      this.lastname,
      this.password,
      this.email,
      this.imageid,
      this.recipescreated,
      this.savedrecipes,
      this.totallikes,
      this.role});

  String id;
  int intid;
  String firstname;
  String lastname;
  String password;
  String email;
  String imageid;
  int totallikes;
  List recipescreated;
  List savedrecipes;
  String role;

  factory UserData.fromJson(Map<String, dynamic> json) => UserData(
      id: json["id"],
      intid: json["intid"],
      firstname: json["firstname"],
      lastname: json["lastname"],
      password: json["password"],
      email: json["email"],
      imageid: json["imageid"],
      totallikes: json["totallikes"],
      recipescreated: json["recipescreated"],
      savedrecipes: json["savedrecipes"],
      role: json["roles"]);

  Map<String, dynamic> toJson() => {
        "id": id,
        "firstname": firstname,
        "lastname": lastname,
        "password": password,
        "email": email,
        "imageid": imageid,
        "totallikes": totallikes,
        "recipescreated": recipescreated,
        "savedrecipes": savedrecipes,
      };
}
