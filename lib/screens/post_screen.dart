import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:posts_and_users/bloc/post_bloc/post_bloc.dart';
import 'package:posts_and_users/constants.dart';
import 'package:posts_and_users/models/post_model.dart';
import 'package:posts_and_users/screens/user_screen.dart';

class PostScreen extends StatelessWidget{
  final int id;
  PostScreen(this.id);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
            color: Colors.black45
        ),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: _builPost(),
        ),
      ),
    );
  }

  Widget _builPost() {
    final PostBloc _newsBloc = PostBloc();
    _newsBloc.add(GetPost(id));
    return Container(
      margin: EdgeInsets.all(16),
      child: BlocProvider(
        create: (_)=>_newsBloc,
        child: BlocListener<PostBloc, PostState>(
          listener: (context, state) {
            if (state is PostError) {
              Scaffold.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message),
                ),
              );
            }
          },
          child: BlocBuilder<PostBloc, PostState>(
            builder: (context, state) {
              if (state is PostInitial) {
                return _buildLoading();
              } else if (state is PostLoading) {
                return _buildLoading();
              } else if (state is PostLoaded) {
                return _postView(context,state.postModel);
              } else if (state is PostError) {
                return Container(
                  child: Text(errorMsg),
                );
              }

              return CircularProgressIndicator();
            },
          ),
        ),
      ),
    );
  }

  Widget _postView(BuildContext context,PostM post){
    return Column(
      children: [
        Text(post.title, style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold,),textAlign: TextAlign.center),
        SizedBox(height: 10),
        GestureDetector(
          child: Text("Author "+post.userId.toString(), style: TextStyle(color: Colors.black45,fontSize: 20, fontStyle: FontStyle.italic),),
          onTap: (){
            Navigator.push(context, MaterialPageRoute(
                builder: (context) => UserScreen(post.userId)));
          },
        ),
        SizedBox(height: 10),
        Text(post.body, style: TextStyle(fontSize: 22),textAlign: TextAlign.start),
      ],
    );
  }

  Widget _buildLoading() => Center(child: CircularProgressIndicator());
}