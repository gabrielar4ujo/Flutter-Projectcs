import 'dart:async';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:customstore/helpers/category_helper_interface.dart';
import 'package:flutter/cupertino.dart';

class CategoryHelper implements CategoryHelperI{

  final String userUID;
  final timeOut = 3;

  CategoryHelper({@required this.userUID});

  @override
  Future<bool> delete(String documentID) async {
    bool success = false;

    await Firestore.instance.collection("stores").document(userUID).collection("stock").document(documentID).delete()
    .whenComplete(() => success = true).catchError((e) => success = false).timeout(Duration(seconds: timeOut), onTimeout: (){

    });

    return success;
  }

  @override
  Future<bool> insert(String categoryName) async{

    bool success = false;

    await Firestore.instance
        .collection("stores")
        .document(userUID)
        .collection("stock").document().setData({
      "categoryName": categoryName
    }).whenComplete(() =>  success = true ).catchError((exception){
    success = false;
    }).timeout(Duration(seconds: timeOut), onTimeout: (){

    });

    return success;
  }

  @override
  Future<bool> update(String documentID, String newCategoryName) async{

    bool sucess = false;

    await Firestore.instance.collection("stores").document(userUID).collection("stock").document(documentID).updateData({"categoryName" : newCategoryName}).whenComplete(() => sucess = true)
    .catchError((e) => sucess = false).timeout(Duration(seconds: timeOut), onTimeout: (){

    });

    return sucess;
  }

}