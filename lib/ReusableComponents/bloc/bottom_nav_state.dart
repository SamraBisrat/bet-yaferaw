import 'package:bet_yaferaw/Model/user.dart';
import 'package:equatable/equatable.dart';

class BottomNavState extends Equatable {
  const BottomNavState({this.userData, this.index, this.isInitialStart});

  final UserData userData;
  final int index;
  final bool isInitialStart;

  @override
  List<Object> get props => [userData, index, isInitialStart];

  BottomNavState copyWith({UserData userData, int index, bool isInitialStart}) {
    return BottomNavState(
        userData: userData ?? this.userData,
        index: index ?? this.index,
        isInitialStart: isInitialStart ?? this.isInitialStart);
  }
}
