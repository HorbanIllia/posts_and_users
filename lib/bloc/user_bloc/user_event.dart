part of 'user_bloc.dart';

abstract class UserEvent extends Equatable {
  final int id;
  const UserEvent(this.id);
}

class GetUser extends UserEvent {
  GetUser(int id) : super(id);

  @override
  List<Object> get props => null;
}