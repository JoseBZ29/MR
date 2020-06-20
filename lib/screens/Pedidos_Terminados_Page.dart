import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce/pedido.dart';
import 'package:ecommerce/widgets/Card_Service.dart';
import 'package:ecommerce/widgets/listCell_widget.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Terminados extends StatefulWidget {
  String iden;
  Terminados(this.iden);
  @override
  _TerminadosState createState() => _TerminadosState(iden);
}

class _TerminadosState extends State<Terminados> {
  String iden;
  _TerminadosState(this.iden);
  final Color mainColor = const Color(0xff3C3261);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance
          .collection('Pedidos')
          .where("Identificador", isEqualTo: iden)
          .where('Cotizaciones',isEqualTo: 'false')
          .snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) return new Text('Error: ${snapshot.error}');
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return new Text('Loading...');
          default:
            return new ListView(
              children:
                  snapshot.data.documents.map((DocumentSnapshot document) {
                return Column(
                  children: <Widget>[
                    FlatButton(
                        onPressed: () async {
                          if (document['EstadoCurso'] == 'false') {
                            AwesomeDialog(
                                context: context,
                                animType: AnimType.BOTTOMSLIDE,
                                headerAnimationLoop: true,
                                dialogType: DialogType.ERROR,
                                btnOkColor: Color.fromRGBO(59, 164, 171, 1),
                                tittle: 'Espera',
                                btnOkText: 'Entendido',
                                dismissOnTouchOutside: false,
                                desc:
                                    'No tienes cotizaciones, espera a que un prestador mande su cotizacion.',
                                btnOkOnPress: () {
                                  debugPrint('OnClcik');
                                },
                                btnOkIcon: Icons.check_circle,
                                onDissmissCallback: () {
                                  debugPrint('Dialog Dissmiss from callback');
                                }).show();
                          } else if (document['Cotizaciones'] == 'true') {
                            print('si hay');
                            print(document['Identificador']);
                            print(document['Pedido']);
                            SharedPreferences pref=await SharedPreferences.getInstance();
                            pref.setString('IdenA', document.documentID);
                            Navigator.pushNamed(context, 'detallesCotizacion',
                                arguments: Pedido(document['Identificador'],
                                    document['Pedido']));
                          } else {
                            AwesomeDialog(
                                context: context,
                                animType: AnimType.BOTTOMSLIDE,
                                headerAnimationLoop: true,
                                dialogType: DialogType.ERROR,
                                btnOkColor: Color.fromRGBO(59, 164, 171, 1),
                                tittle: 'Espera',
                                btnOkText: 'Entendido',
                                dismissOnTouchOutside: false,
                                desc: 'Hubo un error procesando su solicitud',
                                btnOkOnPress: () {
                                  debugPrint('OnClcik');
                                },
                                btnOkIcon: Icons.check_circle,
                                onDissmissCallback: () {
                                  debugPrint('Dialog Dissmiss from callback');
                                }).show();
                          }
                        },
                        child: Row(
                          children: <Widget>[
                                                        new Padding(
                              padding: const EdgeInsets.all(0.0),
                              child: new Container(
                                margin: const EdgeInsets.all(16.0),
                                child: new Container(
                                  width: 70.0,
                                  height: 70.0,
                                ),
                              ),
                            ),
                            new Expanded(
                                child: new Container(
                              margin: const EdgeInsets.fromLTRB(
                                  16.0, 0.0, 16.0, 0.0),
                              child: new Column(
                                children: [
                                  new Text(
                                    document['Titulo'],
                                    style: new TextStyle(
                                        fontSize: 20.0,
                                        fontFamily: 'Arvo',
                                        fontWeight: FontWeight.bold,
                                        color: mainColor),
                                  ),
                                  new Padding(
                                      padding: const EdgeInsets.all(2.0)),
                                  new Text(
                                    document['Descripcion'],
                                    maxLines: 3,
                                    style: new TextStyle(
                                        color: const Color(0xff8785A4),
                                        fontFamily: 'Arvo'),
                                  ),
                                ],
                                crossAxisAlignment: CrossAxisAlignment.start,
                              ),
                            )),
                          ],
                        )),
                  ],
                );
              }).toList(),
            );
        }
      },
    );
  }
}
