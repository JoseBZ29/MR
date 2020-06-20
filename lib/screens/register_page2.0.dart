import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Register20Page extends StatefulWidget {
  Register20Page({Key key}) : super(key: key);

  @override
  _Register20PageState createState() => _Register20PageState();
}

class _Register20PageState extends State<Register20Page> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(59, 164, 171, 0.9),
        title: Text('Registro'),
        centerTitle: true,
      ),
      body: Center(
        child: ListView(children: <Widget>[
          Column(
            children: <Widget>[
              Container(
                  padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height / 4.5,
                      bottom: MediaQuery.of(context).size.height / 6),
                  child: Image.asset(
                    'assets/images/logoMe.png',
                    scale: 1.5,
                  )),
              FlatButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0)),
                  padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.width / 30,
                      bottom: MediaQuery.of(context).size.width / 30,
                      left: MediaQuery.of(context).size.height / 60,
                      right: MediaQuery.of(context).size.height / 60),
                  color: Color.fromRGBO(59, 164, 171, 0.9),
                  onPressed: () {
                    Navigator.pushNamed(context, 'registroCel2.0');
                  },
                  child: Text(
                    'Número de teléfono móvil',
                    style: GoogleFonts.roboto(
                        color: Colors.white,
                        fontSize: MediaQuery.of(context).size.height / 30),
                  )),
            ],
          ),
        ]),
      ),
      persistentFooterButtons: <Widget>[
        FlatButton(
            onPressed: () {
              Navigator.pushReplacementNamed(context, 'login2.0');
            },
            child: Text('¿Ya tienes cuenta?'))
      ],
    );
  }
}
