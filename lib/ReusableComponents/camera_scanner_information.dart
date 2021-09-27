import 'dart:io';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_cropper/image_cropper.dart';

class CameraScannerInformation extends StatefulWidget {
  final Function uploadFile;

  CameraScannerInformation(this.uploadFile);

  @override
  _CameraScannerInformationState createState() =>
      _CameraScannerInformationState();
}

class _CameraScannerInformationState extends State<CameraScannerInformation> {
  final ImagePicker _picker = ImagePicker();
  File imageUrl;

  Future pickImageFromCamera(BuildContext context) async {
    XFile image = await _picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      setState(() {
        _cropImage(image);
      });
    }
  }

  Future<Null> _cropImage(XFile cropped) async {
    // var img = Image.file(File(cropped.path));
    File croppedFile = await ImageCropper.cropImage(
        sourcePath: cropped.path,
        cropStyle: CropStyle.rectangle,
        aspectRatioPresets: Platform.isAndroid
            ? [
                CropAspectRatioPreset.square,
              ]
            : [
                CropAspectRatioPreset.square,
              ],
        androidUiSettings: AndroidUiSettings(
            toolbarTitle: 'Cropper',
            toolbarColor: Color(0xff82B242),
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.square,
            lockAspectRatio: true),
        iosUiSettings: IOSUiSettings(
          title: 'Cropper',
        ));
    if (croppedFile != null) {
      imageUrl = croppedFile;

      setState(() {
        imageUrl = croppedFile;
        widget.uploadFile(imageUrl);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
          color: Color(0xffC4C4C4).withOpacity(0.18),
          borderRadius: BorderRadius.circular(8)),
      child: SizedBox(
        height: height / 6,
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          // Container(child: imageUrl != null ? Image.file(imageUrl) : null),
          ListTile(
              leading: GestureDetector(
                onTap: () {},
                child: Container(
                  height: 70,
                  width: 70,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage("assets/images/image 4.png"),
                          fit: BoxFit.cover)),
                ),
              ),
              title: Wrap(children: [
                Text('You have ingredients but you don’t know what to cook?',
                    style: TextStyle(color: Color(0xff2D0C57), fontSize: 15))
              ]),
              subtitle: Wrap(children: [
                Padding(
                    padding: EdgeInsets.only(top: 10),
                    child: RichText(
                        text: TextSpan(
                            text: 'Use ingredient scanner'.toUpperCase(),
                            style: TextStyle(
                              decoration: TextDecoration.underline,
                              color: Color(0xff0BCE83),
                              fontSize: 15,
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                pickImageFromCamera(context);
                              }))),
              ])),
        ]),
      ),
    );
  }
}
