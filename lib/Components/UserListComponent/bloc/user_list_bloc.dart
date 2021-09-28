import 'package:bet_yaferaw/Components/UserListComponent/bloc/user_list_event.dart';
import 'package:bet_yaferaw/Components/UserListComponent/bloc/user_list_state.dart';
import 'package:bet_yaferaw/Model/user.dart';
import 'package:bet_yaferaw/Repositories/admin_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserListBloc extends Bloc<UserListEvent, UserListState> {
  // UserRepository userRepository = UserRepository();
  AdminRepository userRepository = AdminRepository();

  UserListBloc() : super(UserListState(isLoading: true)) {
    add(InitializeUserList());
  }

  @override
  Stream<UserListState> mapEventToState(UserListEvent event) async* {
    if (event is InitializeUserList) {
      List<UserData> getResponse = await userRepository.getUsers();
      print("user data from shared pref");
      print(getResponse);
      if (getResponse != null) {
        yield state.copyWith(isLoading: false, users: getResponse);
      } else {
        yield state.copyWith(
          isLoading: false,
          users: null,
        );
      }
    } else if (event is DeleteUser) {
      yield state.copyWith(isLoading: true);
      int deleteResponse = await userRepository.deleteUser(event.id);
      List<UserData> getResponse = await userRepository.getUsers();
      print(deleteResponse);
      print("response ");
      if (deleteResponse == 200) {
        yield state.copyWith(
            isLoading: false, isDeleted: true, users: getResponse);
      } else {
        yield state.copyWith(isLoading: false, isDeleted: false);
      }
    }
  }
}
