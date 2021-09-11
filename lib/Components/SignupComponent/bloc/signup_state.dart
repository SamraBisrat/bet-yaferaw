import 'package:bet_yaferaw/Model/user.dart';
import 'package:equatable/equatable.dart';

class SignupState extends Equatable {
  const SignupState({this.userData, this.exceptionError, this.isLoading});
  final UserData userData;
  final bool isLoading;
  final String exceptionError;

  @override
  List<Object> get props => [userData];

  SignupState copyWith({
    UserData userData,
    String exceptionError,
    bool isLoading,
  }) {
    return SignupState(
      userData: userData ?? this.userData,
      isLoading: isLoading ?? this.isLoading,
      exceptionError: exceptionError ?? this.exceptionError,
    );
  }
}