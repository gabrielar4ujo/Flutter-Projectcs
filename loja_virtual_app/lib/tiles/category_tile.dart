import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:loja_virtual_app/screens/category_screen.dart';

class CategoryTile extends StatelessWidget {

  final DocumentSnapshot snapshot;

  const CategoryTile(this.snapshot);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        radius: 25,
        backgroundColor: Colors.transparent,
        backgroundImage: NetworkImage(
          snapshot.data["icon"]
        ),
      ),//
      title: Text(snapshot.data["title"]),
      trailing: Icon(
        Icons.keyboard_arrow_right
      ),//Icone do final// Icone que f
      onTap: (){
        Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => CategoryScreen(snapshot))
        );
      },// ica na esquerda
    );
  }
}
