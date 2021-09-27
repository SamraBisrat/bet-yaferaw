import 'package:bet_yaferaw/Components/LoginComponent/bloc/login_event.dart';
import 'package:bet_yaferaw/Repositories/login_repo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'login_state.dart';

class LoginBloc extends Bloc<LoginEvents, LoginState> {
  UserRepository userRepository = UserRepository();

  LoginBloc({@required this.userRepository})
      : super(LoginState(isLoading: false));

  // LoginState get initialState => LoginState(isLoading: false);

  @override
  Stream<LoginState> mapEventToState(LoginEvents event) async* {
    if (event is LoginButtonPressed) {
      yield state.copyWith(
          isLoading: true, email: event.email, password: event.password);

      String response = await userRepository.login(event.email, event.password);

      print(response);

      if (response != null) {
        yield state.copyWith(isLoading: false, tokenSaved: true);
      } else {
        yield state.copyWith(
            isLoading: false, exceptionError: response, tokenSaved: false);
      }
    }
  }
}
