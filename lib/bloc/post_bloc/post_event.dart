part of 'post_bloc.dart';

abstract class PostEvent extends Equatable {
  final int id;
  const PostEvent(this.id);
}

class GetPost extends PostEvent {
  GetPost(int id) : super(id);

  @override
  List<Object> get props => null;
}