import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

class Register20Page extends StatefulWidget {
  Register20Page({Key key}) : super(key: key);

  @override
  _Register20PageState createState() => _Register20PageState();
}

class _Register20PageState extends State<Register20Page> {
  _launchURL() async {
    const url = 'https://testemmacrzpflutter.000webhostapp.com/Aviso.pdf';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  _launchURL2() async {
    const url = 'https://testemmacrzpflutter.000webhostapp.com/Aviso.pdf';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

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
                    AwesomeDialog(
                        context: context,
                        animType: AnimType.BOTTOMSLIDE,
                        headerAnimationLoop: true,
                        dialogType: DialogType.INFO,
                        btnOkColor: Color.fromRGBO(59, 164, 171, 1),
                        tittle: 'Espera',
                        btnOkText: 'Entendido',
                        dismissOnTouchOutside: false,
                        btnOkOnPress: () {
                          debugPrint('OnClcik');
                          Navigator.pushNamed(context, 'registroCel2.0');
                        },
                        btnCancelIcon: Icons.cancel,
                        btnCancelText: 'Cancelar',
                        btnCancelOnPress: () {},
                        btnOkIcon: Icons.check_circle,
                        body: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              'Al continuar con el proceso de registro aceptas nuestro Términos y Condiciones así como nuestro Aviso de Privacidad.',
                              textAlign: TextAlign.center,
                            ),
                            FlatButton(
                                onPressed: () {
                                  _launchURL();
                                },
                                child: Text('Ver Términos y Condiciones')),
                            FlatButton(
                                onPressed: () {
                                  _launchURL2();
                                },
                                child: Text('Ver Aviso de Privacidad'))
                          ],
                        ),
                        onDissmissCallback: () {
                          debugPrint('Dialog Dissmiss from callback');
                        }).show();
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
