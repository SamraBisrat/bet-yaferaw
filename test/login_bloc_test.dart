import 'package:bet_yaferaw/Components/LoginComponent/bloc/login_event.dart';
import 'package:bet_yaferaw/Components/LoginComponent/bloc/login_state.dart';
import 'package:bet_yaferaw/Repositories/login_repo.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bet_yaferaw/Components/LoginComponent/bloc/login_bloc.dart';

void main() {
  group("login bloc", () {
    UserRepository userRepository;
    userRepository = UserRepository();
    LoginBloc loginBloc;
    loginBloc = LoginBloc(userRepository: userRepository);
    blocTest("emits[LoginButtonPressed]  when login successful",
        build: () => LoginBloc(userRepository: userRepository),
        act: (loginBloc) =>
            loginBloc.add(LoginButtonPressed("mek@gmail.com", "mek123")),
        expect: [
          LoginState(
              email: "mek@gmail.com",
              password: 'mek123',
              isLoading: true,
              exceptionError: null,
              tokenSaved: null),
          LoginState(
              email: "mek@gmail.com",
              password: 'mek123',
              isLoading: false,
              exceptionError: null,
              tokenSaved: true),
        ]);
  });
}
