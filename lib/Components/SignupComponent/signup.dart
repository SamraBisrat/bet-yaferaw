import 'package:bet_yaferaw/Components/LoginComponent/login.dart';
import 'package:bet_yaferaw/Provider/MasterProvider.dart';
import 'package:bet_yaferaw/Service/http_calls.dart';
import 'package:bet_yaferaw/theme/app_theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

class Signup extends StatefulWidget {
  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  TextEditingController firstName = TextEditingController();
  TextEditingController lastName = TextEditingController();
  TextEditingController emailAddress = TextEditingController();
  TextEditingController enterPassword = TextEditingController();
  TextEditingController reEnterPassword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    MasterProvider masterProvider =
        Provider.of<MasterProvider>(context, listen: false);
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
        body: Container(
            color: AppTheme.primaryColor,
            width: width,
            height: height,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    width: width,
                    height: height * 0.3,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage('assets/images/Ellipses-new.png'),
                            fit: BoxFit.fill)),
                    child: SvgPicture.asset(
                      'assets/images/account_circle.svg',
                      fit: BoxFit.none,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(40),
                    width: width,
                    height: height * 0.7,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            topLeft: const Radius.circular(40),
                            topRight: const Radius.circular(40))),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          "Hello! Welcome",
                          style: AppTheme.headline,
                          textAlign: TextAlign.left,
                        ),
                        SizedBox(height: 30.0),
                        TextField(
                          controller: firstName,
                          decoration: InputDecoration(
                              hintText: 'Enter your first name'.toUpperCase(),
                              prefixIcon: Padding(
                                padding: const EdgeInsets.fromLTRB(0, 0, 40, 0),
                                child: Icon(
                                  Icons.person,
                                  color: AppTheme.lightGrey,
                                ),
                              ),
                              enabledBorder: UnderlineInputBorder(
                                  borderSide:
                                      BorderSide(color: AppTheme.lightGrey))),
                        ),
                        SizedBox(height: 30.0),
                        TextField(
                          controller: lastName,
                          decoration: InputDecoration(
                              hintText: 'Enter your last name'.toUpperCase(),
                              prefixIcon: Padding(
                                padding: const EdgeInsets.fromLTRB(0, 0, 40, 0),
                                child: Icon(
                                  Icons.person,
                                  color: AppTheme.lightGrey,
                                ),
                              ),
                              enabledBorder: UnderlineInputBorder(
                                  borderSide:
                                      BorderSide(color: AppTheme.lightGrey))),
                        ),
                        SizedBox(height: 30.0),
                        TextField(
                          controller: emailAddress,
                          decoration: InputDecoration(
                              hintText:
                                  'Enter your email address'.toUpperCase(),
                              prefixIcon: Padding(
                                padding: const EdgeInsets.fromLTRB(0, 0, 40, 0),
                                child: Icon(
                                  Icons.email,
                                  color: AppTheme.lightGrey,
                                ),
                              ),
                              enabledBorder: UnderlineInputBorder(
                                  borderSide:
                                      BorderSide(color: AppTheme.lightGrey))),
                        ),
                        SizedBox(height: 30.0),
                        TextField(
                          controller: enterPassword,
                          obscureText: true,
                          decoration: InputDecoration(
                              hintText: 'Enter your password'.toUpperCase(),
                              prefixIcon: Padding(
                                padding: const EdgeInsets.fromLTRB(0, 0, 40, 0),
                                child: Icon(
                                  Icons.lock,
                                  color: AppTheme.lightGrey,
                                ),
                              ),
                              enabledBorder: UnderlineInputBorder(
                                  borderSide:
                                      BorderSide(color: AppTheme.lightGrey))),
                        ),
                        SizedBox(height: 30),
                        TextField(
                          controller: reEnterPassword,
                          obscureText: true,
                          decoration: InputDecoration(
                              hintText: 'Re-enter your password'.toUpperCase(),
                              prefixIcon: Padding(
                                padding: const EdgeInsets.fromLTRB(0, 0, 40, 0),
                                child: Icon(
                                  Icons.lock,
                                  color: AppTheme.lightGrey,
                                ),
                              ),
                              enabledBorder: UnderlineInputBorder(
                                  borderSide:
                                      BorderSide(color: AppTheme.lightGrey))),
                        ),
                        SizedBox(height: 50.0),
                        Consumer<MasterProvider>(
                            builder: ((context, provider, child) {
                          return provider.getLoading
                              ? CircularProgressIndicator()
                              : ElevatedButton(
                                  child: Text(
                                    "Signup",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  style: ButtonStyle(
                                      padding:
                                          MaterialStateProperty.all<EdgeInsets>(
                                              EdgeInsets.all(20)),
                                      alignment: Alignment.center,
                                      backgroundColor:
                                          MaterialStateProperty.all<Color>(
                                              AppTheme.buttonSecondary),
                                      shape: MaterialStateProperty.all<
                                              RoundedRectangleBorder>(
                                          RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(8)))),
                                  onPressed: () async {
                                    masterProvider.getUserData.firstname =
                                        firstName.text;
                                    masterProvider.getUserData.lastname =
                                        lastName.text;
                                    masterProvider.getUserData.email =
                                        emailAddress.text;
                                    masterProvider.getUserData.password =
                                        enterPassword.text;
                                    provider.setLoading = true;
                                    int code = await HttpCalls.createUser(
                                        masterProvider.getUserData,
                                        masterProvider);
                                    provider.setLoading = false;
                                    if (code == 200) {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => Login()));
                                    } else {
                                      print("sign up $code");
                                    }
                                  },
                                );
                        })),
                        SizedBox(height: 30),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Login()));
                          },
                          child: Text(
                            "Already have an account? Login".toUpperCase(),
                            style: TextStyle(color: AppTheme.textSecondary),
                            textAlign: TextAlign.center,
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            )));
  }
}
