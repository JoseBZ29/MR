import 'dart:math';

import 'package:ecommerce/widgets/card_photo_widget.dart';
import 'package:ecommerce/widgets/date_picker.dart';
import 'package:ecommerce/widgets/select_location.dart';
import 'package:ecommerce/widgets/service_form/image_picker.dart';
import 'package:ecommerce/widgets/time_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:ecommerce/globals.dart' as globals;
import 'package:line_icons/line_icons.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ServiceForm extends StatefulWidget {
  final String serviceTitle;

  const ServiceForm({@required this.serviceTitle});

  @override
  _ServiceFormState createState() => _ServiceFormState();
}

class _ServiceFormState extends State<ServiceForm> {
  String _titulo;
  var _fecha;
  String _desc;
  DateTime _dateTime;
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  _registro() async {
    try {
      var hora = globals.hora;
      var image = CardFotosState.galleryFile;
      var dir = globals.direccion;
      var a=globals.a;
      var b=globals.b;
      var profesion = widget.serviceTitle;
      var fecha = globals.fecha;
      if (globals.imagen == 1 && hora!=null && a!=null && fecha!=null) {
        _scaffoldKey.currentState.showSnackBar(SnackBar(
          content: Text('Se esta creando su pedido. Por favor sea paciente'),
          duration: Duration(seconds: 10),
        ));
        final StorageUploadTask task = FirebaseStorage.instance
            .ref()
            .child('Pedidos')
            .child('pedido $_titulo')
            .child('imagen')
            .putFile(image);
        if (await task.onComplete != null) {
          StorageTaskSnapshot storageTaskSnapshot = await task.onComplete;
          String imgUrl = await storageTaskSnapshot.ref.getDownloadURL();
          print(imgUrl);
          SharedPreferences pref = await SharedPreferences.getInstance();
          String idenUser = pref.getString('identificadorUser');
          Random random = new Random();
          int randomNumber = random.nextInt(1474648) + 13797;
          await Firestore.instance.collection('Pedidos').add({
            "Titulo": "$_titulo",
            "Descripcion": "$_desc",
            "Fecha": "$fecha",
            "Hora": "$hora",
            "Direccion": "$dir",
            "a" :a,
            "b" :b,
            "Profesion": "$profesion",
            "Imagen": "$imgUrl",
            "Identificador": "$idenUser",
            "Pedido" :randomNumber,
            "Disponible" :"true",
            "Cotizaciones" :"false"
          });
          Navigator.pop(context);
        }
      } else {
        _scaffoldKey.currentState.showSnackBar(SnackBar(
          content: Text('La imagen es necesaria'),
          duration: Duration(seconds: 10),
        ));
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);

        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: Color.fromRGBO(59, 164, 171, 0.9),
            title: Text(widget.serviceTitle),
          ),
          key: _scaffoldKey,
          resizeToAvoidBottomPadding: false,
          body: SafeArea(
            child: Column(
              children: <Widget>[
                Expanded(
                  child: CustomScrollView(
                    slivers: <Widget>[
                      //My silver app bar
                      _mySilverList(context, 'Descripción'),
                    ],
                  ),
                ),

                _mySendButton(
                    context), //Botón para envíar la solicitud de servicio
              ],
            ),
          )),
    );
  }

  Widget _mySilverList(context, description) {
    return SliverList(
      delegate: SliverChildListDelegate([
        _titleTextField(),

        ListTile(title: Text("Por favor describe el problema o requerimiento")),
        _descriptionTextField(), //Guarda la descripción del servicio
        _lista(),
        SelectLocation(), //Location picker
        CardFotos()
      ]),
    );
  }

  Widget _lista() {
    return Row(
      children: <Widget>[
        DatePicker(),
        TimePicker(),
      ],
    );
  }

  Widget _mySilverAppBar(context, title) {
    return SliverAppBar(
      leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          }),
      backgroundColor: Colors.white,
      expandedHeight: MediaQuery.of(context).size.height * .25,
      floating: true,
      pinned: true,
      iconTheme: IconThemeData(color: Colors.black),
      flexibleSpace: FlexibleSpaceBar(
          centerTitle: true,
          title: Text(title,
              style: TextStyle(
                color: Colors.black,
                fontSize: 16.0,
              )),
          background: Container(
            height: 100,
            child: Image.asset(
              'assets/categories/cat_alba.jpg',
              fit: BoxFit.fill,
              height: MediaQuery.of(context).size.height * .1,
            ),
          )),
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

  Widget _selctFecha() {
    return Column(
      children: <Widget>[
        ListTile(title: Text("Fecha")),
        Container(
          padding: EdgeInsets.only(left: 10, right: 10),
          child: TextField(
              onChanged: (val) {
                setState(() {
                  _titulo = val;
                });
              },
              decoration: InputDecoration(
                prefixIcon: Icon(
                  LineIcons.clipboard,
                  color: Colors.grey,
                ),
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
                hintText: "Título del servicio",
                fillColor: Colors.grey[200],
                filled: true,
              )),
        )
      ],
    );
  }

  Widget _titleTextField() {
    return Column(
      children: <Widget>[
        ListTile(title: Text("¿En qué puedo ayudarte?")),
        Container(
          padding: EdgeInsets.only(left: 10, right: 10),
          child: TextField(
              onChanged: (val) {
                setState(() {
                  _titulo = val;
                });
              },
              decoration: InputDecoration(
                prefixIcon: Icon(
                  LineIcons.clipboard,
                  color: Colors.grey,
                ),
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
                hintText: "Título del servicio",
                fillColor: Colors.grey[200],
                filled: true,
              )),
        )
      ],
    );
  }

  Widget _dateTextField() {
    return Column(
      children: <Widget>[
        ListTile(title: Text("Fecha")),
        Container(
          padding: EdgeInsets.only(left: 10, right: 10),
          child: TextField(
              onChanged: (val) {
                _fecha = val;
              },
              decoration: InputDecoration(
                prefixIcon: Icon(
                  LineIcons.calendar,
                  color: Colors.grey,
                ),
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
                hintText: "Fecha del servicio",
                fillColor: Colors.grey[200],
                filled: true,
              )),
        )
      ],
    );
  }

  Widget _timeTextField() {
    return Column(
      children: <Widget>[
        ListTile(title: Text("Fecha")),
        Container(
          padding: EdgeInsets.only(left: 10, right: 10),
          child: TextField(
              decoration: InputDecoration(
            prefixIcon: Icon(
              LineIcons.calendar,
              color: Colors.grey,
            ),
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
            hintText: "Fecha del servicio",
            fillColor: Colors.grey[200],
            filled: true,
          )),
        )
      ],
    );
  }

  Widget _mySendButton(context) {
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
                print('boton');
                _registro();
              },
              color: Color.fromRGBO(59, 164, 171, 0.9),
              textColor: Colors.white,
              child: Text('Solicitar servicio'),
              height: 50,
              minWidth: 300,
              onLongPress: null,
              disabledColor: Colors.grey,
              shape: RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(18.0),
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

// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:google_map_location_picker/google_map_location_picker.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:line_icons/line_icons.dart';

// class SelectLocation extends StatefulWidget {
//   SelectLocation({Key key}) : super(key: key);

//   @override
//   _SelectLocationState createState() => _SelectLocationState();
// }

// class _SelectLocationState extends State<SelectLocation> {
//   LocationResult _pickedLocation;
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       child: Container(
//         child: Container(
//           padding: EdgeInsets.only(top: 20, left: 10),
//           child: Column(
//             children: <Widget>[
//               Container(
//                 width: 200,

//               ),

//               _pickedLocation == null ?
//               GestureDetector(
//                 onTap: ()async {
//                     FocusScopeNode currentFocus = FocusScope.of(context);

//                     if (!currentFocus.hasPrimaryFocus) {
//                       currentFocus.unfocus();
//                     }
//                     LocationResult result = await showLocationPicker(
//                       context,
//                       "AIzaSyCFQdixGYejzWGNYygW5H9KIHRAk2p2Ld0",
//                       initialCenter: LatLng(31.1975844, 29.9598339),
// //                      automaticallyAnimateToCurrentLocation: true,
// //                      mapStylePath: 'assets/mapStyle.json',
//                       myLocationButtonEnabled: true,
//                       layersButtonEnabled: true,

// //                      resultCardAlignment: Alignment.bottomCenter,
//                     );
//                     print("result = $result");
//                     setState(() => _pickedLocation = result);
//                   },
//                 child:Row(
//                 children: <Widget>[
//                   Icon(LineIcons.plus_circle, size: 25,),
//                   Text('Agregar ubicación', style: TextStyle(fontSize: 18)),
//                 ],
//               ),
//               )

//               :
//               GestureDetector(
//                 onTap: ()async {
//                     FocusScopeNode currentFocus = FocusScope.of(context);

//                     if (!currentFocus.hasPrimaryFocus) {
//                       currentFocus.unfocus();
//                     }
//                     LocationResult result = await showLocationPicker(
//                       context,
//                       "AIzaSyCFQdixGYejzWGNYygW5H9KIHRAk2p2Ld0",
//                       initialCenter: LatLng(31.1975844, 29.9598339),
// //                      automaticallyAnimateToCurrentLocation: true,
// //                      mapStylePath: 'assets/mapStyle.json',
//                       myLocationButtonEnabled: true,
//                       layersButtonEnabled: true,

// //                      resultCardAlignment: Alignment.bottomCenter,
//                     );
//                     print("result = $result");
//                     setState(() => _pickedLocation = result);
//                   },
//                 child:Row(
//                 children: <Widget>[
//                   Icon(LineIcons.map_marker),
//                   Expanded(
//                     child: Text(
//                       _pickedLocation == null
//                           ? ''
//                           : _pickedLocation.address.toString(),
//                       style: TextStyle(fontSize: 16),
//                     ),
//                   )
//                 ],
//               ),
//               )

//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
}
