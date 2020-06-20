import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce/pedido.dart';
import 'package:flutter/material.dart';

class ListaMaterialesPage extends StatefulWidget {
  ListaMaterialesPage({Key key}) : super(key: key);

  @override
  _ListaMaterialesPageState createState() => _ListaMaterialesPageState();
}

class _ListaMaterialesPageState extends State<ListaMaterialesPage> {
  int i = 1;
  final children = <Widget>[];
  @override
  Widget build(BuildContext context) {
    final Pedido args = ModalRoute.of(context).settings.arguments;
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
                  .collection('PedidosPresupuesto')
                  .where("Identificador", isEqualTo: args.identificador)
                  .where('Pedido', isEqualTo: args.pedido)
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
