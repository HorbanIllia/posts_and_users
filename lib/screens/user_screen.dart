import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_parsed_text/flutter_parsed_text.dart';
import 'package:linkwell/linkwell.dart';
import 'package:posts_and_users/bloc/user_bloc/user_bloc.dart';
import 'package:posts_and_users/constants.dart';
import 'package:posts_and_users/models/user_model.dart';
import 'package:url_launcher/url_launcher.dart';

class UserScreen extends StatelessWidget{
  final int id;
  UserScreen(this.id);

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
        //child: _builPost(),
        child: SingleChildScrollView(
          child: _builUser(),
        ),
      ),
    );
  }

  Widget _builUser() {
    final UserBloc _newsBloc = UserBloc();
    _newsBloc.add(GetUser(id));
    return Container(
      margin: EdgeInsets.all(16),
      child: BlocProvider(
        create: (_)=>_newsBloc,
        child: BlocListener<UserBloc, UserState>(
          listener: (context, state) {
            if (state is UserError) {
              Scaffold.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message),
                ),
              );
            }
          },
          child: BlocBuilder<UserBloc, UserState>(
            builder: (context, state) {
              if (state is UserInitial) {
                return _buildLoading();
              } else if (state is UserLoading) {
                return _buildLoading();
              } else if (state is UserLoaded) {
                return _userView(state.userModel);
              } else if (state is UserError) {
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

  Widget _userView(User user){

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(user.name, style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold,)),
        SizedBox(height: 10),
        ParsedText(
          text: "Email: "+user.email+"\n"+
              "Phone: "+user.phone,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.normal,color: Colors.black),
          parse: <MatchText>[
            MatchText(
              type: ParsedType.EMAIL,
              style: TextStyle(
                color: Colors.blue,
                //fontSize: 18,
              ),
              onTap: (url) {
                launch("mailto:" + url);
              },
            ),
            MatchText(
              type: ParsedType.PHONE,
              style: TextStyle(
                color: Colors.blue,
                //fontSize: 18,
              ),
              onTap: (url) {
                launch("tel:" + url);
              },
            ),
          ],
        ),
        LinkWell("Website: "+user.website),
        SizedBox(height: 10),
        Text("Address: "+user.address.city+", "+user.address.street, style: TextStyle(fontSize: 18, fontWeight: FontWeight.normal,)),
        SizedBox(height: 10),
        Text("Company: "+user.company.name, style: TextStyle(fontSize: 18, fontWeight: FontWeight.normal,)),
      ],
    );
  }

  Widget _buildLoading() => Center(child: CircularProgressIndicator());
}