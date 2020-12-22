import 'package:dio/dio.dart';
import 'package:posts_and_users/constants.dart';
import 'package:posts_and_users/models/post_model.dart';
import 'package:posts_and_users/models/user_model.dart';

class ApiProvider {
  final Dio _dio = Dio();

  Future<List<PostM>> fetchPostsList() async {
    try {
      Response response = await _dio.get(URLPosts);
      return List<PostM>.from(response.data.isNotEmpty ? response.data.map((c) => PostM.fromJson(c)).toList() : []);
    } catch (error, stacktrace) {
      print("PostsList. Exception: $error stackTrace: $stacktrace");
      return null;
    }
  }

  Future<PostM> fetchPost(int id) async {
    try{
      Response response = await _dio.get(URLPosts+"/$id");
      return PostM.fromJson(response.data);
    } catch(error, stacktrace){
      print("Post. Exception: $error stackTrace: $stacktrace");
      return null;
    }
  }

  Future<User> fetchUser(int id) async {
    try{
      Response response = await _dio.get(URLUser+"/$id");
      return User.fromJson(response.data);
    } catch(error, stacktrace){
      print("User. Exception: $error stackTrace: $stacktrace");
      return null;
    }
  }
}