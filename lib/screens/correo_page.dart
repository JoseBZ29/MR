import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_country_picker/flutter_country_picker.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CorreoPage extends StatefulWidget {
  CorreoPage({Key key}) : super(key: key);

  @override
  _CorreoPageState createState() => _CorreoPageState();
}

class _CorreoPageState extends State<CorreoPage> {
  Country _selected;
  String _celular;
  String _celular2;
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  bool _isLogin = false;
  String codigo;
  String correo;

  _registro() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final form = _formKey.currentState;
    if (!form.validate()) {
      _scaffoldKey.currentState.hideCurrentSnackBar();

      return;
    }

    form.save();
    prefs.setString('correo', correo);
    Navigator.pushNamed(context, 'passwordPage');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ingresa tu correo electrónico'),
        centerTitle: true,
        backgroundColor: Color.fromRGBO(59, 164, 171, 0.9),
      ),
      body: Center(
        child: ListView(children: <Widget>[
          Column(
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height / 30,
                    left: MediaQuery.of(context).size.width / 30,
                    right: MediaQuery.of(context).size.width / 30),
                child: Form(
                  key: _formKey,
                  child: TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      icon: Icon(Icons.alternate_email),
                      hintText: 'Escribe tu correo electrónico',
                    ),
                    onSaved: (val) {
                      correo = val;
                    },
                    validator: (val) {
                      if (val.isEmpty) {
                        return 'Ingrese un correo electrónico valido';
                      }
                    },
                  ),
                ),
              ),
              Container(
                  padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height / 20,
                      left: MediaQuery.of(context).size.width / 8,
                      right: MediaQuery.of(context).size.width / 8),
                  child: Text(
                    'Recibirás un correo de bienvenida',
                    maxLines: 3,
                    style: GoogleFonts.roboto(
                        fontSize: MediaQuery.of(context).size.height / 35,
                        color: Color.fromRGBO(59, 164, 171, 0.9)),
                    textAlign: TextAlign.center,
                  )),
              Container(
                  padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height / 15),
                  child: FlatButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0)),
                      padding: EdgeInsets.only(
                          top: MediaQuery.of(context).size.width / 35,
                          bottom: MediaQuery.of(context).size.width / 35,
                          left: MediaQuery.of(context).size.height / 15,
                          right: MediaQuery.of(context).size.height / 15),
                      color: Color.fromRGBO(59, 164, 171, 0.9),
                      onPressed: () {
                        _registro();
                      },
                      child: Text(
                        'Enviar',
                        style: TextStyle(
                            fontSize: MediaQuery.of(context).size.height / 35,
                            color: Colors.white),
                      ))),
              Container(
                  margin: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height / 6),
                  child: Image.asset(
                    'assets/images/logoMe.png',
                    scale: 1.5,
                  ))
            ],
          ),
        ]),
      ),
    );
  }
}
