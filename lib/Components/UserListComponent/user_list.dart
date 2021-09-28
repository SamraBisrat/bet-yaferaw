import 'package:bet_yaferaw/Components/UserListComponent/bloc/user_list_bloc.dart';
import 'package:bet_yaferaw/Components/UserListComponent/bloc/user_list_event.dart';
import 'package:bet_yaferaw/Components/UserListComponent/bloc/user_list_state.dart';
import 'package:bet_yaferaw/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserList extends StatefulWidget {
  @override
  _UserListState createState() => _UserListState();
}

class _UserListState extends State<UserList> {
  List<TableRow> userDetails = [];
  bool deleted;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: BlocProvider(
              create: (context) => UserListBloc(),
              child: BlocConsumer<UserListBloc, UserListState>(
                  builder: buildForState,
                  listener: (blocContext, blocState) {
                    if (blocState.users != null) {
                      print("null");
                    } else {
                      if (blocState.isDeleted) {
                        deleted = true;
                      } else {
                        deleted = false;
                      }
                    }
                  }))),
    );
  }

  Widget buildForState(blocContext, UserListState blocState) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    if (blocState.users != null) {
      for (var detail in blocState.users) {
        userDetails.add(TableRow(children: [
          TableCell(
              child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 8.0),
                  child: CircleAvatar(
                      backgroundColor: Color(0xff82B242),
                      radius: 15.0,
                      child: Center(
                          child: Text(
                              detail.firstname == null
                                  ? ""
                                  : detail.firstname
                                      .substring(0, 1)
                                      .toUpperCase(),
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w900,
                                  fontSize: 12)))))),
          TableCell(
            child: Padding(
                padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 5),
                child: Text(detail.firstname == null ? "" : detail.firstname)),
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
                      blocState.users
                          .removeWhere((element) => detail.id == element.id);

                      BlocProvider.of<UserListBloc>(blocContext)
                          .add(DeleteUser(detail.id));
                    },
                    icon: Icon(
                      Icons.delete_outline,
                      color: AppTheme.primaryColor,
                    ),
                  )))
        ]));
      }
    }
    if (blocState.isLoading == false) {
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
                              "There are a total of ${blocState.users == null ? '0' : blocState.users.length} registered users.",
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
                        children: userDetails == null ? [] : userDetails,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ));
    } else {
      return Center(
        child: CircularProgressIndicator(),
      );
    }
  }
}
