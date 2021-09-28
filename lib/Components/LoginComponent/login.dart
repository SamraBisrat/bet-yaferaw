import 'package:bet_yaferaw/Components/HomeComponent/home.dart';
import 'package:bet_yaferaw/Components/LoginComponent/bloc/login_bloc.dart';
import 'package:bet_yaferaw/Components/LoginComponent/bloc/login_event.dart';
import 'package:bet_yaferaw/Components/LoginComponent/bloc/login_state.dart';
import 'package:bet_yaferaw/Components/SignupComponent/signup.dart';
// import 'package:bet_yaferaw/Provider/MasterProvider.dart';
import 'package:bet_yaferaw/Repositories/login_repo.dart';
import 'package:bet_yaferaw/ReusableComponents/snack_bar.dart';
// import 'package:bet_yaferaw/Service/http_calls.dart';
// import 'package:bet_yaferaw/Service/shared_pref.dart';
import 'package:bet_yaferaw/theme/app_theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
    return Scaffold(
      body: SafeArea(
          child: BlocProvider(
              create: (context) => LoginBloc(userRepository: UserRepository()),
              child: BlocConsumer<LoginBloc, LoginState>(
                  builder: buildForState,
                  listener: (blocContext, blocState) async {
                    if (blocState.tokenSaved == null) {
                      print("is null");
                    } else {
                      if (blocState.tokenSaved == true) {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => Home()));
                      } else if (blocState.tokenSaved == false) {
                        YRSnackBar(
                                errorMessage:
                                    'Unable tp login, user your correct credentials')
                            .showSnachkBar(context);
                      } else {}
                    }
                  }))),
    );
  }

  Widget buildForState(blocContext, LoginState blocState) {
    // MasterProvider masterProvider =
    //     Provider.of<MasterProvider>(context, listen: false);
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
        body: SingleChildScrollView(
      child: Container(
        color: AppTheme.primaryColor,
        width: width,
        // height: height,
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
                    keyboardType: TextInputType.emailAddress,
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
                            borderSide: BorderSide(color: AppTheme.lightGrey))),
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
                            borderSide: BorderSide(color: AppTheme.lightGrey))),
                  ),
                  SizedBox(height: 100),
                  // Consumer<MasterProvider>(
                  //     builder: ((context, provider, child) {
                  // return provider.getLoading
                  //     ? CircularProgressIndicator()

                  blocState.isLoading
                      ? CircularProgressIndicator()
                      : ElevatedButton(
                          child: Text(
                            "Login",
                            style: TextStyle(color: Colors.white),
                          ),
                          style: ButtonStyle(
                              padding: MaterialStateProperty.all<EdgeInsets>(
                                  EdgeInsets.all(20)),
                              alignment: Alignment.center,
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  AppTheme.buttonSecondary),
                              shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8)))),
                          onPressed: () {
                            Pattern pattern =
                                r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

                            RegExp regex = new RegExp(pattern);
                            print("email ${emailController.text}");

                            if (!regex.hasMatch(emailController.text) ||
                                emailController.text == '') {
                              YRSnackBar(
                                      errorMessage:
                                          "Please enter a valid email address!")
                                  .showSnachkBar(context);
                            } else if (passwordController.text == '') {
                              YRSnackBar(
                                      errorMessage:
                                          "Please enter your password!")
                                  .showSnachkBar(context);
                            } else {
                              BlocProvider.of<LoginBloc>(blocContext).add(
                                  LoginButtonPressed(emailController.text,
                                      passwordController.text));
                            }
                          }),
                  SizedBox(height: 30),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(blocContext,
                          MaterialPageRoute(builder: (context) => Signup()));
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
      ),
    ));
  }
}
