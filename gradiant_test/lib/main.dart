import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main(){
  runApp(MaterialApp(
    title: "Gradient",
    home: Home(),
  ));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {



  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([]);
    return Scaffold(
      resizeToAvoidBottomPadding: false, //Retira o espaçamento dos botões de touch de voltar, etc
      body: Container(
        width: double.maxFinite,
        child: Column(
          children: <Widget>[

            Padding(
              padding: EdgeInsets.only(top: 75),
              child: Icon(Icons.attach_money, size: 120, color: Colors.white,),
            ),
            Text("Expense Helper", style: TextStyle(color: Colors.white, fontSize: 35, fontWeight: FontWeight.bold),),
            _buttonFirst("VER LISTA DE ITENS",75.0),
            _buttonFirst("VER RESULTADOS",10.0),

          ],
        ),
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Color(0xFF0F8AE7),Color(0xFF377896),Color(0xFF4AD3AC)])
          ),

      ),

    );
  }
}

Container _buttonFirst (String text, double padding){

  return Container(
    decoration: BoxDecoration(
      color: Color(0x00FFFFFF)
    ),
    padding: EdgeInsets.only(top:padding),
    width: 240,
    child: RaisedButton(
      padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 24.0),
      shape: new RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
          ),
      onPressed: (){
        print("airla");
      },
      color: Color(0x00FFFFFF),
      textColor: Colors.white,
      child: Text(text.toUpperCase(),
          style: TextStyle(fontSize: 14)),),
  );

}