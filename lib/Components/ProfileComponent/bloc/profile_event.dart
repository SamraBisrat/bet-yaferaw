import 'package:equatable/equatable.dart';

abstract class ProfileEvents extends Equatable {
  const ProfileEvents();
}

class InitiliazeProfile extends ProfileEvents {
  InitiliazeProfile();

  @override
  List<Object> get props => [];
}

class CreatedRecipesPressed extends ProfileEvents {
  CreatedRecipesPressed();

  @override
  List<Object> get props => [];
}

class SavedRecipesPressed extends ProfileEvents {
  SavedRecipesPressed();

  @override
  List<Object> get props => [];
}
