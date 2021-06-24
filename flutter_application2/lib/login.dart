import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dashboard.dart';
import 'mesure.dart';
import 'sign_up.dart';
import 'package:flutter/cupertino.dart';

class LoginUser extends StatefulWidget {
  LoginUserState createState() => LoginUserState();
}

class LoginUserState extends State {
  bool visible = false ;
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  Future userSignUp() async{
    Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => SignUp())
    );
  }

  Future userLogin() async{

    setState(() {
      visible = true ;
    });

    String username = usernameController.text;
    String mdp = passwordController.text;

    var url = 'http://marcel1968.hopto.org/mesure/login_user.php';

    // Store all data with Param Name.
    var data = {'username': username, 'mdp' : mdp};

    // Starting Web API Call.
    var response = await http.post(url, body: data);

    // Getting Server response into variable.
    var message = json.decode(response.body);

    // If the Response Message is Matched.
    if(message == 'Connexion réussie')
    {

      // Hiding the CircularProgressIndicator.
      setState(() {
        visible = false;
      });

      Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Entry())
      );

    } else{

      // If Email or Password did not Matched.
      // Hiding the CircularProgressIndicator.
      setState(() {
        visible = false;
      });

      // Showing Alert Dialog with Response JSON Message.
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return CupertinoAlertDialog(
            title: new Text(message),
            actions: <Widget>[
              TextButton(
                child: new Text("OK"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
        navigationBar: CupertinoNavigationBar(
          middle: Text('Connexion'),
        ),
      child: Center(
        child: ListView(
          children: <Widget>[
            Container(
                width: 280,
                padding: EdgeInsets.only(top: 70.0, left: 22.0, right: 22.0),
                child: CupertinoTextField(
                  controller: usernameController,
                  padding: EdgeInsets.all(20.0),
                  placeholder: 'Nom d\'utilisateur',
                  autocorrect: true,
                )
            ),

            Container(
                width: 100,
                padding: EdgeInsets.all(22.0),
                child: CupertinoTextField(
                  controller: passwordController,
                  padding: EdgeInsets.all(20.0),
                  placeholder: 'Mot de passe',
                  autocorrect: true,
                  obscureText: true,
                )
            ),

            Container(
              width: 100,
              padding: EdgeInsets.only(top: 30.0, right: 50.0, left: 50.0, bottom: 20.0),
              child: CupertinoButton.filled(
                onPressed: userLogin,
                minSize: 10.0,
                padding: EdgeInsets.all(13.0),
                borderRadius: new BorderRadius.circular(10.0),
                child: Text('Connexion'),
              ),
            ),

            Visibility(
                visible: visible,
                child: Container(
                    margin: EdgeInsets.only(bottom: 30),
                    child: CupertinoActivityIndicator()
                )
            ),

            CupertinoButton(
                onPressed: userSignUp,
                child: Text('Vous n\'êtes pas encore inscrit ?')
            )
          ],
        ),
      )
    );
  }
}
