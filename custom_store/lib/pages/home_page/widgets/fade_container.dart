import 'package:flutter/material.dart';

class FadeContainer extends StatelessWidget {

  final Animation<double> fadeAnimation;

  const FadeContainer({this.fadeAnimation});

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: "LoginToHome",
      child: IgnorePointer(
        ignoring: true,
        child: Opacity(
          opacity: fadeAnimation.value,
          child: Container(
          color: Colors.white,
          ),
        ),
      ),
    );
  }
}
