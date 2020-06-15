import 'package:mobx/mobx.dart';
import 'package:sliding_sheet/sliding_sheet.dart';

part 'home_page_controller.g.dart';

class HomePageController = _HomePageController with _$HomePageController;

abstract class _HomePageController with Store {

  SheetController sheetController = SheetController();

  @observable
  String _year = DateTime.now().year.toString();

  @computed
  String get year => _year;

  @action
  void yearChanged (String year){
    print(year);
    _year = year;
  }

  @observable
  bool _isExpasion = false;

  @computed
  bool get isExpasion => _isExpasion;

  @action
  void expasionTile(bool expasion){
    if(expasion) {
      //_iconData = Icons.expand_more;
      sheetController.collapse();
      _isExpasion = true;
    }

    else {
      //_iconData = Icons.expand_less;
      sheetController.expand();
      _isExpasion = false;
    }
  }


  @observable
  bool _obscureSale = true;

  @computed
  bool get obscureSale => _obscureSale;

  @action
  void changeObscureSaleState() => _obscureSale = !_obscureSale;

}