import 'package:chat/chat_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

void main() async{

  runApp(MyApp());
  /*Firestore.instance.collection("col").document().setData({"texto" : "Iai",
  "from": "Edvaldo",
  "read": true
  });*/
  /*Firestore.instance.collection("col").document().collection("arquivos").document().setData({"texto" : "Coleção dentro de coleção",
    "read": false
  });*/

 /* QuerySnapshot querySnapshot = await Firestore.instance.collection("col").getDocuments(); //Pega o de todos dentro da coleção 'col'
  querySnapshot.documents.forEach((f){
    f.reference.updateData({"read": true});
    print(f.data);
    print(f.documentID);

  });*/

  /*DocumentSnapshot documentSnapshot = await Firestore.instance.collection("col").document("UWgvTLwwHqWgNdZJ4j2p").get(); //Pega o de todos dentro da coleção 'col' //Pega o do ID específico
  print(documentSnapshot.data);*/

//  Firestore.instance.collection("col").snapshots().listen((data){ //Cria um "ouvinte", ou seja, quando qualquer dado dentro da coleção 'col' mudar, a funcão dentro do listen sera chamada
//    data.documents.forEach((f){
//      print(f.data);
//    });
//  });

}
class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        iconTheme: IconThemeData(
          color: Colors.blue
        ),
        primarySwatch: Colors.blue,
      ),
      home: ChatScreen(),
    );
  }
}

