import 'dart:convert';


import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override

 Widget build(BuildContext context) {
   return MaterialApp(
     theme: ThemeData(
       backgroundColor: Colors.white70,
       primarySwatch: Colors.blue,
       brightness: Brightness.light,
     ),
      debugShowCheckedModeBanner: false,
      title: "test",
      home: Entry(),
   );
 }
}

class Entry extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<Entry> {

  Future  getAllMesures()async{
    var theurl = "http://marcel1968.hopto.org/mesure/show.php";
    var res = await http.get(Uri.encodeFull(theurl), headers: {"Accept" : "application/json"});
    var reponseBody = json.decode(res.body);

    return reponseBody;
    }




  // @override
  // void initState() {
  //   super.initState();
  //   getAllMesures();
  // }
  @override
  Widget build(BuildContext context) {
  
    return Scaffold(
      appBar: AppBar( 
        title: Text("Flutter synthese"),
        ),



          body : FutureBuilder(
            future: getAllMesures(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {

              List snap = snapshot.data;
        
              if (snapshot.connectionState == ConnectionState.waiting){
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (snapshot.hasError) {
                return Center( 
                  child: Text("Erreur de chargement"),
                );
                };
 
                 
                return ListView.builder(
                  itemCount: snap.length,
                  itemBuilder: (context, index) {
                     return ListTile(
                      title: Text("Distance : ${snap[index]['heading']} cm"),
                      subtitle: Text("Date : ${snap[index]['body']} "),
                    );
                  },
                );
            },
          ),
    );
  }
}

