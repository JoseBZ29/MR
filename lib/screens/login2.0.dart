import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Login2Page extends StatefulWidget {
  Login2Page({Key key}) : super(key: key);

  @override
  _Login2PageState createState() => _Login2PageState();
}

class _Login2PageState extends State<Login2Page> {
  double screenHeight;
  var password;
  String celular;
  String pass;
  String correo;
  String identificador;
  List usuario;
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  bool _isLogin = false;

  _login() async {
    try {
      if (_isLogin) return;
      setState(() {
        _isLogin = true;
      });

      _scaffoldKey.currentState.showSnackBar(SnackBar(
        content: Text('Iniciando Session....'),
      ));

      final form = _formKey.currentState;

      if (!form.validate()) {
        _scaffoldKey.currentState.hideCurrentSnackBar();
        setState(() {
          _isLogin = false;
        });
        return;
      }
      form.save();
      print('holla');
      Firestore.instance
          .collection('Usuarios')
          .where("Celular", isEqualTo: celular)
          .snapshots()
          .listen((data) {
        data.documents.forEach((doc) {
          pass = doc["Contraseña"];
          identificador = doc.documentID;
          correo=doc['Correo'];
        });
      });
      await Future.delayed(Duration(seconds: 3));
      print(pass);
      print(celular);
      print(password);
      if (pass == password) {
        SharedPreferences pref = await SharedPreferences.getInstance();
        pref.setString('identificadorUser', identificador);
        pref.setString('identificador', identificador);
        pref.setString('correo', correo);
        pref.setBool('registrado', true);
        Navigator.pushReplacementNamed(context, 'home_page');
      } else {
        _scaffoldKey.currentState.showSnackBar(SnackBar(
          content: Text('Error, la informacion es incorrecta.'),
        ));
      }
    } catch (e) {
      print(e);
    }
  }

  Widget upperHalf(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      child: Image.asset(
        'assets/images/Back.png',
        fit: BoxFit.cover,
      ),
    );
  }

  Widget loginCard(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(top: screenHeight / 2.4),
          padding: EdgeInsets.only(left: 10, right: 10),
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            elevation: 8,
            child: Padding(
              padding: const EdgeInsets.all(30.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Align(
                    alignment: Alignment.topCenter,
                    child: Text(
                      "Ingresa tus datos",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Color.fromRGBO(59, 164, 171, 0.9),
                        fontSize: 28,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                        labelText: "Número de celular",
                        hasFloatingPlaceholder: true),
                    validator: (val) {
                      if (val.isEmpty) {
                        return 'Por favor teclee un numero valido';
                      } else {
                        return null;
                      }
                    },
                    onSaved: (val) {
                      setState(() {
                        celular = val;
                      });
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    obscureText: true,
                    decoration: InputDecoration(
                        labelText: "Contraseña", hasFloatingPlaceholder: true),
                    validator: (val) {
                      if (val.isEmpty) {
                        return 'Por favor teclee un contraseña valida ';
                      } else {
                        return null;
                      }
                    },
                    onSaved: (val) {
                      setState(() {
                        password = val;
                      });
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      MaterialButton(
                        onPressed: () {},
                        child: Text(
                          "¿Olvidaste tu contraseña?",
                          style: TextStyle(
                              color: Color.fromRGBO(59, 164, 171, 0.9)),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      FlatButton(
                        child: Text(
                          "Ingresar",
                          style: TextStyle(
                              fontSize:
                                  MediaQuery.of(context).size.height / 50),
                        ),
                        color: Color.fromRGBO(59, 164, 171, 0.9),
                        textColor: Colors.white,
                        padding: EdgeInsets.only(
                            left: MediaQuery.of(context).size.height / 8,
                            right: MediaQuery.of(context).size.height / 8,
                            top: MediaQuery.of(context).size.height / 45,
                            bottom: MediaQuery.of(context).size.height / 45),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5)),
                        onPressed: () {
                          _login();
                        },
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      MaterialButton(
                        onPressed: () {
                          Navigator.pushReplacementNamed(context, 'register2.0');
                        },
                        child: Text(
                          "¿No tienes cuenta?",
                          style: TextStyle(
                              color: Color.fromRGBO(59, 164, 171, 0.9)),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget pageTitle() {
    return Container(
      margin: EdgeInsets.only(top: screenHeight / 15),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Image.asset(
            'assets/images/logoMe2.png',
            scale: 4,
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
        key: _scaffoldKey,
        body: Container(
          child: Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: Stack(
                  children: <Widget>[
                    upperHalf(context),
                    loginCard(context),
                    pageTitle()
                  ],
                ),
              )),
        ));
  }
}
