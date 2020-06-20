import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce/identificadorCotizacion.dart';
import 'package:ecommerce/pedido.dart';
import 'package:flutter/material.dart';


class DetallesCotizacionesPage extends StatefulWidget {
  DetallesCotizacionesPage({Key key}) : super(key: key);

  @override
  _DetallesCotizacionesPageState createState() => _DetallesCotizacionesPageState();
}

class _DetallesCotizacionesPageState extends State<DetallesCotizacionesPage> {
  final Color mainColor = const Color(0xff3C3261);
  @override
  Widget build(BuildContext context) {
    
    final Pedido pedido = ModalRoute.of(context).settings.arguments;
    print(pedido.identificador);
    print(pedido.pedido);
    return Scaffold(
      appBar: AppBar(
        title:Text('Cotizaciones'),
        centerTitle: true,
        backgroundColor: Color.fromRGBO(59, 164, 171, 0.9),
      ),
      body: StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance
          .collection('PedidosCotizaciones')
          .where("Identificador", isEqualTo: pedido.identificador)
          .where('Pedido', isEqualTo: pedido.pedido.toString())
          .where('Aceptado', isEqualTo: 'pendiente')
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
                        onPressed: () {
                          Navigator.pushNamed(context, 'detalleCotizacion', arguments: IdentificadorCotizacion(document['Identificador'], document['Pedido'], document['IdentificadorCotizacion']));
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
                                    document['Nombre'],
                                    style: new TextStyle(
                                        fontSize: 20.0,
                                        fontFamily: 'Arvo',
                                        fontWeight: FontWeight.bold,
                                        color: mainColor),
                                  ),
                                  new Padding(
                                      padding: const EdgeInsets.all(2.0)),
                                  new Text(
                                    document['Total'],
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
    ),
    );
  }
}