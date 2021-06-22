import 'package:flutter/material.dart';
import 'package:flutter_application_1/login.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

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
    final response = await http.post(url, body: json.encode(data));

    // Getting Server response into variable.
    var message = jsonDecode(response.body);

    // If Web call Success than Hide the CircularProgressIndicator.
    if(response.statusCode == 200){
      setState(() {
        visible = false;
      });
    }

    // Showing Alert Dialog with Response JSON Message.
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: new Text(message),
          actions: <Widget>[
            ElevatedButton(
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
                      child: Text('Inscription',
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
                          hintText: 'Entrer un nom utilisateur',
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
                          hintText: 'Entrer un mot de passe',
                        ),
                      )
                  ),

                  ElevatedButton(
                    onPressed: userRegistration,
                    child: Text('Envoyer'),
                  ),

                  Visibility(
                      visible: visible,
                      child: Container(
                          margin: EdgeInsets.only(bottom: 30),
                          child: CircularProgressIndicator()
                      )
                  ),

                  TextButton(onPressed: userLogin, child: Text('Vous avez déjà un compte ?'))

                ],
              ),
            )));
  }
}
