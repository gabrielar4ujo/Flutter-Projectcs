import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:mobx/mobx.dart';

part 'controller_login_page.g.dart';

class ControllerLoginPage = _ControllerLoginPage with _$ControllerLoginPage;

abstract class _ControllerLoginPage with Store {
  void _loadDataCategory() {
    try {
      _categorySnapshot = Firestore.instance
          .collection("stores")
          .document(user.uid)
          .collection("stock")
          .orderBy("time")
          .snapshots();
    } catch (e) {}
  }

  void _loadBestSellingProduct() {
    try {
      _bestSellingProductSnapshot = Firestore.instance
          .collection("stores")
          .document(user.uid)
          .collection("salesCounter")
          .orderBy("counter", descending: true)
          .snapshots();
    } catch (e) {}
  }

  void categorySnapshotListen({@required String categoryID}) {
    streamSubscription = _categorySnapshot.listen((event) {
      hasCategory = false;
      event.documents.forEach((element) {
        if (element.documentID == categoryID) {
          categoryEvent = element.data["listProducts"];

          hasCategory = true;
          return;
        }
      });
    });
  }

  void categorySnapshotCancel() async {
    await streamSubscription.cancel();
    categoryEvent = null;
    hasCategory = null;
  }

  void _loadDataSalesman() {
    try {
      _salesmanListSnapshot = Firestore.instance
          .collection("stores")
          .document(user.uid)
          .collection("salesman")
          .orderBy("time", descending: true)
          .snapshots();
    } catch (e) {}
  }

  void _loadDataSales() {
    try {
      _salesSnapshot = Firestore.instance
          .collection("stores")
          .document(user.uid)
          .collection("sales")
          .orderBy("time", descending: true)
          .snapshots();
    } catch (e) {}
  }

  Future<QuerySnapshot> getFutureCategorySnapshot() async {
    try {
      return await Firestore.instance
          .collection("stores")
          .document(user.uid)
          .collection("stock")
          .orderBy("time")
          .getDocuments();
    } catch (e) {
      return null;
    }
  }

  Stream<QuerySnapshot> getSalesSnapshot() {
    if (_salesSnapshot == null) {
      _loadDataSales();
    }
    return _salesSnapshot;
  }

  Future<DocumentSnapshot> getStoreName() {
    try {
      return Firestore.instance.collection("stores").document(user.uid).get();
    } catch (e) {}
    return Future.value();
  }

  Future<QuerySnapshot> getSalesFuture() {
    try {
      return Firestore.instance
          .collection("stores")
          .document(user.uid)
          .collection("sales")
          .orderBy("time", descending: true)
          .getDocuments();
    } catch (e) {}
    return Future.value();
  }

  Stream<QuerySnapshot> getCategorySnapshot() {
    if (_categorySnapshot == null) {
      _loadDataCategory();
    }
    return _categorySnapshot;
  }

  Stream<QuerySnapshot> getBestSellingProductSnapshot() {
    if (_bestSellingProductSnapshot == null) {
      _loadBestSellingProduct();
    }
    return _bestSellingProductSnapshot;
  }

  Stream<QuerySnapshot> getSalesmanListSnapshot() {
    if (_salesmanListSnapshot == null) _loadDataSalesman();
    return _salesmanListSnapshot;
  }

  @action
  Future<Null> setIsLogged() async {
    if (user == null) {
      user = await auth.currentUser();
    }
    _isLogged = user != null;
  }

  Future<bool> loadCurrentUser() async {
    _isLoading = true;

    if (isLogged) {
      if (salesMap.length == 0) {
        QuerySnapshot docUser = await Firestore.instance
            .collection("stores")
            .document(user.uid)
            .collection("vendas")
            .getDocuments();

        try {
          await Firestore.instance
              .collection("users")
              .document(user.uid)
              .get()
              .then((value) => userName = value.data["name"]);
        } catch (e) {
          return false;
        }
        docUser.documents.forEach((element) {
          this.salesMap.add(element.data);
        });
      }
    }
    _isLoading = false;
    return true;
  }

  @action
  Future<dynamic> login({String email, String pass}) async {
    dynamic success = false;
    _isLoading = true;
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: pass);

      await setIsLogged();
    } catch (e) {
      success = e.code;
    }
    _isLoading = false;
    return success ?? false;
  }

  @action
  void logout() {
    auth.signOut();
    user = null;
    _isLogged = false;
    dataMap = ObservableMap();
    salesMap = ObservableList();
    /* _categorySnapshot = null;
    _salesmanListSnapshot = null;*/
  }

  @observable
  bool _isLoading = false;

  @computed
  bool get isLoading => _isLoading;

  @observable
  FirebaseUser user;

  String userName;

  FirebaseAuth auth = FirebaseAuth.instance;

  @observable
  ObservableMap<String, dynamic> dataMap;

  @observable
  ObservableList<Map> salesMap = ObservableList();

  @observable
  bool _isLogged;

  @computed
  bool get isLogged => _isLogged;

  Stream<QuerySnapshot> _categorySnapshot;

  Map categoryEvent;

  bool hasCategory;

  StreamSubscription streamSubscription;

  Stream<QuerySnapshot> _salesmanListSnapshot;

  Stream<QuerySnapshot> _salesSnapshot;

  Stream<QuerySnapshot> _bestSellingProductSnapshot;

  _ControllerLoginPage() {
    setIsLogged();
  }

  int timeOut = 5;
}
