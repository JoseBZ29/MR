import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class RegistroCompletadoPage extends StatefulWidget {
  RegistroCompletadoPage({Key key}) : super(key: key);

  @override
  _RegistroCompletadoPageState createState() => _RegistroCompletadoPageState();
}

class _RegistroCompletadoPageState extends State<RegistroCompletadoPage> {
  double screenHeight;
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

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
          margin: EdgeInsets.only(top: screenHeight / 2.2),
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
                      "Gracias por registrarte",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.roboto(
                          color: Colors.black,
                          fontSize: MediaQuery.of(context).size.height / 30,
                          fontWeight: FontWeight.w200),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      "Ya puedes utilizar nuestros servicios",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.roboto(
                          color: Colors.black,
                          fontSize: MediaQuery.of(context).size.height / 30,
                          fontWeight: FontWeight.w200),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      FlatButton(
                        child: Text("Aceptar",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize:
                                    MediaQuery.of(context).size.height / 45)),
                        color: Color.fromRGBO(59, 164, 171, 0.9),
                        textColor: Colors.white,
                        padding: EdgeInsets.only(
                            top: MediaQuery.of(context).size.width / 32,
                            bottom: MediaQuery.of(context).size.width / 32,
                            left: MediaQuery.of(context).size.height / 8,
                            right: MediaQuery.of(context).size.height / 8),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5)),
                        onPressed: () {
                          Navigator.pushReplacementNamed(context, 'login2.0');
                        },
                      )
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
