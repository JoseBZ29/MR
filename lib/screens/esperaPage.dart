import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce/identificadorEspera.dart';
import 'package:ecommerce/prestador.dart';
import 'package:ecommerce/screens/precio.dart';
import 'package:ecommerce/widgets/webView_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:line_icons/line_icons.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EsperaPage extends StatefulWidget {
  EsperaPage({Key key}) : super(key: key);

  @override
  _EsperaPageState createState() => _EsperaPageState();
}

class _EsperaPageState extends State<EsperaPage> {
  double costos;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      modal();
    });
  }

  aceptar(identificador, precio, iden2, pedido, prestador) async {
    await Firestore.instance
        .collection('PedidosUrgentes')
        .document(identificador)
        .updateData({"EstadoPedido": "aceptado", "EstadoPago": "pendiente"});
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('Identificador', identificador);
    prefs.setString('Precio', precio);
    prefs.setString('iden2', iden2);
    prefs.setString('pedido2', pedido.toString());
    prefs.setString('peerID', prestador);

    Navigator.pushNamed(context, 'pagoPage',
        arguments: Precio(double.parse(precio)));
  }

  cancelar(identificador) async {
    await Firestore.instance
        .collection('PedidosUrgentes')
        .document(identificador)
        .updateData({
      "Cotizacion": "false",
      "Disponible": "true",
      "EstadoPedido": "denegado"
    });
  }

  modal() async {
    AwesomeDialog(
        context: context,
        animType: AnimType.BOTTOMSLIDE,
        headerAnimationLoop: true,
        dialogType: DialogType.INFO,
        btnOkColor: Color.fromRGBO(59, 164, 171, 1),
        tittle: 'Notificación',
        btnOkText: 'Entendido',
        dismissOnTouchOutside: false,
        desc: 'Esperando a que un Profesional de Servicos mande su cotización',
        btnOkOnPress: () {
          debugPrint('OnClcik');
        },
        btnOkIcon: Icons.check_circle,
        onDissmissCallback: () {
          debugPrint('Dialog Dissmiss from callback');
        }).show();
  }

  double screenHeight;

  @override
  Widget build(BuildContext context) {
    final IdentificadorEspera args = ModalRoute.of(context).settings.arguments;
    screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text('En espera'),
        centerTitle: true,
        backgroundColor: Color.fromRGBO(59, 164, 171, 0.9),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: Firestore.instance
            .collection('PedidosUrgentes')
            .where("Identificador", isEqualTo: args.identificador)
            .where('Pedido', isEqualTo: args.pedido)
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.data == null) return new Text('saasas');
          if (snapshot.hasError) return new Text('Error: ${snapshot.error}');
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return new Text('Loading...');
            default:
              return new ListView(
                padding: EdgeInsets.all(10),
                children:
                    snapshot.data.documents.map((DocumentSnapshot document) {
                  if (document['Cotizacion'] == 'true') {
                    return Container(
                      child: SingleChildScrollView(
                        child: Stack(
                          children: <Widget>[
                            upperHalf(context),
                            list(
                                context,
                                document['Nombre'],
                                document['Calificacion'],
                                document['Precio'],
                                document['DetallesServicio'],
                                document.documentID,
                                args.identificador,
                                args.pedido,
                                document['Prestador']),
                          ],
                        ),
                      ),
                    );
                  } else {
                    return Center(
                      child: Column(
                        children: <Widget>[
                          Text(
                              'Esperando a que un Profesional de Servicos mande su cotización'),
                          Container(
                              padding: EdgeInsets.only(
                                  top: MediaQuery.of(context).size.height / 10),
                              child: Image.asset('assets/Espera.gif'))
                        ],
                      ),
                    );
                  }
                }).toList(),
              );
          }
        },
      ),
    );
  }

  Widget upperHalf(BuildContext context) {
    return Container(
      child: Image.asset(
        'assets/images/Back.png',
        fit: BoxFit.cover,
        height: MediaQuery.of(context).size.height / 3.1,
        width: MediaQuery.of(context).size.width,
      ),
    );
  }

  Widget list(BuildContext context, nombre, calificacion, precio, detalles,
      identificador, iden2, pedido, prestador) {
    costos = double.parse(precio) - 25;
    return Container(
      padding: EdgeInsets.only(
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
          Container(
            padding:
                EdgeInsets.only(top: MediaQuery.of(context).size.height / 30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                RatingBarIndicator(
                  itemSize: MediaQuery.of(context).size.height / 20,
                  rating: calificacion.toDouble(),
                  itemBuilder: (context, index) {
                    switch (index) {
                      case 0:
                        return Icon(
                          Icons.star,
                          color: Colors.yellow,
                        );
                      case 1:
                        return Icon(
                          Icons.star,
                          color: Colors.yellow,
                        );
                      case 2:
                        return Icon(
                          Icons.star,
                          color: Colors.yellow,
                        );
                      case 3:
                        return Icon(
                          Icons.star,
                          color: Colors.yellow,
                        );
                      case 4:
                        return Icon(
                          Icons.star,
                          color: Colors.yellow,
                        );
                    }
                  },
                ),
                GestureDetector(
                  onTap: () async {
                    SharedPreferences prefs =
                        await SharedPreferences.getInstance();
                    prefs.setString('PrestadorImg', prestador);
                    Navigator.pushNamed(context, 'trabajosImg',
                        arguments: Prestador(prestador));
                  },
                  child: Text(
                    'Trabajos',
                    style: TextStyle(
                      color: Color.fromRGBO(59, 164, 171, 0.9),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.only(
                top: MediaQuery.of(context).size.height / 30,
                bottom: MediaQuery.of(context).size.height / 60),
            child: Text(
              'Usted pagará: \$' + precio,
              style: TextStyle(
                  color: Color.fromRGBO(59, 164, 171, 0.9),
                  fontSize: MediaQuery.of(context).size.height / 30),
            ),
          ),
          Container(
              padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height / 100,
                  bottom: MediaQuery.of(context).size.height / 30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    'Costo: \$' + costos.toString(),
                    style: TextStyle(
                        color: Color.fromRGBO(59, 164, 171, 0.9),
                        fontSize: MediaQuery.of(context).size.height / 50),
                  ),
                  Text(
                    'Servicio: \$25.00',
                    style: TextStyle(
                        color: Color.fromRGBO(59, 164, 171, 0.9),
                        fontSize: MediaQuery.of(context).size.height / 50),
                  )
                ],
              )),
          _descriptionTextField(detalles),
          Container(
            padding:
                EdgeInsets.only(top: MediaQuery.of(context).size.height / 30),
            child: Text(
              'Al aceptar enviarás la ubicación del servicio',
              style: TextStyle(
                  color: Color.fromRGBO(59, 164, 171, 0.9),
                  fontSize: MediaQuery.of(context).size.height / 50),
            ),
          ),
          Container(
            padding:
                EdgeInsets.only(top: MediaQuery.of(context).size.height / 30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                FlatButton(
                  child: Text(
                    'Cancelar',
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () {
                    cancelar(identificador);
                  },
                  color: Colors.red,
                ),
                FlatButton(
                  child: Text(
                    'Aceptar',
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () {
                    aceptar(identificador, precio, iden2, pedido, prestador);
                  },
                  color: Color.fromRGBO(59, 164, 171, 0.9),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _descriptionTextField(detalles) {
    return Container(
      padding: EdgeInsets.only(left: 10, right: 10),
      child: TextField(
          scrollPadding: EdgeInsets.all(20),
          maxLines: 5,
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
            hintText: "$detalles",
            fillColor: Colors.white,
            filled: true,
          )),
    );
  }

  Widget _titleTextField(nombre) {
    return Column(
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(
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
                fillColor: Color.fromRGBO(59, 164, 171, 0.9),
                filled: true,
              )),
        )
      ],
    );
  }
}
