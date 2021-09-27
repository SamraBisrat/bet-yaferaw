import 'package:bet_yaferaw/Components/SignupComponent/bloc/signup_event.dart';
import 'package:bet_yaferaw/Components/SignupComponent/bloc/signup_state.dart';
import 'package:bet_yaferaw/Model/user.dart';
import 'package:bet_yaferaw/Repositories/login_repo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignupBloc extends Bloc<SignUpEvent, SignupState> {
  UserRepository userRepository = UserRepository();

  SignupBloc({@required this.userRepository})
      : super(SignupState(isLoading: false));

  // LoginState get initialState => LoginState(isLoading: false);

  @override
  Stream<SignupState> mapEventToState(SignUpEvent event) async* {
    if (event is SignupButtonPressed) {
      yield state.copyWith(
        isLoading: true,
        userData: event.userData,
        imageFile: event.imageFile,
      );
      String imageResponse =
          await userRepository.uploadProfileImage(event.imageFile);
      if (imageResponse.toString() != null) {
        event.userData.imageid = imageResponse;
        String response = await userRepository.createUser(event.userData);
        if (response != null) {
          yield state.copyWith(
              isLoading: false,
              userData: event.userData,
              image: imageResponse,
              signed: true);
        } else {
          yield state.copyWith(
              isLoading: false,
              exceptionError: "unable to signup",
              signed: false);
        }
      } else {
        yield state.copyWith(
            isLoading: false,
            exceptionError: "unable to signup",
            signed: false);
      }
    }
  }
}
