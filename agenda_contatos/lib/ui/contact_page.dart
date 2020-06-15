import 'dart:io';

import 'package:flutter/material.dart';
import 'package:agenda_contatos/helpers/contact_helper.dart';
import 'package:image_picker/image_picker.dart';

class ContactPage extends StatefulWidget {
  Contact contact;

  ContactPage({this.contact});

  @override
  _ContactPageState createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {

  final NOVO_CONTATO = "Novo contato";
  Contact _editContact;
  bool _userEdited = false;

  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();

  final FocusNode _nameFocus = FocusNode();

  @override
  void initState() {
    super.initState();
    if(widget.contact == null){
      _editContact = Contact();
    }
    else {
      _editContact = Contact.fromMap(widget.contact.toMap());

      _nameController.text = _editContact.name;
      _emailController.text = _editContact.email;
      _phoneController.text = _editContact.phone;

    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _requestPop,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.red,
          centerTitle: true,
          title: Text(
            _editContact.name ?? NOVO_CONTATO, style: TextStyle(
              color: Colors.white,
              fontSize: 18
          ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: (){
            if(_editContact.name != null && _editContact.name.isNotEmpty && _editContact.name != NOVO_CONTATO){
              Navigator.pop(context,_editContact);
            }
            else{
              FocusScope.of(context).requestFocus(_nameFocus);
            }

          },
          backgroundColor: Colors.red,
          child: Icon(Icons.save),
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.all(10),
          child: Column(

            children: <Widget>[
              GestureDetector(
                onTap: (){
                  ImagePicker.pickImage(source: ImageSource.camera).then(
                      (file){
                        if(file == null){
                          return;
                        }
                        setState(() {
                          _editContact.img = file.path;
                        });
                      }
                  );
                },
                child: Container(
                  width: 120,
                  height: 120,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                          image: _editContact.img != null ? FileImage(File(_editContact.img)) : AssetImage("images/person.png")
                      )
                  ),
                ),
              ),
              _textField("Nome", (text){
                _userEdited = true;
                setState(() {
                  if(text.isEmpty) _editContact.name = NOVO_CONTATO;
                  else _editContact.name = text;
                });
              },TextInputType.text, _nameController, f: _nameFocus),
              _textField("Email", (text){
                _userEdited = true;
                _editContact.email = text;
              },TextInputType.emailAddress, _emailController),
              _textField("Phone", (text){
                _userEdited = true;
                _editContact.phone= text;
              },TextInputType.phone, _phoneController)
            ],
          ),
        ),

      ),
    );
  }

  Widget _textField(String string, Function function, TextInputType textInputType, TextEditingController textEditingController, { FocusNode f } ){
    return TextField(
      controller: textEditingController,
      decoration: InputDecoration(labelText: string),
      onChanged: function,
      keyboardType: textInputType,
      focusNode: f,
    );
  }

  Future<bool> _requestPop(){
    if(_userEdited){
      showDialog(context: context,
      builder: (context){
        return AlertDialog(
          title: Text("Descartar Alterações?"),
          content: Text("Se sair as alterações serão descartadas"),
          actions: <Widget>[
            FlatButton(
              child: Text("Cancelar"),
              onPressed: (){
                Navigator.pop(context);
              },
            ),
            FlatButton(
              child: Text("Sim"),
              onPressed: (){
                Navigator.pop(context);
                Navigator.pop(context);
              },
            )
          ],
        );
      });
      return Future.value(false);
    }
    else{
      return Future.value(true);
    }
  }
}
