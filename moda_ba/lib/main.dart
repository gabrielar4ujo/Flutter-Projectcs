import 'package:flutter/material.dart';
import 'package:moda_ba/pages/home_page.dart';
import 'package:scoped_model/scoped_model.dart';
import 'models/financial_model.dart';


void main(){
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return  ScopedModel<FinancialModel>(
      model: FinancialModel(),
      child: MaterialApp(
        theme: ThemeData(
            primaryColor: Colors.deepPurple[500]
        ),
        home: HomeTab(),
        debugShowCheckedModeBanner: false,
      )
    );
  }
}