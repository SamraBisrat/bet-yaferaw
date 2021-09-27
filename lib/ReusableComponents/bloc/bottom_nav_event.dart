import 'package:equatable/equatable.dart';

abstract class BottomNavEvent extends Equatable {
  const BottomNavEvent();
}

class BottomNavIcon extends BottomNavEvent {
  BottomNavIcon();

  @override
  List<Object> get props => [];
}

class ChangeIndex extends BottomNavEvent {
  ChangeIndex(this.index);

  final int index;

  @override
  List<Object> get props => [index];
}
