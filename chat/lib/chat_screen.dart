import 'dart:io';

import 'package:chat/text_composer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'chat_message.dart';

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {

  final GoogleSignIn googleSignIn = GoogleSignIn();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  FirebaseUser _currentUser;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    FirebaseAuth.instance.onAuthStateChanged.listen( (user){
      setState(() {
        _currentUser = user;
      });
    } );
  }

  Future<FirebaseUser> _getUser() async{

    if(_currentUser != null) return _currentUser;

    try{
      final GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
      final GoogleSignInAuthentication googleSignInAuthentication = await googleSignInAccount.authentication;

      final AuthCredential authCredential = GoogleAuthProvider
          .getCredential(idToken: googleSignInAuthentication.idToken, accessToken: googleSignInAuthentication.accessToken); //AuthCredential é do firebase
      final AuthResult authResult = await FirebaseAuth.instance.signInWithCredential(authCredential);

      final FirebaseUser user = authResult.user;
      return user;
    }

    catch(e){
      return null;
    }

  }

  void _sendMessage({String text, File imageFile}) async {
    final FirebaseUser user = await _getUser();

    if(user == null){
      _scaffoldKey.currentState.showSnackBar(
        SnackBar(
          content: Text("Não foi possível fazer o login. Tente novamente!"),
          backgroundColor: Colors.red,
        )
      );
    }

    Map<String, dynamic> map = {
      "time" :  Timestamp.now(),
      "uid" : user.uid,
      "senderName" : user.displayName,
      "photoUrl" : user.photoUrl
    };

    if (imageFile != null) {
      StorageUploadTask task = FirebaseStorage.instance.ref().child(
          DateTime
              .now()
              .millisecondsSinceEpoch
              .toString()
      ).putFile(imageFile);

     setState(() {
       isLoading = true;
     });

      StorageTaskSnapshot taskSnapshot = await task.onComplete;
      String url = await taskSnapshot.ref.getDownloadURL();
      map["imageUrl"] = url;

      setState(() {
        isLoading = false;
      });
    }

    if(text != null) map["text"] = text;
    Firestore.instance.collection("message").add(map);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        actions: <Widget>[
          _currentUser != null ? IconButton(
            icon: Icon(Icons.exit_to_app),
            onPressed: (){
              FirebaseAuth.instance.signOut();
              googleSignIn.signOut();
              _scaffoldKey.currentState.showSnackBar(SnackBar(
                content: Text("Deslogado com sucesso!"),
              ));
            },
          ) : Container()
        ],
        centerTitle: true,
        title: Text (
            _currentUser != null ? "Olá, ${_currentUser.displayName}" : "Chat")
        ,
        elevation: 0,
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: Firestore.instance.collection("message").orderBy("time").snapshots(),
              builder: (context,snapshot){
                switch(snapshot.connectionState){
                  case ConnectionState.none:

                  case ConnectionState.waiting:
                    return Center(
                      child: CircularProgressIndicator(),
                    );

                  default:
                    List<DocumentSnapshot> documents = snapshot.data.documents.reversed.toList();
                    return ListView.builder(
                      itemCount: documents.length,
                      reverse: true,
                      itemBuilder: (context,index){

                        return ChatMessage(documents[index].data, _currentUser.uid);
                      },

                    );
                }
              },
            ),
          ),
          isLoading ? LinearProgressIndicator() : Container(),
          TextComposer( _sendMessage ),
        ],
      ),
    );
  }
}
