import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:customstore/helpers/category_helper_interface.dart';
import 'package:customstore/pages/login_page/controllers_login_page/controller_login_page.dart';
import 'package:get_it/get_it.dart';

class SalesmanHelper implements CategoryHelperI {
  String userUID;

  SalesmanHelper() {
    this.userUID = GetIt.I.get<ControllerLoginPage>().user.uid;
  }

  @override
  Future<bool> delete(String documentID) async {
    bool success = false;

    await Firestore.instance
        .collection("stores")
        .document(userUID)
        .collection("salesman")
        .document(documentID)
        .delete()
        .whenComplete(() => success = true)
        .catchError((e) => success = false)
        .timeout(Duration(seconds:  GetIt.I.get<ControllerLoginPage>().timeOut), onTimeout: () {
      success = false;
      return;
    });

    return success;
  }

  @override
  Future<bool> insert(String name, {String comission}) async {
    bool success = false;


    await Firestore.instance
        .collection("stores")
        .document(userUID)
        .collection("salesman")
        .add({
          "comission": comission,
          "name": name,
          "time": FieldValue.serverTimestamp()
        })
        .whenComplete(() => success = true)
        .catchError((e) => success = false)
        .timeout(Duration(seconds:  GetIt.I.get<ControllerLoginPage>().timeOut), onTimeout: () {
          success = false;
          return;
        });

    return success;
  }

  @override
  Future<bool> update(String documentID, data) async {
    bool success = false;

    await Firestore.instance
        .collection("stores")
        .document(userUID)
        .collection("salesman")
        .document(documentID)
        .updateData({"name": data.name, "comission": data.comission.toStringAsFixed(2)})
        .whenComplete(() => success = true)
        .catchError((e) => success = false)
        .timeout(Duration(seconds:  GetIt.I.get<ControllerLoginPage>().timeOut), onTimeout: () {
          success = false;
          return;
        });

    return success;
  }
}
