import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../qr.dart';

class QRPageFinalizarPresupuesto extends StatefulWidget {
  QRPageFinalizarPresupuesto({Key key}) : super(key: key);

  @override
  _QRPageFinalizarPresupuestoState createState() => _QRPageFinalizarPresupuestoState();
}

class _QRPageFinalizarPresupuestoState extends State<QRPageFinalizarPresupuesto> {
  @override
  void initState() {
    super.initState();
  }
  String groupChatId;

  validar() async {
    SharedPreferences pref=await SharedPreferences.getInstance();
    String identificador=pref.getString('Identificador');
    print('entro validar');
    String qr;
    await Firestore.instance.collection('PedidosPresupuesto').document(identificador).get().then((document){
          qr=document['EstadoQRFinalizar'];
        });
    print('ya hizo consulta');
    
    if(qr=='pendiente'){
      print('aun no');
      AwesomeDialog(
        context: context,
        animType: AnimType.BOTTOMSLIDE,
        headerAnimationLoop: true,
        dialogType: DialogType.WARNING,
        btnOkColor: Color.fromRGBO(59, 164, 171, 1),
        tittle: 'Espera',
        btnOkText: 'Entendido',
        dismissOnTouchOutside: false,
        desc:'Aun no se valida el codigo QR.',
        btnOkOnPress: () {
          debugPrint('OnClcik');
          
        },
        btnOkIcon: Icons.check_circle,
        onDissmissCallback: () {
          debugPrint('Dialog Dissmiss from callback');
        }).show();
    }else if(qr=='validado'){
      print('listo');
            AwesomeDialog(
        context: context,
        animType: AnimType.BOTTOMSLIDE,
        headerAnimationLoop: true,
        dialogType: DialogType.SUCCES,
        btnOkColor: Color.fromRGBO(59, 164, 171, 1),
        tittle: 'Listo',
        btnOkText: 'Entendido',
        dismissOnTouchOutside: false,
        desc:'El codigo QR se ha validado, se ha finalizado el servicio. Gracias por ocupar nuestros servicios.',
        btnOkOnPress: () async{
          debugPrint('OnClcik');
          String id = pref.getString('identificadorUser');
            String peerId = pref.getString('peerID');
            groupChatId = '$id-$peerId';
            print(groupChatId);
            await Firestore.instance
                .collection('messages')
                .document(groupChatId)
                .collection(groupChatId)
                .getDocuments()
                .then((snapshot) {
              for (DocumentSnapshot doc in snapshot.documents) {
                doc.reference.delete();
              }
            });
          Navigator.pushReplacementNamed(context, 'home_page');
        },
        btnOkIcon: Icons.check_circle,
        onDissmissCallback: () {
          debugPrint('Dialog Dissmiss from callback');
        }).show();
    }else{
      print('Valor $qr');
      print('error');
      AwesomeDialog(
        context: context,
        animType: AnimType.BOTTOMSLIDE,
        headerAnimationLoop: true,
        dialogType: DialogType.ERROR,
        btnOkColor: Color.fromRGBO(59, 164, 171, 1),
        tittle: 'Espera',
        btnOkText: 'Entendido',
        dismissOnTouchOutside: false,
        desc:'Hubo un error en la validacion del codigo QR',
        btnOkOnPress: () {
          debugPrint('OnClcik');
        },
        btnOkIcon: Icons.check_circle,
        onDissmissCallback: () {
          debugPrint('Dialog Dissmiss from callback');
        }).show();
    }
  }

  String nombre = "Jose";
  Widget generer_qr(data) {
    return Container(
      padding: EdgeInsets.only(top: MediaQuery.of(context).size.height / 2),
      child: Center(
        child: QrImage(
          data: data,
          version: QrVersions.auto,
          size: MediaQuery.of(context).size.height / 3,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final QR qr = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      body: Container(
        child: SingleChildScrollView(
          child: Stack(
            children: <Widget>[
              upperHalf(context),
              list(context, nombre),
              generer_qr(qr.qrData),
              boton(context, qr.iden2, qr.pedido)
            ],
          ),
        ),
      ),
    );
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

  Widget boton(BuildContext context, iden2, pedido) {
    return Center(
      child: Container(
        padding:
            EdgeInsets.only(top: MediaQuery.of(context).size.height / 1.15),
        child: FlatButton(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18.0)),
            padding: EdgeInsets.only(
                top: MediaQuery.of(context).size.width / 30,
                bottom: MediaQuery.of(context).size.width / 30,
                left: MediaQuery.of(context).size.height / 6,
                right: MediaQuery.of(context).size.height / 6),
            color: Color.fromRGBO(59, 164, 171, 1),
            onPressed: () {
              validar();
            },
            child: Text(
              'Continuar',
              style: GoogleFonts.roboto(
                  color: Colors.white,
                  fontSize: MediaQuery.of(context).size.height / 30),
            )),
      ),
    );
  }

  Widget _titleTextField(nombre) {
    return Column(
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(
              top: MediaQuery.of(context).size.height / 40,
              left: MediaQuery.of(context).size.height / 30,
              right: MediaQuery.of(context).size.height / 30),
          child: TextField(
              readOnly: true,
              textAlign: TextAlign.center,
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20.0)),
                  borderSide: BorderSide(
                      color: Color.fromRGBO(192, 195, 196, .25), width: 0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  borderSide:
                      BorderSide(color: Color.fromRGBO(0, 0, 0, .25), width: 0),
                ),
                hintText: "$nombre",
                hintStyle: TextStyle(
                    color: Colors.white,
                    fontSize: MediaQuery.of(context).size.height / 30),
                fillColor: Color.fromRGBO(59, 164, 171, 1),
                filled: true,
              )),
        )
      ],
    );
  }

  Widget list(BuildContext context, nombre) {
    return Container(
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).size.height / 40,
        left: MediaQuery.of(context).size.height / 60,
      ),
      child: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).size.height / 80),
            child: CircleAvatar(
              child: Text('JA'),
              radius: MediaQuery.of(context).size.height / 10,
            ),
          ),
          _titleTextField(nombre),
        ],
      ),
    );
  }
}
