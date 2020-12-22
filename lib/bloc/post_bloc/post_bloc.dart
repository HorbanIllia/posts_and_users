import 'dart:async';
import 'package:equatable/equatable.dart';
import 'package:bloc/bloc.dart';
import 'package:posts_and_users/utils/api_repository.dart';
import 'package:posts_and_users/models/post_model.dart';

part 'post_event.dart';
part 'post_state.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  final ApiRepository _apiRepository = ApiRepository();

  PostBloc() : super(null);

  @override
  PostState get initialState => PostInitial();

  @override
  Stream<PostState> mapEventToState(PostEvent event,) async* {
    if (event is GetPost) {
      try {
        yield PostLoading();
        final mPost = await _apiRepository.fetchPost(event.id);
        yield PostLoaded(mPost);
        if (mPost == null)
        {
          yield PostError("error mapEvent");
        }
      } on NetworkError {
        yield PostError("Failed to fetch data. Please check your internet connection");
      }
    }
  }
}
