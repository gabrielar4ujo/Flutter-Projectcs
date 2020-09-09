import 'package:customstore/pages/login_page/controllers_login_page/controller_login_page.dart';
import 'package:customstore/pages/splash_page/splash_page.dart';
import 'package:customstore/utils/global_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';

void main() {
  runApp(MyApp());
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  final getIt = GetIt.instance;

  getIt.registerLazySingleton<ControllerLoginPage>(() => ControllerLoginPage());
  getIt.registerSingleton(GlobalScaffold());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      builder: (context, child) => Scaffold(
        body: child,
        key: GetIt.I.get<GlobalScaffold>().scaffoldKey,
      ),
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
