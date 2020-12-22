import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:posts_and_users/bloc/posts_bloc/posts_bloc.dart';
import 'package:posts_and_users/constants.dart';
import 'package:posts_and_users/models/post_model.dart';
import 'package:posts_and_users/screens/post_screen.dart';

class HomeScreen extends StatefulWidget  {
  @override
  State<StatefulWidget> createState() {
    return _HomeState();
  }
}

class _HomeState extends State<HomeScreen> {
  final PostsBloc _newsBloc = PostsBloc();

  @override
  void initState() {
    _newsBloc.add(GetPostsList());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: _buildListPosts(),
      ),
    );
  }

  Widget _buildListPosts() {
    return Container(
      margin: EdgeInsets.all(8.0),
      child: BlocProvider(
        create: (_) => _newsBloc,
        child: BlocListener<PostsBloc, PostsState>(
          listener: (context, state) {
            if (state is PostsError) {
              Scaffold.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message),
                ),
              );
            }
          },
          child: BlocBuilder<PostsBloc, PostsState>(
            builder: (context, state) {
              if (state is PostsInitial) {
                return _buildLoading();
              } else if (state is PostsLoading) {
                return _buildLoading();
              } else if (state is PostsLoaded) {
                return RefreshIndicator(
                  child: _buildCard(context, state.postModel),
                  onRefresh: () async{
                    state.postModel.clear();
                    BlocProvider.of<PostsBloc>(context).add(GetPostsList(),);
                  },
                );
              } else if (state is PostsError) {
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

  Widget _buildCard(BuildContext context, List<PostM> model) {

    return ListView.builder(
      itemCount: model.length,
      itemBuilder: (context, index) {
        return Container(
          margin: EdgeInsets.all(8.0),
          child: ListTile(
            title: Text("Title: ${model[index].title}"),
            subtitle: Text("Body: ${model[index].body}"),
            onTap: (){
              Navigator.push(context, MaterialPageRoute(
                  builder: (context) => PostScreen(model[index].id)));
            },
          ),
        );
      },
    );
  }

  Widget _buildLoading() => Center(child: CircularProgressIndicator());
}