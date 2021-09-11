import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  // LoginBloc  loginBloc;
  group("login bloc", () {
    blocTest(
      "emits [isLoading, LoginButtonPressed] when login successful",
      // build: () => LoginBloc());
      // act: loginBloc.add(LoginEvent.LoginButtonPressed),
      // expect: ()=>[isLoading, LoginButtonPressed]'
    );
  });
}
