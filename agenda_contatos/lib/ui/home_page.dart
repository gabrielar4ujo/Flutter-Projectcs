import 'dart:io';

import 'package:agenda_contatos/helpers/contact_helper.dart';
import 'package:agenda_contatos/ui/contact_page.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

enum OrderOptions {
  orderAZ, orderZA
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  ContactHelper helper = ContactHelper();
  List<Contact> listContact = List();


  @override
  void initState() {
    super.initState();
    _getAllContacts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          PopupMenuButton<OrderOptions>(
            itemBuilder: (context) => <PopupMenuEntry<OrderOptions>>[
              const PopupMenuItem<OrderOptions>(
                child: Text("Ordenar de A-Z"),
                value: OrderOptions.orderAZ,
              ),
              const PopupMenuItem<OrderOptions>(
                child: Text("Ordenar de Z-A"),
                value: OrderOptions.orderZA,
              ),
            ],
            onSelected: _orderList
          )
        ],
        title: Text("Contatos"),
          backgroundColor: Colors.red,
        centerTitle: true,
      ),
      backgroundColor: Colors.white,
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          _showContactPage();
        },
        backgroundColor: Colors.red,
        child: Icon(Icons.add),
      ),
      body: ListView.builder(
          padding: EdgeInsets.all(10),
          itemCount: listContact.length,
          itemBuilder: (context, index){
            return _contactCard(context, index);
          }),
    );
  }

  Widget _contactCard(BuildContext context, int index){

    return GestureDetector(
      child: Card(
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Row(
            children: <Widget>[
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: listContact[index].img != null ? FileImage(File(listContact[index].img)) : AssetImage("images/person.png")
                  )
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  _textCard(listContact[index].name, FontWeight.bold, 22),
                  _textCard(listContact[index].email, FontWeight.normal, 18),
                  _textCard(listContact[index].phone, FontWeight.normal, 18),
                ],
              ),)
            ],
          ),
        ),
      ),
      onTap: (){
        _showOptions(context, index);
      },
    );

  }

  void _showOptions(context, index){
    showModalBottomSheet(
        context: context,
        builder: (context){
          return BottomSheet(
            builder: (context){
              return Container(
                padding: EdgeInsets.all(10),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.all(10),
                      child: FlatButton(
                        onPressed: (){
                          launch("tel:${listContact[index].phone}");
                          Navigator.pop(context);
                        },
                        child: Text("Ligar",
                          style: TextStyle(
                              color: Colors.red,
                              fontSize: 20
                          ),),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(10),
                      child: FlatButton(
                        onPressed: (){
                          Navigator.pop(context);
                          _showContactPage(contact: listContact[index]);
                        },
                        child: Text("Editar",
                          style: TextStyle(
                              color: Colors.red,
                              fontSize: 20
                          ),),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(10),
                      child: FlatButton(
                        onPressed: (){
                          Navigator.pop(context);
                          helper.deleteContact(listContact[index].id);
                          setState(() {
                            listContact.removeAt(index);
                          });
                        },
                        child: Text("Excluir",
                          style: TextStyle(
                              color: Colors.red,
                              fontSize: 20
                          ),),
                      ),
                    ),
                  ],
                ),
              );
            }, onClosing: () {},
          );
        });
  }

  Widget _textCard(String string, FontWeight f, double textSize){
    return Text(string ?? "",
    style: TextStyle(
      fontSize: textSize, fontWeight: f
    ),);
  }

  void _showContactPage({Contact contact}) async{
    final recContact = await Navigator.push(context, MaterialPageRoute(
        builder: (context) => ContactPage(contact: contact,)
    ));

    if(recContact != null){
      if(contact != null){
        await helper.updateContact(recContact);
      }
      else{
        await helper.saveContact(recContact);
      }
      _getAllContacts();
    }
  }

  void _getAllContacts(){
    helper.getAllContacts().then((list){
      setState(() {
        listContact = list;
      });
    });
  }

  void _orderList(OrderOptions result){
    switch(result){
      case OrderOptions.orderAZ:
        listContact.sort((a,b){
          return a.name.toLowerCase().compareTo(b.name.toLowerCase());
        });
        break;

      case OrderOptions.orderZA:
        listContact.sort((a,b){
          return b.name.toLowerCase().compareTo(a.name.toLowerCase());
        });
        break;

      default:
        break;
    }
    setState(() {

    });
  }
}
