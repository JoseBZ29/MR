import 'dart:async';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce/qr.dart';
import 'package:ecommerce/screens/precio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PagoCotizacion extends StatefulWidget {
  @override
  _PagoCotizacionState createState() {
    return new _PagoCotizacionState();
  }
}

class _PagoCotizacionState extends State<PagoCotizacion> {
  final flutterWebviewPlugin = new FlutterWebviewPlugin();
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  StreamSubscription<String> _onUrlChanged;

  @override
  void initState() {
    super.initState();

    _onUrlChanged =
        flutterWebviewPlugin.onUrlChanged.listen((String url) async {
      if (mounted) {
        print("Current URL: $url");
        if (url.startsWith('https://ecommercev2.000webhostapp.com/final.php')) {
          print('el pago fue aceptado');
          await Future.delayed(Duration(seconds: 2));
          SharedPreferences prefs = await SharedPreferences.getInstance();
          String identificador = prefs.getString('IdenCot');
          Random random = new Random();
          int randomNumber = random.nextInt(1474648) + 13797;
          String iden2 = prefs.getString('iden2');
          String pedido = prefs.getString('pedido2');
          String idenA = prefs.getString('IdenA');
          print(idenA);
          print(identificador);
          await Firestore.instance
              .collection('Pedidos')
              .document(idenA)
              .updateData({"QR": "$randomNumber", "EstadoPago": "aceptado"});
              print('entro a la cot');
          await Firestore.instance
              .collection('PedidosCotizaciones')
              .document(identificador)
              .updateData({
            "EstadoPago": "aceptado",
            "QR": "$randomNumber",
            "EstadoQR": "pendiente"
          });
          print('salio cot');
          Navigator.pop(context);
          Navigator.pop(context);
          Navigator.pop(context);
          //print(iden2);
          //print(pedido);
          //Navigator.pushReplacementNamed(context, 'qrPage', arguments: QR(randomNumber.toString(),iden2,pedido));
        } else {
          print('no coincidio');
        }
      }
    });
  }

  @override
  void dispose() {
    _onUrlChanged.cancel();
    flutterWebviewPlugin.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Precio args = ModalRoute.of(context).settings.arguments;
    double precio=args.precio;
    return WebviewScaffold(
      key: scaffoldKey,
      url: 'https://ecommercev2.000webhostapp.com/formulario2.php?amount=$precio',
      hidden: true,
      appBar: AppBar(
        title: Text("Pago en Curso"),
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
        backgroundColor: Colors.white,
      ),
    );
  }
}
