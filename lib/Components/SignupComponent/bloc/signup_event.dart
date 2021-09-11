import 'package:bet_yaferaw/Model/user.dart';
import 'package:equatable/equatable.dart';

abstract class SignUpEvent extends Equatable {
  const SignUpEvent();
}

class SignupButtonPressed extends SignUpEvent {
  const SignupButtonPressed({this.userData});

  final UserData userData;

  @override
  List<Object> get props => [userData];
}
