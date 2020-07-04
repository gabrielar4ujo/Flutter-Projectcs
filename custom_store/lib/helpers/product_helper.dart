import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:customstore/helpers/category_helper_interface.dart';
import 'package:customstore/pages/login_page/controllers_login_page/controller_login_page.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';

class ProductHelper implements CategoryHelperI{

  String userUID;
  final timeOut = 3;

  ProductHelper(){
    this.userUID = GetIt.I.get<ControllerLoginPage>().user.uid;
  }

  @override
  Future<bool> delete(String documentID) {

  }

  @override
  Future<bool> insert(String documentID, {@required Map productData}) async{
    bool success = false;

    await Firestore.instance
        .collection("stores")
        .document(userUID)
        .collection("stock").document(documentID).updateData({
      "listProducts": productData
    }).whenComplete(() =>  success = true ).catchError((exception){
      success = false;
    }).timeout(Duration(seconds: timeOut), onTimeout: (){
      print("PRODUCT TIMEOUT");
    });

    return success;
  }

  @override
  Future<bool> update(String documentID, data) async{
    return await insert(documentID, productData: data);
  }

/*  @override
  Future<bool> update({String documentID,@required var productData})async {
    return insert(documentID, productData: data);
  }*/

 /* Future<List> savePictures({List pictures}) async{
    List urlList = List();

    for (var element in pictures) {
      print("elemente is FILE? ${element is File}");
      StorageUploadTask task = FirebaseStorage.instance
          .ref()
          .child( DateTime
          .now()
          .millisecondsSinceEpoch
          .toString()).putFile(element);

      StorageTaskSnapshot taskSnapshot = await task.onComplete;
      String url = await taskSnapshot.ref.getDownloadURL();
      print("URL $url");
      urlList.add(url);

    }

    print("URL LIST: $urlList");
    return urlList;
  }*/

  Future<String> savePictures({File pictures}) async{
    String url;

    StorageUploadTask task = FirebaseStorage.instance
        .ref()
        .child( DateTime
        .now()
        .millisecondsSinceEpoch
        .toString()).putFile(pictures);

    StorageTaskSnapshot taskSnapshot = await task.onComplete.timeout(Duration(seconds: 10), onTimeout: (){
      print("Foto timeout");
      task.cancel();
      return null;
    });
    if( taskSnapshot != null) url = await taskSnapshot.ref.getDownloadURL();

    print("URL $url");

    return url;
  }

  Future deletePictures(String url) async{
    await FirebaseStorage.instance.ref().getStorage().getReferenceFromUrl(url).then((value) => value.delete());
  }
}