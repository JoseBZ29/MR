import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class FinalizarServicioPage extends StatefulWidget {
  FinalizarServicioPage({Key key}) : super(key: key);

  @override
  _FinalizarServicioPageState createState() => _FinalizarServicioPageState();
}

class _FinalizarServicioPageState extends State<FinalizarServicioPage> {
  double calificacion = 4;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Finalizar servicio'),
        centerTitle: true,
        backgroundColor: Color.fromRGBO(59, 164, 171, 1),
      ),
      body: SingleChildScrollView(
        child: Stack(
          children: <Widget>[
            upperHalf(context),
            loginCard(context),
            boton(context)
          ],
        ),
      ),
    );
  }

  Widget boton(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).size.height / 1.3,
      ),
      child: Center(
        child: FlatButton(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18.0)),
            color: Color.fromRGBO(59, 164, 171, 1),
            padding: EdgeInsets.only(
                top: MediaQuery.of(context).size.height / 60,
                bottom: MediaQuery.of(context).size.height / 60,
                left: MediaQuery.of(context).size.height / 8,
                right: MediaQuery.of(context).size.height / 8),
            onPressed: () {},
            child: Text(
              'Liberar pago',
              style:
                  TextStyle(fontSize: MediaQuery.of(context).size.height / 30,color: Colors.white),
            )),
      ),
    );
  }

  Widget upperHalf(BuildContext context) {
    return Container(
      child: Image.asset(
        'assets/images/Back.png',
        fit: BoxFit.cover,
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
      ),
    );
  }

  Widget loginCard(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(top: MediaQuery.of(context).size.height / 20),
          padding: EdgeInsets.only(left: 10, right: 10),
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            elevation: 8,
            child: Padding(
              padding: const EdgeInsets.all(30.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Align(
                    alignment: Alignment.topCenter,
                    child: Text(
                      "Atención/Trato/Educación",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Color.fromRGBO(59, 164, 171, 0.9),
                        fontSize: MediaQuery.of(context).size.height / 40,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  RatingBar(
                    itemSize: MediaQuery.of(context).size.height / 20,
                    initialRating: 3,
                    minRating: 1,
                    direction: Axis.horizontal,
                    allowHalfRating: false,
                    itemCount: 5,
                    itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                    itemBuilder: (context, _) => Icon(
                      Icons.star,
                      color: Colors.yellow,
                    ),
                    onRatingUpdate: (rating) {
                      print(rating);
                    },
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Align(
                    alignment: Alignment.topCenter,
                    child: Text(
                      "Tiempo de respuesta",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Color.fromRGBO(59, 164, 171, 0.9),
                        fontSize: MediaQuery.of(context).size.height / 40,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  RatingBar(
                    itemSize: MediaQuery.of(context).size.height / 20,
                    initialRating: 3,
                    minRating: 1,
                    direction: Axis.horizontal,
                    allowHalfRating: false,
                    itemCount: 5,
                    itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                    itemBuilder: (context, _) => Icon(
                      Icons.star,
                      color: Colors.yellow,
                    ),
                    onRatingUpdate: (rating) {
                      print(rating);
                    },
                  ),
                  Align(
                    alignment: Alignment.topCenter,
                    child: Text(
                      "Calidad del servicio",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Color.fromRGBO(59, 164, 171, 0.9),
                        fontSize: MediaQuery.of(context).size.height / 40,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  RatingBar(
                    itemSize: MediaQuery.of(context).size.height / 20,
                    initialRating: 3,
                    minRating: 1,
                    direction: Axis.horizontal,
                    allowHalfRating: false,
                    itemCount: 5,
                    itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                    itemBuilder: (context, _) => Icon(
                      Icons.star,
                      color: Colors.yellow,
                    ),
                    onRatingUpdate: (rating) {
                      print(rating);
                    },
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Align(
                    alignment: Alignment.topCenter,
                    child: Text(
                      "Costo/Presupuesto",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Color.fromRGBO(59, 164, 171, 0.9),
                        fontSize: MediaQuery.of(context).size.height / 40,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  RatingBar(
                    itemSize: MediaQuery.of(context).size.height / 20,
                    initialRating: 3,
                    minRating: 1,
                    direction: Axis.horizontal,
                    allowHalfRating: false,
                    itemCount: 5,
                    itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                    itemBuilder: (context, _) => Icon(
                      Icons.star,
                      color: Colors.yellow,
                    ),
                    onRatingUpdate: (rating) {
                      print(rating);
                    },
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Align(
                    alignment: Alignment.topCenter,
                    child: Text(
                      "Calidad/Confianza",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Color.fromRGBO(59, 164, 171, 0.9),
                        fontSize: MediaQuery.of(context).size.height / 40,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  RatingBar(
                    itemSize: MediaQuery.of(context).size.height / 20,
                    initialRating: 3,
                    minRating: 1,
                    direction: Axis.horizontal,
                    allowHalfRating: false,
                    itemCount: 5,
                    itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                    itemBuilder: (context, _) => Icon(
                      Icons.star,
                      color: Colors.yellow,
                    ),
                    onRatingUpdate: (rating) {
                      print(rating);
                    },
                  ),
                  SizedBox(
                    height: 15,
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
