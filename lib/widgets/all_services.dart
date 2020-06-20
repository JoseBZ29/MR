import 'package:ecommerce/providers/provider_servicios.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';

class ServicesList extends StatefulWidget {
  ServicesList({Key key}) : super(key: key);

  @override
  _ServicesListState createState() => _ServicesListState();
}

class _ServicesListState extends State<ServicesList> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: _lista(),
    );
  }
}

Widget _lista() {
  // menuProvider.cargarData()
  return FutureBuilder(
    future: providerServicios.cargarData(),
    initialData: [],
    builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
      return ListView(
        children: _listaItems(snapshot.data, context),
      );
    },
  );
}

List<Widget> _listaItems(List<dynamic> data, BuildContext context) {
  final List<Widget> opciones = [];

  data.forEach((opt) {
    final widgetTemp = ListTile(
      leading: Icon(LineIcons.clipboard) ,
        dense: true,
        title: Text(opt['nombre']),
        subtitle: Text(opt['clave']),
        onTap: () {
          
          Navigator.pushNamed(context, 'service_details', arguments:opt['nombre'] );
        });

    opciones..add(widgetTemp)..add(Divider());
  });

  return opciones;
}
