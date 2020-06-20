import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce/widgets/argumentos.dart';
import 'package:flutter/material.dart';

class ListaCatPage extends StatefulWidget {
  @override
  _ListaCatPageState createState() => _ListaCatPageState();
}

class _ListaCatPageState extends State<ListaCatPage> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    final Argumentos args = ModalRoute.of(context).settings.arguments;
    print(args.grupo[0]);
    return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          backgroundColor: Color.fromRGBO(59, 164, 171, 0.9),
          title: Text(args.grupo[0].toString()),
          centerTitle: true,
        ),
        body: Column(
          children: <Widget>[
            Container(
              height: MediaQuery.of(context).size.height / 1.2,
              width: MediaQuery.of(context).size.width / 1,
              child: StreamBuilder<QuerySnapshot>(
                stream: Firestore.instance
                    .collection("Profesiones")
                    .where('Grupo', isEqualTo: args.grupo[0])
                    .snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasError)
                    return new Text('Error: ${snapshot.error}');
                  switch (snapshot.connectionState) {
                    case ConnectionState.waiting:
                      return new Text('Loading...');
                    default:
                      return new ListView(
                        children: snapshot.data.documents
                            .map((DocumentSnapshot document) {
                          return Column(
                            children: <Widget>[
                              ListTile(
                                title: Text(document['Profecion']),
                                onTap: () {
                                  if (document['Activo'] == '1') {
                                    List profesion=[];
                                    profesion.add(document['Profecion']);
                                    Navigator.pushNamed(
                                        context, 'service_details',
                                        arguments: profesion);
                                  } else {
                                    _scaffoldKey.currentState
                                        .showSnackBar(SnackBar(
                                      content: Text(
                                          'Aun no tenemos un prestador con este servicio.'),
                                          duration: Duration(seconds: 5),
                                    ));
                                  }
                                },
                              ),
                              Divider()
                            ],
                          );
                        }).toList(),
                      );
                  }
                },
              ),
            ),
          ],
        ));
  }
}
