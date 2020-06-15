import 'package:flutter/material.dart';

class ButtonBox extends StatelessWidget {

  final Function _functionPage;
  final String _namePage;
  final IconData _iconPage;

  const ButtonBox(this._namePage, this._iconPage, this._functionPage);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: _functionPage,
      child: Container(
        decoration: BoxDecoration(
            border: Border.all(color: Colors.grey[100], width: 1)
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(_iconPage),
            const SizedBox(height: 15,),
            Text(_namePage, textAlign: TextAlign.center),
          ],
        ),
      ),
    );
  }
}
