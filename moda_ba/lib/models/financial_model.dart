import 'package:flutter/cupertino.dart';
import 'package:moda_ba/helpers/products_helper.dart';
import 'package:scoped_model/scoped_model.dart';

class FinancialModel extends Model{

  ProductHelper producthHelper = ProductHelper();

  bool isLoading = false;

  List<String> yearsList = List();

  List<String> list = ["Janeiro","Fevereiro","Março", "Abril", "Maio", "Junho", "Julho","Agosto","Setembro", "Outubro", "Novembro", "Dezembro"];

  Map<String, Map<String,Product>> lastPurchaseMap ;

  Map<String, Map<String,dynamic>> dataMap;


  @override
  void addListener(VoidCallback listener) {
    super.addListener(listener);
    _loadingData();
  }

  FinancialModel();

  static FinancialModel of(BuildContext context) => ScopedModel.of<FinancialModel>(context);

  Future<Null> _loadingData() async {
    isLoading = true;
    notifyListeners();
    dataMap = await producthHelper.getAllContacts();
    _loadingLastPurchase();

  }

  void _loadingYearList(){
    yearsList.addAll(dataMap.keys);
    print(yearsList);
  }

  void _loadingLastPurchase() async{
    lastPurchaseMap = await producthHelper.getLastMonthPurchase();
    isLoading = false;
    _loadingYearList();
    notifyListeners();
    //print("map test $mapTest");
  }

  void save(Product p){
    producthHelper.saveContact(p);
    _loadingData();
  }

}