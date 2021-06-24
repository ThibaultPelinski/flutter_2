import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'login.dart';

// ignore: must_be_immutable
class Dashboard extends StatelessWidget {

// Creating String Var to Hold sent Email.
  final String username;

// Receiving Username using Constructor.
  Dashboard({Key key, @required this.username}) : super(key: key);

// User Logout Function.
  logout(BuildContext context){

    Navigator.pop(context);

  }

  List<Widget> _pages = [
    FrontPage(), // see the FrontPage class
    SettingsPage() // see the SettingsPage class
  ];

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
        navigationBar: CupertinoNavigationBar(
          middle: Text('Dashboard'),
        ),
        child: Center(
              child: CupertinoTabScaffold(
                  tabBar: CupertinoTabBar(
                    items: [
                      BottomNavigationBarItem(icon: Icon(Icons.home)),
                      BottomNavigationBarItem(icon: Icon(Icons.graphic_eq))
                    ],
                  ),
                  tabBuilder: (BuildContext context, index) {
                    return _pages[index];
                  }),
            )
    );
  }
}

class FrontPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Bienvenue '),
    );
  }
}

// Settings Page
class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Settings'),
    );
  }
}