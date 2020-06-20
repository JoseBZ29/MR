import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class AceptarCotizacionPage extends StatefulWidget {
  AceptarCotizacionPage({Key key}) : super(key: key);

  @override
  _AceptarCotizacionPageState createState() => _AceptarCotizacionPageState();
}

class _AceptarCotizacionPageState extends State<AceptarCotizacionPage> {
  String nombre = "Jose";
  double calificacion = 4;
  String precio = '100';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ajuste de presupuesto'),
        centerTitle: true,
        backgroundColor: Color.fromRGBO(59, 164, 171, 1),
      ),
      body: SingleChildScrollView(
        child: Stack(
          children: <Widget>[
            upperHalf(context),
            list(context, nombre, calificacion),
          ],
        ),
      ),
    );
  }

  Widget upperHalf(BuildContext context) {
    return Container(
      child: Image.asset(
        'assets/images/Back.png',
        fit: BoxFit.cover,
        height: MediaQuery.of(context).size.height / 2.8,
        width: MediaQuery.of(context).size.width,
      ),
    );
  }

  Widget list(
    BuildContext context,
    nombre,
    calificacion,
  ) {
    return Container(
      padding: EdgeInsets.only(
        top:MediaQuery.of(context).size.height/30,
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
            padding: EdgeInsets.only(
                top: MediaQuery.of(context).size.height / 12,
                bottom: MediaQuery.of(context).size.height / 30),
            child: Text(
              precio,
              style: TextStyle(
                  color: Color.fromRGBO(59, 164, 171, 0.9),
                  fontSize: MediaQuery.of(context).size.height / 20),
            ),
          ),
          Container(
            padding:
                EdgeInsets.only(top: MediaQuery.of(context).size.height / 12),
            child: Text(
              'Ajuste de presupuesto',
              style: TextStyle(
                  color: Color.fromRGBO(59, 164, 171, 1),
                  fontSize: MediaQuery.of(context).size.height / 25),
            ),
          ),
          Container(
            padding:
                EdgeInsets.only(top: MediaQuery.of(context).size.height / 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                FlatButton(
                  child: Text(
                    'Cancelar',
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () {},
                  color: Colors.red,
                ),
                FlatButton(
                  child: Text(
                    'Aceptar',
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () {},
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
                fillColor: Color.fromRGBO(59, 164, 171, 1),
                filled: true,
              )),
        )
      ],
    );
  }
}
