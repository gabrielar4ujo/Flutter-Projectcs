import 'package:flutter/material.dart';

class CustomProgressBarWidgets extends StatelessWidget {

  final int value;
  final int lenght;
  final String text;
  const CustomProgressBarWidgets({Key key, this.value, this.lenght, @required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(bottom :25.0, top: 5),
          child: Text(text, textAlign: TextAlign.center, style: TextStyle(fontSize: 14),),
        ),
        CircularProgressIndicator(
        ),
        Padding(
          padding: const EdgeInsets.only(top :25.0, bottom: 5),
          child: Text("$value/$lenght"),
        ),

      ],
    );
  }
}
