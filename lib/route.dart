import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:posts_and_users/screens/home_screen.dart';
import 'package:posts_and_users/screens/splash_screen.dart';

import 'constants.dart';

class Router {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case SplashViewRoute:
        return MaterialPageRoute(builder: (context) => SplashScreen());
      case HomeViewRoute:
        return MaterialPageRoute(builder: (context) => HomeScreen());
    }
  }
}