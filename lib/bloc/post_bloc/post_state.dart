part of 'post_bloc.dart';

abstract class PostState extends Equatable {
  const PostState();
}

class PostInitial extends PostState {
  const PostInitial();
  @override
  List<Object> get props => [];
}

class PostLoading extends PostState {
  const PostLoading();
  @override
  List<Object> get props => null;
}

class PostLoaded extends PostState {
  final PostM postModel;
  const PostLoaded(this.postModel);
  @override
  List<Object> get props => [postModel];
}

class PostError extends PostState {
  final String message;
  const PostError(this.message);
  @override
  List<Object> get props => [message];
}