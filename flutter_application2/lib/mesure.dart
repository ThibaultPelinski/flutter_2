import 'dart:convert';
import 'package:flutter/cupertino.dart';

import 'package:http/http.dart' as http;
import 'package:cupertino_list_tile/cupertino_list_tile.dart';
import 'dart:async';

import 'package:sticky_headers/sticky_headers.dart';
 
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
 Widget build(BuildContext context) {
   return CupertinoApp(
     theme: CupertinoThemeData(
       brightness: Brightness.dark,
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
  List list;
}

class _MyAppState extends State<Entry> {


   static const SHOW_URL = "http://marcel1968.hopto.org/mesure/show.php";
   static const DELETE_URL = "http://marcel1968.hopto.org/mesure/delete.php";
   static const ORDER_URL = "http://marcel1968.hopto.org/mesure/orderdesc.php";
  
  DateTime _dateTime = DateTime.now();
    

  Future  getAllMesures()async{
    var theurl = SHOW_URL;
    var res = await http.get(Uri.encodeFull(theurl), headers: {"Accept" : "application/json"});
    var reponseBody = json.decode(res.body);
    return reponseBody;
    }

   Future deleteMesure()async { 
      var theurl = DELETE_URL; 
      var res = await http.post(Uri.encodeFull(theurl),headers: {"Accept" : "application/json"});  
      var reponseBody = json.decode(res.body);
      return reponseBody;
    }

    Future order()async { 
      var theurl = ORDER_URL; 
      var res = await http.post(Uri.encodeFull(theurl),headers: {"Accept" : "application/json"});  
      var reponseBody = json.decode(res.body);
      return reponseBody;
    }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
 
      navigationBar: CupertinoNavigationBar( 
          middle: Text('DetectUS'),
        ),

         child :  FutureBuilder(
             future: getAllMesures(),
             builder: (BuildContext context, AsyncSnapshot snapshot) {
                List snap = snapshot.data;
        
               if (snapshot.connectionState == ConnectionState.waiting){
                 return Center(
                   child: CupertinoActivityIndicator(),
                 );
               }
               if (snapshot.hasError) {
                 return Center( 
                   child: Text("Erreur de chargement"),
                 );
               }; 
          
                 return ListView.builder(    
                   itemCount: snapshot.data.length,
                   itemBuilder: (context, index) {   
                        return CupertinoListTile(
                       title: Text("Distance : ${snapshot.data[index]['heading']} cm"),
                       subtitle: Text("Date : ${snapshot.data[index]['body'] } "),
                       trailing: Icon(CupertinoIcons.delete, semanticLabel: "Bouton Supprimer",),
                       onTap: () {
                        return showCupertinoDialog(
                          context: context,
                          builder: (context) => CupertinoAlertDialog(
                            title: Text("Supprimer l'entrée"),
                            content: Text("Êtes-vous sur de vouloir supprimer ?"),
                            actions: <Widget>[
                                CupertinoDialogAction(
                                  child: Text("Supprimer"),
                                  onPressed: () => setState(() {
                                    var url = DELETE_URL;
                                      http.post(url, body: {'id' : snap[index]['id'] });
                                      Navigator.of(context).pop(true);
                                  }) 
                                ),
                              CupertinoDialogAction(
                                child: Text("Annuler"),
                                  onPressed: () => Navigator.of(context).pop(false),
                              ),
                            ],
                          ),
                        );   
                       },
                    );
                   },                  
                );
               }      
           ),
     );
  }
}
