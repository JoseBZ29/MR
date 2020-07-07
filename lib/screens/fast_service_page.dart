import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce/identificadorEspera.dart';
import 'package:ecommerce/widgets/select_location.dart';
import 'package:ecommerce/widgets/send_button.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ecommerce/globals.dart' as globals;
import 'package:shared_preferences/shared_preferences.dart';

class HomeServiceDetails extends StatefulWidget {
  const HomeServiceDetails({Key key}) : super(key: key);

  @override
  _HomeServiceDetailsState createState() => _HomeServiceDetailsState();
}

class _HomeServiceDetailsState extends State<HomeServiceDetails> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  String _desc;
  pedido(titulo, imagen) async {
    try {
      print('hola');
      double a = globals.a;
      double b = globals.b;
      if (a != null && b != null && _desc != null) {
        SharedPreferences pref = await SharedPreferences.getInstance();
        String identificador = pref.getString('identificador');
        Random random = new Random();
        int randomNumber = random.nextInt(1474648) + 13797;
        DateTime now = new DateTime.now();
        var dia = now.day;
        var mes = now.month;
        var anno = now.year;
        await Firestore.instance.collection('PedidosUrgentes').add({
          "Titulo": "$titulo",
          "Descripcion": "$_desc",
          "a": a,
          "b": b,
          "Imagen": "$imagen",
          "Disponible": "true",
          "Identificador": identificador,
          "Pedido": randomNumber,
          "Fecha": "$dia/$mes/$anno"
        });
        Navigator.pushNamed(context, 'esperaPage',
            arguments: IdentificadorEspera(identificador, randomNumber));
      } else {
        _scaffoldKey.currentState.showSnackBar(SnackBar(
          duration: Duration(seconds: 10),
          content: Text('La descripción y la ubicación es necesaria.'),
        ));
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    final List<String> serviceInfo = ModalRoute.of(context).settings.arguments;

    return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          backgroundColor: Color.fromRGBO(59, 164, 171, 0.9),
          title: Text(serviceInfo[0]),
          centerTitle: true,
        ),
        body: SafeArea(
          child: Column(
            children: <Widget>[
              Expanded(
                child: CustomScrollView(
                  slivers: <Widget>[
                    //My silver app bar
                    SliverList(
                        delegate: SliverChildListDelegate(
                      [
                        Container(
                          padding: EdgeInsets.all(15),
                          child: Text(
                              'Éste es un servicio emergente, por lo que necesitarás registrar el detalle de tu urgencia.'),
                        ),
                        _descriptionTextField(),
                        SelectLocation()
                      ],
                    )),
                  ],
                ),
              ),
              _sendButton(context, serviceInfo[0], serviceInfo[1])
            ],
          ),
        ));
  }

  Widget _myAppBar(context, titulo, img) {
    return SliverAppBar(
      backgroundColor: Colors.white,
      expandedHeight: MediaQuery.of(context).size.height * .15,
      floating: false,
      pinned: true,
      elevation: 2.0,
      iconTheme: IconThemeData(color: Colors.black),
      flexibleSpace: FlexibleSpaceBar(
          centerTitle: true,
          title: Text(titulo,
              style: TextStyle(
                color: Colors.black,
                fontSize: 18.0,
              )),
          background: Container(
            child: Hero(
              tag: titulo,
              child: Image.asset(
                img,
                fit: BoxFit.cover,
              ),
            ),
          )),
    );
  }

  Widget _sendButton(context, titulo, desc) {
    return Container(
      child: Container(
        child: Column(
          children: <Widget>[
            Divider(
              height: 1,
              thickness: 2,
              color: Color.fromRGBO(0, 0, 0, 0.05),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * .02,
            ),
            MaterialButton(
              onPressed: () {
                pedido(titulo, desc);
              },
              color: Colors.black,
              textColor: Colors.white,
              child: Text('Enviar solicitud de servicio'),
              height: 50,
              minWidth: 300,
              onLongPress: null,
              disabledColor: Colors.grey,
              shape: RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(18.0),
                side: BorderSide(color: Colors.black),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * .02,
            )
          ],
        ),
      ),
    );
  }

  Widget _descriptionTextField() {
    return Container(
      padding: EdgeInsets.only(left: 10, right: 10),
      child: TextField(
          onChanged: (val) {
            setState(() {
              _desc = val;
            });
          },
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
            hintText: "Breve descripción del problema",
            fillColor: Colors.grey[200],
            filled: true,
          )),
    );
  }
}
