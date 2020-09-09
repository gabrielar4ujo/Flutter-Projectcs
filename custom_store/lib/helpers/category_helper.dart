import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:customstore/helpers/category_helper_interface.dart';
import 'package:get_it/get_it.dart';

import '../pages/login_page/controllers_login_page/controller_login_page.dart';

class CategoryHelper implements CategoryHelperI {
  String userUID;

   CategoryHelper() {
    this.userUID = GetIt.I.get<ControllerLoginPage>().user.uid;
  }

  @override
  Future<bool> delete(String documentID) async {
    bool success = false;

    await Firestore.instance
        .collection("stores")
        .document(userUID)
        .collection("stock")
        .document(documentID)
        .delete()
        .whenComplete(() => success = true)
        .catchError((e) => success = false)
        .timeout(Duration(seconds: GetIt.I.get<ControllerLoginPage>().timeOut), onTimeout: () {});

    return success;
  }

  @override
  Future<bool> insert(String categoryName, {String documentID}) async {
    bool success = false;

    await Firestore.instance
        .collection("stores")
        .document(userUID)
        .collection("stock")
        .document(documentID)
        .setData({
          "categoryName": categoryName,
          "time": FieldValue.serverTimestamp(),
        })
        .whenComplete(() => success = true)
        .catchError((exception) {
          success = false;
        })
        .timeout(Duration(seconds:  GetIt.I.get<ControllerLoginPage>().timeOut), onTimeout: () {});

    return success;
  }

  @override
  Future<bool> update(String documentID, newCategoryName) async {
    bool sucess = false;

    await Firestore.instance
        .collection("stores")
        .document(userUID)
        .collection("stock")
        .document(documentID)
        .updateData({"categoryName": newCategoryName})
        .whenComplete(() => sucess = true)
        .catchError((e) => sucess = false)
        .timeout(Duration(seconds:  GetIt.I.get<ControllerLoginPage>().timeOut), onTimeout: () {});

    return sucess;
  }
}
