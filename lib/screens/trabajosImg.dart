import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce/prestador.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TrabajosImg extends StatefulWidget {
  TrabajosImg({Key key}) : super(key: key);

  @override
  _TrabajosImgState createState() => _TrabajosImgState();
}

class _TrabajosImgState extends State<TrabajosImg> {
  String prestador;
  String img1 = '';
  String img2 = '';
  String img3 = '';
  String img4 = '';
  String img5 = '';

  @override
  void initState() {
    super.initState();

    imagenes();
  }

  imagenes() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prestador = prefs.getString('PrestadorImg');
    print(prestador);
    Future.delayed(Duration(seconds: 3));
    Firestore.instance
        .collection('Usuarios')
        .document(prestador)
        .get()
        .then((document) {
      setState(() {
        img1 = document['Trabajo1'];
        img2 = document['Trabajo2'];
        img3 = document['Trabajo3'];
        img4 = document['Trabajo4'];
        img5 = document['Trabajo5'];
      });
    });
    Future.delayed(Duration(seconds: 3));
    print(img1);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lista de Trabajos'),
        centerTitle: true,
        backgroundColor: Color.fromRGBO(59, 164, 171, 0.9),
      ),
      body: Center(
        child: ListView(children: [
          Column(
            children: [
              Image.network(img1),
              Image.network(img2),
              Image.network(img3),
              Image.network(img4),
              Image.network(img5)
            ],
          ),
        ]),
      ),
    );
  }
}
