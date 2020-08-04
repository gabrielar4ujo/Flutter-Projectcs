import 'package:customstore/pages/home_page/home_page.dart';
import 'package:customstore/pages/login_page/controllers_login_page/controller_login_page.dart';
import 'package:customstore/pages/login_page/login_page.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {

  ReactionDisposer disposer;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final controllerLoginPage = GetIt.I.get<ControllerLoginPage>();
    print("ue");
    //controllerLoginPage.logout();
    disposer = reaction((_) => controllerLoginPage.isLogged, (isLogged){
      if(isLogged){
        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => HomePage()));
      }
      else {
        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => LoginPage()));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      alignment: Alignment.center,
      child: Icon(Icons.store, size: 150, color: Colors.deepPurple,),
    );
  }

  @override
  void dispose() {
    disposer();
    super.dispose();
  }


}
