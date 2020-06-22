import 'dart:math';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce/qr.dart';
import 'package:email_launcher/email_launcher.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'chat.dart';

class ServicioEnCursoCotPage extends StatefulWidget {
  ServicioEnCursoCotPage({Key key}) : super(key: key);

  @override
  _ServicioEnCursoCotPageState createState() => _ServicioEnCursoCotPageState();
}

class _ServicioEnCursoCotPageState extends State<ServicioEnCursoCotPage> {
  modal() {
    AwesomeDialog(
        context: context,
        animType: AnimType.BOTTOMSLIDE,
        headerAnimationLoop: true,
        dialogType: DialogType.WARNING,
        btnOkColor: Color.fromRGBO(59, 164, 171, 1),
        tittle: 'Finalizar servicio',
        btnOk: FlatButton(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(18.0)),
          onPressed: () async{
            SharedPreferences prefs = await SharedPreferences.getInstance();
          String identificador = prefs.getString('IdenCot');
          Random random = new Random();
          int randomNumber = random.nextInt(1474648) + 13797;
          String iden2=prefs.getString('iden2');
          String pedido=prefs.getString('pedido2');
          await Firestore.instance
              .collection('PedidosCotizaciones')
              .document(identificador)
              .updateData({"EstadoQRFinalizar":"pendiente","QRFinalizar":"$randomNumber"});
            Navigator.pushReplacementNamed(context, 'qrPageFinalizarCot',arguments: QR(randomNumber.toString(), iden2, pedido));
          },
          child: Text('Entendido',style: TextStyle(fontSize: MediaQuery.of(context).size.height/50,color: Colors.white),),
          color: Color.fromRGBO(59, 164, 171, 1),
        ),
        btnCancel: FlatButton(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(18.0)),
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text('Cancelar',style: TextStyle(fontSize: MediaQuery.of(context).size.height/45,color: Colors.white),),
          color: Colors.red,
        ),
        dismissOnTouchOutside: false,
        desc:
            '¿Esta usted seguro que quiere finalizar el servicio?, para finalizarlo le pediremos que nuevamente el prestador escanee el codigo QR',
        onDissmissCallback: () {
          debugPrint('Dialog Dissmiss from callback');
        }).show();
  }

  @override
  void initState() {
    super.initState();
    //WidgetsBinding.instance.addPostFrameCallback((_) {
    //modal();
    //});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Color.fromRGBO(59, 164, 171, 1),
          title: Text('Servicio en curso'),
        ),
        body: Container(
          child: SingleChildScrollView(
            child: Stack(
              children: <Widget>[upperHalf(context), list(context)],
            ),
          ),
        ));
  }

  Widget upperHalf(BuildContext context) {
    return Container(
      child: Image.asset(
        'assets/images/Back.png',
        fit: BoxFit.cover,
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
      ),
    );
  }

  Widget list(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: MediaQuery.of(context).size.height / 30),
      child: Center(
        child: Column(
          children: <Widget>[
            Container(
              padding:
                  EdgeInsets.only(top: MediaQuery.of(context).size.height / 30),
              child: FlatButton(
                  padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height / 80,
                      bottom: MediaQuery.of(context).size.height / 80,
                      left: MediaQuery.of(context).size.height / 6,
                      right: MediaQuery.of(context).size.height / 6),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0)),
                  color: Color.fromRGBO(173, 49, 56, 1),
                  onPressed: () async {
                    Email email = Email(
                        to: ['merecomiendanmx@gmail.com'],
                        subject: 'Queja',
                        body: 'Explica tú situación');
                    await EmailLauncher.launch(email);
                  },
                  child: Text(
                    'Queja',
                    style: TextStyle(
                        fontSize: MediaQuery.of(context).size.height / 30,
                        color: Colors.white),
                  )),
            ),
            Container(
              padding:
                  EdgeInsets.only(top: MediaQuery.of(context).size.height / 30),
              child: FlatButton(
                  padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height / 80,
                      bottom: MediaQuery.of(context).size.height / 80,
                      left: MediaQuery.of(context).size.height / 15,
                      right: MediaQuery.of(context).size.height / 15),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0)),
                  color: Colors.orange,
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
                        desc: 'Los ajustes de presupuesto seran en efectivo y serán acordados físicamente.',
                        btnOkOnPress: () {
                          debugPrint('OnClcik');
                        },
                        btnOkIcon: Icons.check_circle,
                        onDissmissCallback: () {
                          debugPrint('Dialog Dissmiss from callback');
                        }).show();
                  },
                  child: Text(
                    'Ajustar presupuesto',
                    style: TextStyle(
                        fontSize: MediaQuery.of(context).size.height / 30,
                        color: Colors.white),
                  )),
            ),
            Container(
              padding:
                  EdgeInsets.only(top: MediaQuery.of(context).size.height / 30),
              child: FlatButton(
                  padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height / 80,
                      bottom: MediaQuery.of(context).size.height / 80,
                      left: MediaQuery.of(context).size.height / 15,
                      right: MediaQuery.of(context).size.height / 15),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0)),
                  color: Color.fromRGBO(54, 77, 108, 1),
                  onPressed: () async {
                    SharedPreferences pref =
                        await SharedPreferences.getInstance();
                    String identificador = pref.getString('identificador');
                    String peerID = pref.getString('peerID');
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              Chat(peerId: peerID, peerAvatar: '')),
                    );
                  },
                  child: Text(
                    'Iniciar conversación',
                    style: TextStyle(
                        fontSize: MediaQuery.of(context).size.height / 30,
                        color: Colors.white),
                  )),
            ),
            Container(
              padding:
                  EdgeInsets.only(top: MediaQuery.of(context).size.height / 6),
              child: FlatButton(
                  padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height / 80,
                      bottom: MediaQuery.of(context).size.height / 80,
                      left: MediaQuery.of(context).size.height / 11,
                      right: MediaQuery.of(context).size.height / 11),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0)),
                  color: Color.fromRGBO(59, 164, 171, 1),
                  onPressed: () {
                    modal();
                  },
                  child: Text(
                    'Finalizar servicio',
                    style: TextStyle(
                        fontSize: MediaQuery.of(context).size.height / 30,
                        color: Colors.white),
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
