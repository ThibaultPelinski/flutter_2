import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';


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
  List list;
}

class _MyAppState extends State<Entry> {

   static const SHOW_URL = "http://marcel1968.hopto.org/mesure/show.php";
   static const DELETE_URL = "http://marcel1968.hopto.org/mesure/delete.php";
    

  Future  getAllMesures()async{
    var theurl = SHOW_URL;
    var res = await http.get(Uri.encodeFull(theurl), headers: {"Accept" : "application/json"});
    var reponseBody = json.decode(res.body);
    return reponseBody;
    }

   Future deleteMesure()async { 
        var theurl = DELETE_URL; 
        var res = await http.post(Uri.encodeFull(theurl), headers: {"Accept" : "application/json"});
        var reponseBody = json.decode(res.body);

        print(reponseBody);
        //return reponseBody;
    }
    // Future deleteMesure( Map jsonMap )async {
    //     var theurl = DELETE_URL;
    //     HttpClient http = new HttpClient();
    //     HttpClientRequest request = await http.deleteUrl(Uri.parse(theurl));
    //     request.headers.set('content-type', 'application/json');
    //     request.add(utf8.encode(json.encode(jsonMap)));
    //     HttpClientResponse response = await request.close();
    //     String reply = await response.transform(utf8.decoder).join();
    //     print(reply);
    //     http.close();
    //     Map<String, dynamic>map = json.decode(reply);
    //     return map;
    //     // var res = await http.delete(theurl);
    //     // var reponseBody = json.decode(res.body);
    //     //return reponseBody;
    // }
    //     
    

    //  void   deleteMesure() {
    //    var url_delete =  DELETE_URL;
    //    http.post(url_delete, body: {
    //      'id' :  widget.list[widget.index]['id']
    //    });
    //  }

  @override
  Widget build(BuildContext context) {
 return Scaffold(
              floatingActionButton: FloatingActionButton(
         onPressed: () {

            setState(() {
            });
          
         },
        child :   Icon(Icons.sort)
     ),
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
                   itemCount: snapshot.data.length,
                   itemBuilder: (context, index) { 
                      return RaisedButton(onPressed: (){
                            deleteMesure();});
                      return  ListTile(
                       title: Text("Distance : ${snapshot.data[index]['heading']} cm"),
                       subtitle: Text("Date : ${snapshot.data[index]['body'] } "),
                       trailing: IconButton(icon: Icon(Icons.delete),
                       onPressed: (){
                            deleteMesure();

                            //  var url = DELETE_URL;
                            //  http.post(url, body:'${snapshot.data[index]['id'] }' );
                       },),
                     );
                   },                  
                 );
               }      
           ),                   
          

     );
  }
}


