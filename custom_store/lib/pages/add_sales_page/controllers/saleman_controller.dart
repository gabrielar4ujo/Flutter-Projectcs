import 'package:customstore/models/salesman.dart';
import 'package:mobx/mobx.dart';

part 'saleman_controller.g.dart';

class SalemanController = _SalemanController with _$SalemanController;

abstract class _SalemanController with Store {

  //@observable
  String salesmanName;

  //@observable
  double salesmanComission;

  //@action
  void setSalesman(Salesman s){
    if(s != null){
      salesmanName = s.name;
      salesmanComission = s.comission;
    }
  }
}
