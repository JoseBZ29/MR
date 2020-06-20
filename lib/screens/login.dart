import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce/screens/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login/flutter_login.dart';
import 'package:shared_preferences/shared_preferences.dart';

String mail,mailf,pass,passf,nombre,phone;

class LoginScreen extends StatelessWidget {

  Duration get loginTime => Duration(milliseconds: 2250);

  Future<String> _authUser(LoginData data) {
    mail = data.name;
    pass = data.password;   
    return Future.delayed(loginTime).then((_) {
      Firestore.instance
        .collection('Usarios')
        .where("Correo", isEqualTo: mail)
        .snapshots()
        .listen((data){
          data.documents.forEach((doc){ 
            mailf = doc["Correo"];
            passf = doc["Contraseña"];
            nombre = doc["Nombre"];
            phone = doc["Telefono"];
          });
        });
        if(mail.toString() != mailf.toString() || pass.toString() != passf.toString()){
          return 'Usuario o Contraseña Incorrectos';
        }
      return null;
    });
  }

  Future<String> _recoverPassword(String name) {
    return Future.delayed(loginTime).then((_) {
      return 'Usuario no encontrado';
    });
  }

  @override
  Widget build(BuildContext context) {
    return FlutterLogin(
      //title: 'MeRecomiendas',
      logo: 'assets/images/logo_splash.png',
      onLogin: _authUser,
      //onSignup: _authUser,
      onSubmitAnimationCompleted: () async{
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setBool('registrado', true);
        prefs.setString('nombre', nombre);
        print(nombre);
        prefs.setString('correo', mailf);
        print(mailf);
        prefs.setString('pass', passf);
        print(passf);
        prefs.setString('telefono', phone);
        print(phone);
        prefs.setString('url', "https://res.cloudinary.com/iphoneauta/image/upload/v1587579319/logo_splash_l8hd6e.png");
        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => HomePage(),
        ));
      },
      onRecoverPassword: _recoverPassword,
    );
  }
  
}