import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class CameraScannerInformation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Container(
      color: Color(0xffC4C4C4).withOpacity(0.18),
      alignment: Alignment.center,
      child: SizedBox(
        height: height / 5,
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          ListTile(
              leading: Container(
                height: 70,
                width: 70,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("assets/images/image 4.png"),
                        fit: BoxFit.cover)),
              ),
              title: Wrap(children: [
                Text('You have ingredients but you \ndon’t know what to cook?',
                    style: TextStyle(color: Color(0xff2D0C57), fontSize: 15))
              ]),
              subtitle: Wrap(children: [
                RichText(
                    text: TextSpan(
                        text: 'Use ingredient scanner'.toUpperCase(),
                        style: TextStyle(
                          decoration: TextDecoration.underline,
                          color: Color(0xff0BCE83),
                          fontSize: 15,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            print("hellow");
                          })),
              ])),
        ]),
      ),
    );
  }
}
