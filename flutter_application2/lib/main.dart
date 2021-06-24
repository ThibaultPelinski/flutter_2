import 'package:flutter/cupertino.dart';
import 'login.dart';
import 'sign_up.dart';
import 'dashboard.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      theme: CupertinoThemeData(
        brightness: Brightness.dark,
      ),
      title: 'DetecUs Login',
      initialRoute: '/login',
      routes: {
        '/login': (context) => LoginUser(),
        '/sign': (context) => SignUp(),
        '/': (context) => Dashboard(),
      },
    );
  }
}
