import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mobx/mobx.dart';

part 'controller_login_page.g.dart';

class ControllerLoginPage = _ControllerLoginPage with _$ControllerLoginPage;

abstract class _ControllerLoginPage with Store {
  void _loadData() {

    print("ControllerLoginPage: Criando Snapshot");

    try {
      _categorySnapshot = Firestore.instance
          .collection("stores")
          .document(user.uid)
          .collection("stock")
          .orderBy("time")
          .snapshots();
    }
    catch(e){

    }
  }

  void _loadDataSalesman(){

    print("ControllerLoginPage: Criando SalesmanSnapshot");

    try {
      _salesmanListSnapshot = Firestore.instance
          .collection("stores")
          .document(user.uid)
          .collection("salesman")
          .orderBy("time", descending: true)
          .snapshots();
    }
    catch(e){

    }
  }

  Stream<QuerySnapshot> getCategorySnapshot() {
    if (_categorySnapshot == null) _loadData();
    return _categorySnapshot;
  }

  Stream<QuerySnapshot> getSalesmanListSnapshot(){
    if (_salesmanListSnapshot == null) _loadDataSalesman();
    return _salesmanListSnapshot;

  }

  Future<Null> _loadCurrentUser() async {
    _isLoading = true;
    if (user == null) user = await auth.currentUser();
    if (user != null) {
      _isLogged = true;
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
    } else {
      _isLogged = false;
    }
    _isLoading = false;
  }

  @action
  Future<Null> login({String email, String pass}) async {
    print("email $email");
    _isLoading = true;
    await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: pass)
        .then((value) {
      _loadCurrentUser();
    }).catchError((e) {
      print("error");
    });
    _isLoading = false;
    print("continua");
  }

  @action
  void logout() {
    auth.signOut();
    user = null;
    _isLogged = false;
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

  _ControllerLoginPage() {
    _loadCurrentUser();
    //_loadDataSalesman();
  }
}
