import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce/pedido.dart';
import 'package:flutter/material.dart';

import '../Pedido2.dart';

class ListaMaterialesCotizacionPage extends StatefulWidget {
  ListaMaterialesCotizacionPage({Key key}) : super(key: key);

  @override
  _ListaMaterialesCotizacionPageState createState() => _ListaMaterialesCotizacionPageState();
}

class _ListaMaterialesCotizacionPageState extends State<ListaMaterialesCotizacionPage> {
  int i = 1;
  final children = <Widget>[];
  @override
  Widget build(BuildContext context) {
    final Pedido2 args = ModalRoute.of(context).settings.arguments;
    print(args.identificador);
    print(args.pedido);
    print(args.identificadorCotizacion);
    return Scaffold(
      appBar: AppBar(
        title: Text('Lista de Materiales'),
        centerTitle: true,
        backgroundColor: Color.fromRGBO(59, 164, 171, 0.9),
      ),
      body: Column(
        children: <Widget>[
          Container(
            padding:
                EdgeInsets.only(top: MediaQuery.of(context).size.height / 30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Text('Cantidad'),
                Text('Material'),
                Text('Precio')
              ],
            ),
          ),
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: Firestore.instance
                  .collection('PedidosCotizaciones')
                  .where("Identificador", isEqualTo: args.identificador)
                  .where('Pedido', isEqualTo: args.pedido)
                  .where('IdentificadorCotizacion',isEqualTo: args.identificadorCotizacion)
                  .snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.data == null) return new Text('saasas');
                if (snapshot.hasError)
                  return new Text('Error: ${snapshot.error}');
                switch (snapshot.connectionState) {
                  case ConnectionState.waiting:
                    return new Text('Loading...');
                  default:
                    return new ListView(
                      padding: EdgeInsets.all(10),
                      children: snapshot.data.documents
                          .map((DocumentSnapshot document) {
                        int count = document['CantidadDeMateriales'];
                        print(count);
                        for (var i = 1; i <= count; i++) {
                          print('entro for');
                          children.add(Container(
                            padding: EdgeInsets.only(
                                top: MediaQuery.of(context).size.height / 30),
                            child: new Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: <Widget>[
                                Text(document['CantidadMaterial$i'].toString()),
                                Text(document['Material$i']),
                                Text(document['PrecioMaterial$i'].toString())
                              ],
                            ),
                          ));
                        }
                        return new Column(
                          children: children,
                        );
                        //Text(document['Identificador']);
                        //list(count);
                      }).toList(),
                    );
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> list(count) {
    for (int i = 1; i > count; i++) {
      Text('asas');
    }
  }
}
