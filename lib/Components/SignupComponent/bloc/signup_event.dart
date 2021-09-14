import 'dart:io';

import 'package:bet_yaferaw/Model/user.dart';
import 'package:equatable/equatable.dart';

abstract class SignUpEvent extends Equatable {
  const SignUpEvent();
}

class SignupButtonPressed extends SignUpEvent {
  const SignupButtonPressed({this.userData, this.imageFile});
  final File imageFile;

  final UserData userData;

  @override
  List<Object> get props => [userData, imageFile];
}
