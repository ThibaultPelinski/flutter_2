import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'login.dart';

class Dashboard extends StatelessWidget {

// Creating String Var to Hold sent Email.
  final String username;

// Receiving Username using Constructor.
  Dashboard({Key key, @required this.username}) : super(key: key);

// User Logout Function.
  logout(BuildContext context){

    Navigator.pop(context);

  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
        navigationBar: CupertinoNavigationBar(
          middle: Text('Dashboard'),
        ),
        child: Center(
            child: ListView(
              children: <Widget>[
                Container(
                    width: 280,
                    padding: EdgeInsets.all(50.0),
                    child: Text('Bienvenue ' + username,
                        style: TextStyle(fontSize: 20))
                ),

                TextButton(
                  onPressed: () {
                    logout(context);
                  },
                  child: Text('Cliquer pour vous deconnectez'),
                ),

              ],
            )
        )
    );
  }
}