import 'package:flutter/material.dart';
import 'package:flutter_application_1/login.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';

class SignUp extends StatefulWidget {
  SignUserState createState() => SignUserState();
}

class SignUserState extends State {
  bool visible = false ;
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  Future userLogin() async{
    Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => LoginUser())
    );
  }

  Future userRegistration() async{

    // Showing CircularProgressIndicator.
    setState(() {
      visible = true ;
    });

    // Getting value from Controller
    String name = usernameController.text;
    String password = passwordController.text;

    // SERVER API URL
    var url = 'http://marcel1968.hopto.org/mesure/register.php';

    // Store all data with Param Name.
    var data = {'username': name, 'mdp' : password};

    // Starting Web API Call.
    var response = await http.post(url, body: data);

    // Getting Server response into variable.
    var message = json.decode(response.body);

    // If Web call Success than Hide the CircularProgressIndicator.
    if(response.statusCode == 200){
      setState(() {
        visible = false;
      });
    }

    // Showing Alert Dialog with Response JSON Message.
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          title: Text(message),
          actions: <Widget>[
            // Close the dialog
            CupertinoDialogAction(
                child: Text('Ok'),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => LoginUser())
                  );
                }),
          ],
        );
      },
    );

  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text('Inscription'),
      ),
      child: Center(
        child: ListView(
          children: <Widget>[
            Container(
                width: 280,
                padding: EdgeInsets.only(top: 70.0, left: 22.0, right: 22.0),
                child: CupertinoTextField(
                  controller: usernameController,
                  placeholder: 'Nom d\'utilisateur',
                  padding: EdgeInsets.all(20.0),
                  cursorRadius: Radius.circular(10.0),
                  autocorrect: true,
                )
            ),

            Container(
                width: 280,
                padding: EdgeInsets.all(22.0),
                child: CupertinoTextField(
                  controller: passwordController,
                  placeholder: 'Mot de passe',
                  padding: EdgeInsets.all(20.0),
                  cursorRadius: Radius.circular(10.0),
                  autocorrect: true,
                  obscureText: true,
                )
            ),

            Container(
              width: 100,
              padding: EdgeInsets.only(top: 30.0, right: 50.0, left: 50.0, bottom: 20.0),
              child: CupertinoButton.filled(
                onPressed: userRegistration,
                minSize: 10.0,
                padding: EdgeInsets.all(15.0),
                borderRadius: new BorderRadius.circular(10.0),
                child: Text('Envoyer'),
              ),
            ),

            Visibility(
                visible: visible,
                child: Container(
                    margin: EdgeInsets.only(bottom: 30),
                    child: CupertinoActivityIndicator()
                )
            ),

            CupertinoButton(onPressed: userLogin, child: Text('Vous avez déjà un compte ?'))
          ],
        ),
      ),
    );
  }
}
