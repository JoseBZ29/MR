import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce/identificadorCotizacion.dart';
import 'package:ecommerce/identificadorEspera.dart';
import 'package:ecommerce/widgets/webView_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:line_icons/line_icons.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Pedido2.dart';
import '../pedido.dart';

class DetalleCotizacionPage extends StatefulWidget {
  DetalleCotizacionPage({Key key}) : super(key: key);

  @override
  _DetalleCotizacionPageState createState() => _DetalleCotizacionPageState();
}

class _DetalleCotizacionPageState extends State<DetalleCotizacionPage> {
  aceptar(identificador,precio,prestador,pedido) async {
    SharedPreferences pref=await SharedPreferences.getInstance();
    String idenA=pref.getString('IdenA');
    await Firestore.instance.collection('Pedidos').document(idenA).updateData({"Disponible":"false","EstadoPago":"pendiente"});
    await Firestore.instance
        .collection('PedidosCotizaciones')
        .document(identificador)
        .updateData({"Aceptado": "aceptado","EstadoPago":"pendiente"});
        SharedPreferences prefs= await SharedPreferences.getInstance();
        prefs.setString('Identificador', identificador);
        prefs.setString('Precio', precio);
        prefs.setString('peerID', prestador);
        prefs.setString('pedido', identificador);
        print('Identificador chat $identificador');
        pref.setString('IdenCot', identificador);
        Navigator.pushNamed(context, 'pagoCotizacion');
  }

  cancelar(identificador) async {
    await Firestore.instance
        .collection('PedidosCotizaciones')
        .document(identificador)
        .updateData({
      "Aceptado": "denegado",
    });
    Navigator.pop(context);
  }

  double screenHeight;

  @override
  Widget build(BuildContext context) {
    final IdentificadorCotizacion args = ModalRoute.of(context).settings.arguments;
    print(args.identificador);
    print(args.pedido);
    print(args.identificadorCotizacion);
    String pedido=args.pedido;
    String identificador=args.identificador;
    String identificadorCot=args.identificadorCotizacion;
    screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text('Cotizacion'),
        centerTitle: true,
        backgroundColor: Color.fromRGBO(59, 164, 171, 1),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: Firestore.instance
            .collection('PedidosCotizaciones')
            .where("Identificador", isEqualTo: args.identificador)
            .where('Pedido', isEqualTo: args.pedido)
            .where('IdentificadorCotizacion',isEqualTo: args.identificadorCotizacion)
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
                  return Container(
                    child: SingleChildScrollView(
                      child: Stack(
                        children: <Widget>[
                          //Text('se acepto')
                          upperHalf(context),
                          list(context, document['Nombre'],
                              document['Calificacion'], document['Total'],document['DetallesServicio'],document.documentID,pedido,identificador,document['Prestador'],identificadorCot),
                        ],
                      ),
                    ),
                  );
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

  Widget list(BuildContext context, nombre, calificacion, precio,detalles,identificador,pedido,iden2,prestador,identificadorCot) {
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
                Text(
                  'Me Recomiendan 91',
                  style: TextStyle(
                    color: Color.fromRGBO(59, 164, 171, 0.9),
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding:
                EdgeInsets.only(top: MediaQuery.of(context).size.height / 30,bottom: MediaQuery.of(context).size.height/30),
            child: Text(
              precio,
              style: TextStyle(
                  color: Color.fromRGBO(59, 164, 171, 0.9),
                  fontSize: MediaQuery.of(context).size.height / 20),
            ),
          ),
          //_descriptionTextField(detalles),
          Container(
            padding: EdgeInsets.only(top:MediaQuery.of(context).size.height/30),
            child: Text('Al aceptar enviarás la ubicación del servicio',style: TextStyle(color:Color.fromRGBO(59, 164, 171, 0.9),fontSize: MediaQuery.of(context).size.height/50),),
          ),
          Container(
            padding: EdgeInsets.only(top:MediaQuery.of(context).size.height/15),
            child: FlatButton(onPressed: (){
              print(iden2);
              print(pedido);
              Navigator.pushNamed(context, 'listaMaterialesCotizacion',arguments:Pedido2(iden2,pedido,identificadorCot));
            }, child: Text('Ver la lista de materiales',style: TextStyle(color:Color.fromRGBO(59, 164, 171, 0.9),fontSize: MediaQuery.of(context).size.height/50))),
          ),
          Container(
            padding: EdgeInsets.only(top:MediaQuery.of(context).size.height/10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                FlatButton(
                  child: Text('Cancelar',style: TextStyle(color:Colors.white),),
                  onPressed: (){
                    cancelar(identificador);
                  },
                  color: Colors.red,
                ),
                FlatButton(
                  child: Text('Aceptar',style: TextStyle(color:Colors.white),),
                  onPressed: (){
                    aceptar(identificador,precio,prestador,pedido);
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
