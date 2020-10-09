import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mobx/mobx.dart';
part 'sale_page_controller.g.dart';

class SalesPageController = _SalesPageControllerBase with _$SalesPageController;

abstract class _SalesPageControllerBase with Store {
  _SalesPageControllerBase() {
    setYear();
    setMonth();
  }

  @observable
  bool enabledFloatingActionButton = false;

  @observable
  ObservableList _observableList;

  @computed
  ObservableList get observableList => _observableList;

  @action
  void setObservableList(List l) {
    _observableList = ObservableList();
    if (l != null) _observableList.addAll(l);
  }

  @action
  void setNullObservableList() {
    _observableList = null;
  }

  @observable
  String _year;

  @computed
  String get year => _year;

  @action
  void setYear({String year}) {
    _year = year ?? DateTime.now().year.toString();
  }

  @observable
  String _month;

  @computed
  String get month => _month;

  @action
  void setMonth({String month}) {
    _month = month ?? DateTime.now().month.toString();
  }

  DocumentSnapshot getListToAddSalesPage() {
    for (DocumentSnapshot d in _observableList) {
      Timestamp t = d.data["time"];
      if (year == t.toDate().year.toString()) {
        return d;
      }
    }

    return null;
  }
}
