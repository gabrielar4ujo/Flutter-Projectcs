import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:mobx/mobx.dart';

part 'controller_login_page.g.dart';

class ControllerLoginPage = _ControllerLoginPage with _$ControllerLoginPage;

abstract class _ControllerLoginPage with Store {
  void _loadDataCategory() {
    print("ControllerLoginPage: Criando StockSnapshot");

    try {
      _categorySnapshot = Firestore.instance
          .collection("stores")
          .document(user.uid)
          .collection("stock")
          .orderBy("time")
          .snapshots();
    } catch (e) {}
  }

  void _loadDataSalesman() {
    print("ControllerLoginPage: Criando SalesmanSnapshot");

    try {
      _salesmanListSnapshot = Firestore.instance
          .collection("stores")
          .document(user.uid)
          .collection("salesman")
          .orderBy("time", descending: true)
          .snapshots();
    } catch (e) {}
  }

  void _loadDataSales({@required String year, @required String month}) {
    print("LoadDateSales");
    print("Year: $year");
    print("Month: $month");

    try {
      _salesSnapshot = Firestore.instance
          .collection("stores")
          .document(user.uid)
          .collection("sales")
          .orderBy("time", descending: true)
          .snapshots();
    } catch (e) {}
  }

  Stream<QuerySnapshot> getSalesSnapshot(
      {@required String year,
      @required String month,
      bool changedDate = false}) {
    if (_salesSnapshot == null || changedDate) {
      _loadDataSales(year: year, month: month);
    }
    return _salesSnapshot;
  }

  Stream<QuerySnapshot> getCategorySnapshot() {
    if (_categorySnapshot == null) {
      _loadDataCategory();
    }
    return _categorySnapshot;
  }

  Stream<QuerySnapshot> getSalesmanListSnapshot() {
    if (_salesmanListSnapshot == null) _loadDataSalesman();
    return _salesmanListSnapshot;
  }

  @action
  Future<Null> setIsLogged() async {
    if (user == null) {
      print("Loading User");
      user = await auth.currentUser();
    }
    _isLogged = user != null;
  }

  Future<Null> loadCurrentUser() async {
    _isLoading = true;

    if (isLogged) {
      if (salesMap.length == 0) {
        QuerySnapshot docUser = await Firestore.instance
            .collection("stores")
            .document(user.uid)
            .collection("vendas")
            .getDocuments();

        await Firestore.instance
            .collection("users")
            .document(user.uid)
            .get()
            .then((value) => userName = value.data["name"]);
        print("user!=null");

        docUser.documents.forEach((element) {
          print(" Element ${element.documentID}");
          this.salesMap.add(element.data);
        });
        print(this.salesMap);
      }
    }
    _isLoading = false;
  }

  @action
  Future<dynamic> login({String email, String pass}) async {
    dynamic success = false;
    _isLoading = true;
    await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: pass)
        .then((value) {
      setIsLogged();
    }).catchError((error) {
      success = error;
    });
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

  Stream<QuerySnapshot> _salesmanListSnapshot;

  Stream<QuerySnapshot> _salesSnapshot;

  _ControllerLoginPage() {
    setIsLogged();
    //_loadCurrentUser();
    //_loadDataSalesman();
  }

  int timeOut = 5;
}
