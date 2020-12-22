import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:posts_and_users/constants.dart';
import 'route.dart' as router;

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: HomeScreenAppName,
      onGenerateRoute: router.Router.generateRoute,
      initialRoute: SplashViewRoute,
    );
  }
}