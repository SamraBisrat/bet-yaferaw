import 'package:equatable/equatable.dart';

class LoginState extends Equatable {
  const LoginState(
      {this.email,
      this.password,
      this.exceptionError,
      this.isLoading,
      this.tokenSaved});
  final String email;
  final String password;
  final bool isLoading;
  final String exceptionError;
  final bool tokenSaved;

  @override
  List<Object> get props =>
      [email, password, isLoading, exceptionError, tokenSaved];

  LoginState copyWith(
      {String email,
      String password,
      bool isLoading,
      String exceptionError,
      bool tokenSaved}) {
    return LoginState(
        email: email ?? this.email,
        password: password ?? this.password,
        isLoading: isLoading ?? this.isLoading,
        exceptionError: exceptionError ?? this.exceptionError,
        tokenSaved: tokenSaved ?? this.tokenSaved);
  }
}
