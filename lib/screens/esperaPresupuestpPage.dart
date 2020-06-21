import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce/identificadorEspera.dart';
import 'package:ecommerce/screens/precio.dart';
import 'package:ecommerce/widgets/webView_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:line_icons/line_icons.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../pedido.dart';

class EsperaPresupuestoPage extends StatefulWidget {
  EsperaPresupuestoPage({Key key}) : super(key: key);

  @override
  _EsperaPresupuestoPageState createState() => _EsperaPresupuestoPageState();
}

class _EsperaPresupuestoPageState extends State<EsperaPresupuestoPage> {
  aceptar(identificador,precio,prestador,pedido,iden2) async {
    await Firestore.instance
        .collection('PedidosPresupuesto')
        .document(identificador)
        .updateData({"EstadoPedido": "aceptado","EstadoPago":"pendiente"});
        SharedPreferences prefs= await SharedPreferences.getInstance();
        prefs.setString('Identificador', identificador);
        prefs.setString('Precio', precio);
        prefs.setString('peerID', prestador);
        prefs.setString('ide2', iden2);
        prefs.setInt('pedido', pedido);
        print('Identificador chat $identificador');
        SharedPreferences pref=await SharedPreferences.getInstance();
        //pref.setString('pedido', identificador);
        
        Navigator.pushNamed(context, 'pagoPagePresupuesto',arguments: Precio(double.parse(precio)));
  }

  cancelar(identificador) async {
    await Firestore.instance
        .collection('PedidosPresupuesto')
        .document(identificador)
        .updateData({
      "Cotizacion": "false",
      "Disponible": "true",
      "EstadoPedido": "denegado"
    });
  }

  double screenHeight;

  @override
  Widget build(BuildContext context) {
    final IdentificadorEspera args = ModalRoute.of(context).settings.arguments;
    int pedido=args.pedido;
    String iden2=args.identificador;
    screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text('En espera'),
        centerTitle: true,
        backgroundColor: Color.fromRGBO(59, 164, 171, 0.9),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: Firestore.instance
            .collection('PedidosPresupuesto')
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
                      if(document['Presupuesto']=='true'){
                  return Container(
                    child: SingleChildScrollView(
                      child: Stack(
                        children: <Widget>[
                          //Text('se acepto')
                          upperHalf(context),
                          list(context, document['Nombre'],
                              document['Calificacion'], document['Total'],document['DetallesServicio'],document.documentID,pedido,iden2,document['Prestador']),
                        ],
                      ),
                    ),
                  );
                      }else{
                        return Center(
                          child: Column(
                            children: <Widget>[
                              Text('Esperando a que un Profesional mande su cotización'),
                              Container(
                                padding: EdgeInsets.only(top:MediaQuery.of(context).size.height/10),
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

  Widget list(BuildContext context, nombre, calificacion, precio,detalles,identificador,pedido,iden2,prestador) {
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
              Navigator.pushNamed(context, 'listaMateriales',arguments:Pedido(iden2,pedido));
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
                    aceptar(identificador,precio,prestador,pedido,iden2);
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
