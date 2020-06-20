import 'package:ecommerce/routes/routes.dart';
import 'package:ecommerce/screens/home_page.dart';
import 'package:ecommerce/screens/payment.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'screens/splash_page.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([]);
    return MaterialApp(
        
        home: SplashPage(),
        routes: getAplicationRoute(),
        debugShowCheckedModeBanner: false,
    );
  }
}