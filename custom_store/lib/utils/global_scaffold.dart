import 'package:flutter/material.dart';

class GlobalScaffold {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  void showSnackBar(SnackBar snackBar){
    scaffoldKey.currentState.showSnackBar(snackBar);
  }
}