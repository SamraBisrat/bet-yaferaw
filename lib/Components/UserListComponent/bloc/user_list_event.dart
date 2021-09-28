import 'dart:io';

import 'package:equatable/equatable.dart';

abstract class UserListEvent extends Equatable {
  const UserListEvent();
}

class InitializeUserList extends UserListEvent {
  InitializeUserList();

  @override
  List<Object> get props => [];
}

class DeleteUser extends UserListEvent {
  final String id;
  DeleteUser(this.id);

  @override
  List<Object> get props => [id];
}
