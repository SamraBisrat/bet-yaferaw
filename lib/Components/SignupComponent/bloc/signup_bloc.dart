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
      yield state.copyWith(isLoading: true, userData: event.userData);

      String response = await userRepository.createUser(event.userData);
      print(response);

      if (response != null) {
        print(response);
        yield state.copyWith(isLoading: false, userData: event.userData);
      } else {
        yield state.copyWith(
            isLoading: false, exceptionError: "unable to signup");
      }
    }
  }
}
