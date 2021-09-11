import 'package:equatable/equatable.dart';

abstract class LoginEvents extends Equatable {
  const LoginEvents();
}

class LoginButtonPressed extends LoginEvents {
  final String email;
  final String password;

  LoginButtonPressed(this.email, this.password);

  @override
  List<Object> get props => [email, password];
}
