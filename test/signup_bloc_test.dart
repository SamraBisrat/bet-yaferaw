import 'package:bet_yaferaw/Model/user.dart';
import 'package:bet_yaferaw/Repositories/login_repo.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bet_yaferaw/Components/SignupComponent/bloc/signup_bloc.dart';
import 'package:bet_yaferaw/Components/SignupComponent/bloc/signup_event.dart';
import 'package:bet_yaferaw/Components/SignupComponent/bloc/signup_state.dart';

void main() {
  group("signup bloc", () {
    UserRepository userRepository;
    userRepository = UserRepository();
    SignupBloc signupBloc;
    signupBloc = SignupBloc(userRepository: userRepository);

    blocTest("emits [SignupButtonPressed]  when signup successful",
        build: () => SignupBloc(userRepository: userRepository),
        act: (signupBloc) => signupBloc.add(SignupButtonPressed(
                userData: UserData(
              firstname: "zewetir",
              lastname: "mebrat",
              email: "zet@gmail.com",
              password: "11223344",
              // imageid: null,
            ))),
        expect: [
          isA<SignupState>(),
          isA<SignupState>(),
        ]);
  });
}
