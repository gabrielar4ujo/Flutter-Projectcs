import 'package:mobx/mobx.dart';

part 'home_page_controller.g.dart';

class HomePageController = _HomePageController with _$HomePageController;

abstract class _HomePageController with Store {

  @observable
  String _year = DateTime.now().year.toString();

  @computed
  String get year => _year;

  @action
  void yearChanged (String year){
   
    _year = year;
  }

  @observable
  bool _isExpasion = false;

  @computed
  bool get isExpasion => _isExpasion;

  @observable
  bool _obscureSale = true;

  @computed
  bool get obscureSale => _obscureSale;

  @action
  void changeObscureSaleState() => _obscureSale = !_obscureSale;

}
