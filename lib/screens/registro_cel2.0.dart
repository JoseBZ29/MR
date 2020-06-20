import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_country_picker/flutter_country_picker.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RegistroCel2Page extends StatefulWidget {
  RegistroCel2Page({Key key}) : super(key: key);

  @override
  _RegistroCel2PageState createState() => _RegistroCel2PageState();
}

class _RegistroCel2PageState extends State<RegistroCel2Page> {
  Country _selected;
  String _celular;
  String _celular2;
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  bool _isLogin = false;
  String codigo;

  _registro() async {
    codigo = _selected.dialingCode.toString();
    print(codigo);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final form = _formKey.currentState;
    if (!form.validate()) {
      _scaffoldKey.currentState.hideCurrentSnackBar();
      setState(() {
        _isLogin = false;
      });
      return;
    }
    form.save();
    _celular2 = '+' + codigo + _celular;
    print('Celular: $_celular2');
    prefs.setString('celular', _celular);
    FirebaseAuth _auth = FirebaseAuth.instance;
    print('asasa');
    _auth.verifyPhoneNumber(
        phoneNumber: _celular2,
        timeout: Duration(seconds: 60),
        verificationCompleted: (AuthCredential credential) async {
          Navigator.of(context).pop();

          AuthResult result = await _auth.signInWithCredential(credential);

          FirebaseUser user = result.user;

          if (user != null) {
            FirebaseAuth.instance.signOut();
            //globals.celular=phone;
            Navigator.pushNamed(context, 'correoPage');
          } else {
            print("Error");
          }

          //This callback would gets called when verification is done auto maticlly
        },
        verificationFailed: (AuthException exception) {
          print('error');
          print(exception.code);
          print(exception.message);
        },
        codeSent: (String verificationId, [int forceResendingToken]) {
          prefs.setString('verificationId', verificationId);
          Navigator.pushNamed(context, 'validarCel2.0');
        },
        codeAutoRetrievalTimeout: null);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ingresa tu número de celular'),
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
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                      icon: CountryPicker(
                        showDialingCode: true,
                        showName: false,
                        onChanged: (Country country) {
                          setState(() {
                            _selected = country;
                          });
                        },
                        selectedCountry: _selected,
                      ),
                      hintText: 'Escribe tu número',
                    ),
                    onSaved: (val) {
                      _celular = val;
                    },
                    validator: (val) {
                      if (val.isEmpty) {
                        return 'Ingrese un número de celular';
                      } else {
                        return null;
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
                    'Recibirás un mensaje con el código de validación',
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
                        'Enviar confirmación',
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
