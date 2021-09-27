import 'dart:io';

import 'package:bet_yaferaw/Model/user.dart';
import 'package:equatable/equatable.dart';

class SignupState extends Equatable {
  const SignupState(
      {this.userData,
      this.exceptionError,
      this.isLoading,
      this.image,
      this.imageFile,
      this.signed});
  final UserData userData;
  final bool isLoading;
  final String exceptionError;
  final String image;
  final File imageFile;
  final bool signed;

  @override
  List<Object> get props =>
      [userData, isLoading, exceptionError, image, imageFile, signed];

  SignupState copyWith(
      {UserData userData,
      String exceptionError,
      bool isLoading,
      String image,
      File imageFile,
      bool signed}) {
    return SignupState(
        userData: userData ?? this.userData,
        isLoading: isLoading ?? this.isLoading,
        exceptionError: exceptionError ?? this.exceptionError,
        image: image ?? this.image,
        imageFile: imageFile ?? this.imageFile,
        signed: signed ?? this.signed);
  }
}
