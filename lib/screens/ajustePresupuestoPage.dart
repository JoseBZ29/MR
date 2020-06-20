import 'package:flutter/material.dart';


class AjustePresupuestoPage extends StatefulWidget {
  AjustePresupuestoPage({Key key}) : super(key: key);

  @override
  _AjustePresupuestoPageState createState() => _AjustePresupuestoPageState();
}

class _AjustePresupuestoPageState extends State<AjustePresupuestoPage> {
  String total='100';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ajuste de presupuesto'),
        centerTitle: true,
        backgroundColor: Color.fromRGBO(59, 164, 171, 1),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/Back.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: ListView(children: <Widget>[
          Column(
            children: <Widget>[

              Container(
                alignment: Alignment.topLeft,
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height / 60,
                    left: MediaQuery.of(context).size.width / 15,
                    right: MediaQuery.of(context).size.width / 15),
                child: Text('Envía la información del costo del servicio'),
              ),
              Container(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height / 100,
                    left: MediaQuery.of(context).size.width / 30,
                    right: MediaQuery.of(context).size.width / 30),
                child: Row(
                  children: <Widget>[
                    Container(
                      width: MediaQuery.of(context).size.width / 2,
                      child: Flexible(
                        child: TextField(
                          onChanged: (val){
                            setState(() {
                              total=val;
                            });
                          },
                            decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(20.0)),
                            borderSide: BorderSide(
                                color: Color.fromRGBO(192, 195, 196, .25),
                                width: 0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10.0)),
                            borderSide: BorderSide(
                                color: Color.fromRGBO(0, 0, 0, .25), width: 0),
                          ),
                          hintText: "ej. 1,000.00",
                          fillColor: Colors.grey[200],
                          filled: true,
                        )),
                      ),
                    ),
                    Container(
                        padding: EdgeInsets.only(
                            left: MediaQuery.of(context).size.width / 20),
                        child: Text(
                          'Precios + IVA',
                          style: TextStyle(
                              fontSize: MediaQuery.of(context).size.height / 40),
                        ))
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height / 30,
                    left: MediaQuery.of(context).size.width / 15,
                    right: MediaQuery.of(context).size.width / 15),
                child: Text(
                  'Total:',
                  style: TextStyle(
                      fontSize: MediaQuery.of(context).size.height / 40),
                ),
              ),
              Container(
                  padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height / 100,
                      left: MediaQuery.of(context).size.width / 30,
                      right: MediaQuery.of(context).size.width / 30),
                  child: Text( total,
                    style: TextStyle(
                        fontSize: MediaQuery.of(context).size.height / 30,
                        color: Colors.black),
                  )),
              Container(
                alignment: Alignment.topLeft,
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height / 30,
                    left: MediaQuery.of(context).size.width / 15,
                    right: MediaQuery.of(context).size.width / 15),
                child: Text('Describe lo que incluye tu servicio'),
              ),
              Container(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height / 100,
                    left: MediaQuery.of(context).size.width / 30,
                    right: MediaQuery.of(context).size.width / 30),
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
                        borderSide: BorderSide(
                            color: Color.fromRGBO(0, 0, 0, .25), width: 0),
                      ),
                      hintText: "Descripción del servicio",
                      fillColor: Colors.grey[200],
                      filled: true,
                    )),
              ),
              Container(
                  padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height / 3),
                  child: FlatButton(
                      onPressed: () {
                      },
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0)),
                      padding: EdgeInsets.only(
                          top: MediaQuery.of(context).size.width / 35,
                          bottom: MediaQuery.of(context).size.width / 35,
                          left: MediaQuery.of(context).size.height / 10,
                          right: MediaQuery.of(context).size.height / 10),
                      color: Color.fromRGBO(59, 164, 171, 1),
                      child: Text(
                        'Enviar ajuste',
                        style: TextStyle(
                            fontSize: MediaQuery.of(context).size.height / 35,
                            color: Colors.white),
                      )))
            ],
          ),
        ]),
      ),
    );
  }
}