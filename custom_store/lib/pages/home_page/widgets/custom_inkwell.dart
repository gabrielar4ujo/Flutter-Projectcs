import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomInkwell extends StatelessWidget {
  final Function _functionPage;
  final String _namePage;
  final IconData _iconPage;

  const CustomInkwell(this._namePage, this._iconPage, this._functionPage);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
          left: _namePage == "Financeiro" ? 20 : 4,
          right: _namePage == "Produto mais vendido" ? 20 : 4),
      width: MediaQuery.of(context).size.width * .27,
      padding: EdgeInsets.symmetric(horizontal: 4),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(3),
          boxShadow: [
            BoxShadow(
              color: Colors.grey[800].withOpacity(0.4),
              blurRadius: 8.0, // soften the shadow
              spreadRadius: 2.0, //exten// d
            )
          ]),
      child: InkWell(
        onTap: _functionPage,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(_iconPage),
            const SizedBox(
              height: 15,
            ),
            Text(
              _namePage,
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
