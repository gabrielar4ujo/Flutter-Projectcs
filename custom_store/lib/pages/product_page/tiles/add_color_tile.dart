import 'package:flutter/material.dart';

class AddColorTile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 2),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(.4),
        borderRadius: BorderRadius.circular(5),
      ),
      height: 60,
      width: 50,
      child: Center(
        child: Icon(Icons.add, color: Colors.white,),
      ),
    );
  }
}
