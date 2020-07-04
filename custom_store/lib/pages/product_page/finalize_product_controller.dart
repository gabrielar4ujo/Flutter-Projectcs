import 'package:flutter/cupertino.dart';
import 'package:mobx/mobx.dart';

part 'finalize_product_controller.g.dart';

class FinalizeProductController = _FinalizeProductController with _$FinalizeProductController;

abstract class _FinalizeProductController with Store {

  _FinalizeProductController({@required this.length});

  final int length;

  @observable
  int _count = 0;

  @observable
  String _operation = "Salvando Imagens...";

  @computed
  int get count => _count;

  @computed
  String get operation => _operation;

  @action
  void increment (){
    _increment();
  }

  void _increment(){
    _count++;
  }

  @action
  void setOperetion (String operation){
    _setOperation(operation);
  }

  void _setOperation (String operation){
    _operation = operation;
  }


}