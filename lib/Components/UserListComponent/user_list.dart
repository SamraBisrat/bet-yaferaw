import 'package:bet_yaferaw/theme/app_theme.dart';
import 'package:flutter/material.dart';

class UserList extends StatefulWidget {
  @override
  _UserListState createState() => _UserListState();
}

class _UserListState extends State<UserList> {
  List<UserDatas> userData = [
    UserDatas(fname: "zew", email: "zew@gmail.com"),
    UserDatas(fname: "red", email: "red@gmail.com"),
    UserDatas(fname: "sam", email: "sam@gmail.com")
  ];
  List<TableRow> userDetails = [];

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    for (var detail in userData) {
      userDetails.add(TableRow(children: [
        TableCell(
            child: Padding(
                padding: EdgeInsets.symmetric(vertical: 8.0),
                child: CircleAvatar(
                    backgroundColor: Color(0xff82B242),
                    radius: 15.0,
                    child: Center(
                        child: Text(
                            detail.fname == null
                                ? ""
                                : detail.fname.substring(0, 1).toUpperCase(),
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w900,
                                fontSize: 12)))))),
        TableCell(
          child: Padding(
              padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 5),
              child: Text(detail.fname == null ? "" : detail.fname)),
        ),
        TableCell(
          child: Padding(
              padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 5),
              child: Text(detail.email == null ? "" : detail.email)),
        ),
        TableCell(
            child: Padding(
                padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 5),
                child: IconButton(
                  onPressed: () {
                    userData
                        .removeWhere((element) => detail.email == detail.email);
                  },
                  icon: Icon(
                    Icons.delete_outline,
                    color: AppTheme.primaryColor,
                  ),
                )))
      ]));
    }
    return Scaffold(
        backgroundColor: Colors.white,
        body: Container(
          margin: MediaQuery.of(context).padding,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  child: Container(
                    padding: EdgeInsets.all(10),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Align(
                            alignment: Alignment.topLeft,
                            child: IconButton(
                              padding: EdgeInsets.all(0),
                              icon: Icon(
                                Icons.arrow_back,
                                color: Colors.white,
                                size: 25,
                              ),
                              onPressed: () {
                                Navigator.pop(context);
                              },
                            ),
                          ),
                          // toolbarHeight: 20,

                          Text(
                            "Administrator's User Monitoring Page",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.w800),
                          ),
                          Text(
                            "There are a total of {9} registered users.",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 13,
                                fontWeight: FontWeight.w500),
                          )
                        ],
                      ),
                    ),
                    height: height / 6,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        gradient: LinearGradient(
                          colors: [Color(0xffa40606), Color(0xffd98324)],
                        )),
                    width: width,
                  ),
                ),
                Container(
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(20)),
                  width: width,
                  child: Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    elevation: 12,
                    child: Table(
                      border: TableBorder(
                          verticalInside: BorderSide(
                              width: 1,
                              color: Colors.white,
                              style: BorderStyle.solid)),
                      defaultVerticalAlignment:
                          TableCellVerticalAlignment.middle,
                      defaultColumnWidth: IntrinsicColumnWidth(),
                      children: userDetails == null ? null : userDetails,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}

class UserDatas {
  String fname;
  String email;

  UserDatas({this.fname, this.email});
}
