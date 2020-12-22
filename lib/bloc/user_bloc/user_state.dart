part of 'user_bloc.dart';

abstract class UserState extends Equatable {
  const UserState();
}

class UserInitial extends UserState {
  const UserInitial();
  @override
  List<Object> get props => [];
}

class UserLoading extends UserState {
  const UserLoading();
  @override
  List<Object> get props => null;
}

class UserLoaded extends UserState {
  final User userModel;
  const UserLoaded(this.userModel);
  @override
  List<Object> get props => [userModel];
}

class UserError extends UserState {
  final String message;
  const UserError(this.message);
  @override
  List<Object> get props => [message];
}