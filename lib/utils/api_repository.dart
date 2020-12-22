import 'package:posts_and_users/models/post_model.dart';
import 'package:posts_and_users/models/user_model.dart';

import 'api_provider.dart';

class ApiRepository {
  final _provider = ApiProvider();

  Future<List<PostM>> fetchPostsList() {
    return _provider.fetchPostsList();
  }

  Future<PostM> fetchPost(int id){
    return _provider.fetchPost(id);
  }

  Future<User> fetchUser(int id){
    return _provider.fetchUser(id);
  }
}

class NetworkError extends Error {}