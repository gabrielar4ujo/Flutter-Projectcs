import 'dart:convert';
import 'dart:ffi';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';

const request = "https://api.hgbrasil.com/finance?key=fe6e76b9";

void main() async {
  runApp(MaterialApp(
    home: Home(),
      theme: ThemeData(
          inputDecorationTheme: InputDecorationTheme(
              enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.white))
          )
      )
  ));
}

Future<Map> getData() async {
  http.Response response = await http.get(request);
  return json.decode(response.body);
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  final realController = TextEditingController();
  final dolarController = TextEditingController();
  final euroController = TextEditingController();

  double dolar,euro;

  void _clearTextEditing(){
    realController.clear();
    dolarController.clear();
    euroController.clear();
  }

  void _realChanged(String text){
    if(text.isEmpty){
      _clearTextEditing();
    }

    double real = double.parse(text);
    dolarController.text = (real / dolar).toStringAsFixed(2);
    euroController.text = (real / euro).toStringAsFixed(2);
  }

  void _dolarChanged(String text){
    if(text.isEmpty){
      _clearTextEditing();
    }

    double dolar = double.parse(text);
    realController.text = (dolar * this.dolar ).toStringAsFixed(2);
    euroController.text = ( (dolar * this.dolar)/euro ).toStringAsFixed(2);
  }

  void _euroChanged(String text){
    if(text.isEmpty){
      _clearTextEditing();
    }

    double euro = double.parse(text);
    realController.text = (euro * this.euro ).toStringAsFixed(2);
    dolarController.text = ( (euro * this.euro)/dolar ).toStringAsFixed(2);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text("\$ Conversor \$", style: TextStyle(color: Colors.black),),
        backgroundColor: Colors.amber,
        centerTitle: true,
      ),
      body: FutureBuilder<Map>(
        future: getData(),
        // ignore: missing_return
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
              break;

            case ConnectionState.waiting:
              return Center(
                child: Text(
                  "Carregando dados...",
                  style: TextStyle(color: Colors.amber),
                ),
              );

            default:
              if(snapshot.hasError){
                return Center(
                    child: Text(
                    "Error ao carregar dados...",
                    style: TextStyle(color: Colors.amber),
          ),
          );
              }else{
                dolar = snapshot.data["results"]["currencies"]["USD"]["buy"];
                euro = snapshot.data["results"]["currencies"]["EUR"]["buy"];
                return SingleChildScrollView(
                  padding: EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Icon(Icons.monetization_on, size: 150, color: Colors.amber),
                      Divider(),
                      buildTextFild("Reais", "R\$", realController, _realChanged),
                      Divider(),
                      buildTextFild("Dólares", "US\$", dolarController, _dolarChanged),
                      Divider(),
                      buildTextFild("Euros", "€", euroController, _euroChanged)
                    ],
                  ),
                );
              }
          }
        },
      ),
    );
  }
}

Widget buildTextFild(String label, String prefix, TextEditingController c, Function f){
  return  TextField(
    keyboardType: TextInputType.numberWithOptions(decimal: true),
    onChanged: f,
    controller: c,
    decoration: InputDecoration(
      labelText: label,
      labelStyle: TextStyle(color: Colors.amber),
      border: OutlineInputBorder(),
      prefixText: prefix,
      prefixStyle: TextStyle(
        color: Colors.amber,
        fontSize: 25.0,
      ),
    ),
    style: TextStyle(
        color: Colors.amber, fontSize: 25
    ),
  );
}