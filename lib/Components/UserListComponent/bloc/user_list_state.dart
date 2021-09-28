import 'package:bet_yaferaw/Model/user.dart';
import 'package:equatable/equatable.dart';

class UserListState extends Equatable {
  const UserListState({this.isDeleted, this.isLoading, this.users});

  final bool isLoading;
  final bool isDeleted;
  final List<UserData> users;

  @override
  List<Object> get props => [isLoading, isDeleted, users];

  UserListState copyWith(
      {bool isLoading, bool isDeleted, List<UserData> users}) {
    return UserListState(
        isLoading: isLoading ?? false,
        users: users ?? this.users,
        isDeleted: isDeleted ?? false);
  }
}
