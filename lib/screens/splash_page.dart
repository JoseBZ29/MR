import 'package:ecommerce/screens/Walkthrough_Page.dart';
import 'package:ecommerce/screens/home_page.dart';
import 'package:ecommerce/screens/register_page2.0.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashPage extends StatefulWidget {
  SplashPage({Key key}) : super(key: key);

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 2)).then((_) {
      getBoolValuesSF();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Image.asset(
        'assets/images/splash_secreen.png',
        width: MediaQuery.of(context).size.height,
      )),
    );
  }

  getBoolValuesSF() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool servicioEnCurso = prefs.getBool('servicioEnCurso');
    bool servicioEnCursoPresupuesto =
        prefs.getBool('servicioEnCursoPresupuesto');
    bool servicioEnCursoCotizacion = prefs.getBool('servicioEnCursoCotizacion');
    bool registrado = prefs.getBool('registrado') ?? false;
    if (registrado == false) {
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => Register20Page()));
    } else if (servicioEnCurso == true) {
      Navigator.pushReplacementNamed(context, 'servicioEnCurso');
    } else if (servicioEnCursoCotizacion == true) {
      Navigator.pushReplacementNamed(context, 'servicioEnCursoCot');
    } else if (servicioEnCursoPresupuesto == true) {
      Navigator.pushReplacementNamed(context, 'servicioEnCursoPresupuesto');
    } else {
      Navigator.pushReplacementNamed(context, 'home_page');
    }
  }
}
