import 'package:flutter/material.dart';

class CustomDividerWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return  Row(children: <Widget>[
      Expanded(
        child: new Container(
            margin: const EdgeInsets.only(left: 40.0, right: 20.0),
            child: Divider(
              color: Colors.deepPurpleAccent,
              height: 40,
            )),
      ),
     Icon(Icons.person, color: Colors.deepPurpleAccent, size: 35,),
      Expanded(
        child: new Container(
            margin: const EdgeInsets.only(left: 20.0, right: 40.0),
            child: Divider(
              color: Colors.deepPurpleAccent,
              height: 40,
            )),
      ),
    ]);
  }
}
