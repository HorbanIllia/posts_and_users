import 'dart:async';
import 'package:equatable/equatable.dart';
import 'package:bloc/bloc.dart';
import 'package:posts_and_users/utils/api_repository.dart';
import 'package:posts_and_users/models/user_model.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final ApiRepository _apiRepository = ApiRepository();

  UserBloc() : super(null);

  @override
  UserState get initialState => UserInitial();

  @override
  Stream<UserState> mapEventToState(UserEvent event,) async* {
    if (event is GetUser) {
      try {
        yield UserLoading();
        final mPost = await _apiRepository.fetchUser(event.id);
        yield UserLoaded(mPost);
        if (mPost == null)
        {
          yield UserError("Error mapEvent");
        }
      } on NetworkError {
        yield UserError("Failed to fetch data. Please check your internet connection");
      }
    }
  }
}
