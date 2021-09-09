import 'package:bet_yaferaw/Components/HomeComponent/home.dart';
import 'package:bet_yaferaw/Components/SignupComponent/signup.dart';
import 'package:bet_yaferaw/Provider/MasterProvider.dart';
import 'package:bet_yaferaw/ReusableComponents/snack_bar.dart';
import 'package:bet_yaferaw/Service/http_calls.dart';
import 'package:bet_yaferaw/theme/app_theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // MasterProvider masterProvider =
    //     Provider.of<MasterProvider>(context, listen: false);
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
                    color: AppTheme.primaryColor,
                    width: width,
                    height: height * 0.4,
                    child: SvgPicture.asset(
                      'assets/images/Ellipses.svg',
                      fit: BoxFit.fill,
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
                          "Welcome Back",
                          style: AppTheme.headline,
                          textAlign: TextAlign.left,
                        ),
                        SizedBox(height: 30.0),
                        TextField(
                          controller: emailController,
                          decoration: InputDecoration(
                              hintText: 'Email',
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
                          controller: passwordController,
                          obscureText: true,
                          decoration: InputDecoration(
                              hintText: 'password',
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
                        SizedBox(height: 100),
                        // Consumer<MasterProvider>(
                        //     builder: ((context, provider, child) {
                        // return provider.getLoading
                        //     ? CircularProgressIndicator()
                        ElevatedButton(
                            child: Text(
                              "Login",
                              style: TextStyle(color: Colors.white),
                            ),
                            style: ButtonStyle(
                                padding: MaterialStateProperty.all<EdgeInsets>(
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
                              // provider.setLoading = true;
                              // int code = await HttpCalls.login(
                              //     emailController.text,
                              //     passwordController.text,
                              //     masterProvider);

                              // provider.setLoading = false;

                              //     if (code == 200) {
                              //       print(passwordController.text);
                              //       print(emailController.text);
                              //       print(provider.getToken);
                              //       Navigator.push(
                              //           context,
                              //           MaterialPageRoute(
                              //               builder: (context) => Home()));
                              //     } else if (code == 503) {
                              //       YRSnackBar(
                              //               title: "Please",
                              //               errorMessage:
                              //                   "Enter the correct password and email")
                              //           .showSnachkBar(context);
                              //       provider.setLoading = false;
                              //       print("error else if $code");
                              //     } else {
                              //       provider.setLoading = false;
                              //       print("error else $code");
                              //     }
                              //   },
                              // );
                            }),
                        SizedBox(height: 30),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Signup()));
                          },
                          child: Text(
                            "Don't have an account? Signup".toUpperCase(),
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
