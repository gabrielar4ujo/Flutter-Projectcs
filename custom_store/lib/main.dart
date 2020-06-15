import 'package:customstore/pages/home_page/home_page.dart';
import 'package:customstore/pages/login_page/controllers_login_page/controller_login_page.dart';
import 'package:customstore/pages/login_page/login_page.dart';
import 'package:customstore/pages/splash_page/splash_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';

void main() {

  runApp(MyApp());
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  final getIt = GetIt.instance;
  getIt.registerLazySingleton<ControllerLoginPage>(() => ControllerLoginPage());

  //Firestore.instance.collection("stores").document("antonio").get().then((value) => print(value.data["nome"]));

}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Custom Store',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        primaryColor: Colors.deepPurple,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: SplashPage(),
    );
  }
}
