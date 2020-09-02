import 'package:flutter/material.dart';

class TestPage extends StatefulWidget {
  @override
  _TestPageState createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  TextEditingController _t1Controller;
  TextEditingController _t2Controller;

  @override
  void initState() {
    _t1Controller = TextEditingController();
    _t2Controller = TextEditingController();
    _t1Controller.addListener(() {
      final text = filter(_t1Controller.text ?? null);
      _t1Controller.value = _t1Controller.value.copyWith(
        text: text,
        selection:
            TextSelection(baseOffset: text.length, extentOffset: text.length),
        composing: TextRange.empty,
      );
    });
    super.initState();
  }

  String filter(String text) {
    if (text == null) return "";
    if (int.parse(text) > 15) {
      return "15";
    } else if (int.parse(text) <= 0) {
      return "1";
    }

    return text;
  }

  void elderFilter(String text) {
    if (text == null) return;
    if (int.parse(text) > 15) {
      _t1Controller
          . //value = _t1Controller.value.copyWith(
          //   text: "15",
          //   selection:
          //       TextSelection(baseOffset: text.length, extentOffset: text.length),
          //   composing: TextRange.empty,
          // ); //Não funciona assim
          clear();
    } else if (int.parse(text) <= 0) {
      this._t1Controller.text = "1"; //Não funciona mais assim
    }
    print("Value -> ${this._t1Controller.text}");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 40),
        child: Column(
          children: [
            TextFormField(
              decoration: InputDecoration(hintText: "t1Controller"),
              onChanged: elderFilter,
              controller: _t1Controller,
            ),
            SizedBox(
              height: 5,
            ),
            TextFormField(
              decoration: InputDecoration(hintText: "t2Controller"),
              controller: _t2Controller,
            ),
            SizedBox(
              height: 15,
            ),
            RaisedButton(
              child: Text("Button"),
              onPressed: () {
                // _t2Controller.text = _t1Controller.text;
                // _t1Controller.clear();
                print("Button: Value -> ${this._t1Controller.text}");
              },
            )
          ],
        ),
      ),
    );
  }
}
