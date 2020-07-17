import 'package:mobx/mobx.dart';

part 'alert_dialog_controller.g.dart';

class AlertDialogController = _AlertDialogController with _$AlertDialogController;

abstract class _AlertDialogController with Store {



  @observable
  String colorName;

  @observable
  String amount;

  @computed
  bool get enabledButton => (colorName.isNotEmpty && double.tryParse(amount) != null);

  @action
  void setColorName(String text){colorName = text;}

  @action
  void setAmount(String text){amount = text;}

  _AlertDialogController({this.colorName, this.amount});
}