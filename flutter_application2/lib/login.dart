import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dashboard.dart';
import 'sign_up.dart';

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
    var response = await http.post(url, body: json.encode(data));

    // Getting Server response into variable.
    var message = jsonDecode(response.body);

    // If the Response Message is Matched.
    if(message == 'Connexion r&eacute;ussie')
    {

      // Hiding the CircularProgressIndicator.
      setState(() {
        visible = false;
      });

      Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Dashboard())
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
          return AlertDialog(
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

  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[

                  Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Text('Connexion',
                          style: TextStyle(fontSize: 21))),

                  Divider(),

                  Container(
                      width: 280,
                      padding: EdgeInsets.all(2.0),
                      child: TextField(
                        controller: usernameController,
                        autocorrect: true,
                        decoration: new InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: const BorderRadius.all(
                              const Radius.circular(10.0),
                            ),
                          ),
                          labelText: 'Nom utilisateur',
                          hintText: 'Entrer votre nom utilisateur',
                        ),
                      )
                  ),

                  Container(
                      width: 280,
                      padding: EdgeInsets.all(2.0),
                      child: TextField(
                        controller: passwordController,
                        autocorrect: true,
                        obscureText: true,
                        decoration: new InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: const BorderRadius.all(
                              const Radius.circular(10.0),
                            ),
                          ),
                          labelText: 'Mot de passe',
                          hintText: 'Entrer votre mot de passe',
                        ),
                      )
                  ),

                  ElevatedButton(
                    onPressed: userLogin,
                    child: Text('Connexion'),
                  ),

                  Visibility(
                      visible: visible,
                      child: Container(
                          margin: EdgeInsets.only(bottom: 30),
                          child: CircularProgressIndicator()
                      )
                  ),

                  TextButton(onPressed: userSignUp, child: Text('Vous n\'êtes pas encore inscrit ?'))

                ],
              ),
            )));
  }
}
