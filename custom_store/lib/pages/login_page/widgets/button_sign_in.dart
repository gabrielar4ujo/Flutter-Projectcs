import 'package:customstore/pages/home_page/home_page.dart';
import 'package:flutter/material.dart';

class ButtonSignIn extends StatelessWidget {
  final Function loginPressed;
  final bool isLoading;
  final AnimationController animationController;
  final double screenHeight;

  final Animation<double> buttomSqueeze;
  final Animation<double> buttomZoomOut;

  ButtonSignIn({this.loginPressed, this.isLoading, this.animationController, this.screenHeight})
      : buttomSqueeze = Tween(begin: 80.0, end: 50.0).animate(CurvedAnimation(
            parent: animationController, curve: Interval(0.0, 0.150))),
        buttomZoomOut = Tween(begin: 50.0, end:screenHeight).animate(
            CurvedAnimation(
                parent: animationController, curve: Interval(0.5, 1,curve: Curves.bounceOut)));

  Widget _buildAnimation(BuildContext context, Widget child) {
    bool isActivity = loginPressed == null;
    bool loginCompleted = false;

    return Padding(
        padding: EdgeInsets.only(top: buttomZoomOut.value > (screenHeight / 3) ? 0 : 350),
        child:
            GestureDetector(
          onTap: !isActivity || !isLoading
              ? () {
                  animationController.forward();
                  loginPressed().then((value) {
                    if (!value) animationController.reverse();
                    loginCompleted = value;
                  });
                }
              : null,
          child: Hero(
            tag: "LoginToHome",
            child: !loginCompleted && buttomZoomOut.value == 50?
            Container(
              alignment: Alignment.center,
              height: 50,
              width: buttomSqueeze.value,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(40),
                color: !isActivity ? Colors.deepPurpleAccent : Colors.grey[600],
              ),
              child: buttomSqueeze.value < 60
                  ? CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                strokeWidth: 2,
              )
                  : Text("Entrar",
                  style: TextStyle(fontSize: 20, color: Colors.white)),
            ):
            Container(
              height: buttomZoomOut.value,
              width: buttomZoomOut.value,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(buttomZoomOut.value > (screenHeight * .7) ? 0 : 40),
                color: !isActivity ? Colors.white : Colors.grey[600],
              ),
            ),
          )
        ));
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      builder: _buildAnimation,
      animation: animationController,
    );
  }
}
