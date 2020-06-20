import 'package:ecommerce/providers/menu_provider.dart';
import 'package:ecommerce/screens/quienesSomos_page.dart';
import 'package:ecommerce/utils/icono_string_util.dart';
import 'package:ecommerce/widgets/my_appbar.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';


class ProfileTab extends StatefulWidget {
  @override
  _ProfileTabState createState() => _ProfileTabState();
}

class _ProfileTabState extends State<ProfileTab> {

  String nombre;

  @override
  void initState() {
    super.initState();
    init();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: <Widget>[
        MyAppBar('$nombre'),
        Expanded(
          child: _lista(),
        )
        
      ],
    ));
  }

  init() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    nombre = prefs.getString('nombre') ?? 'Nombre';
    setState(() {
      
    });
  }

  void salir() async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.remove('registrado');
  }

  Widget _lista() {
    // menuProvider.cargarData()
    return FutureBuilder(
      future: menuProvider.cargarData(),
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
          title: Text(opt['texto']),
          leading: getIcon(opt['icon']),
          onTap: () {
            Navigator.pushNamed(context, opt['ruta']);

            // final route=MaterialPageRoute(
            //   builder: (context){
            //     return PagoPage();
            //   }
            // );
            // Navigator.push(context, route);
          });

      opciones..add(widgetTemp)..add(Divider());
    });
    //final imagen = 
    //Container(
      //margin: EdgeInsets.all(1),
      //padding: EdgeInsets.all(1),
      //child: Image.network('http://via.placeholder.com/150x150'),
    //);
    //opciones.add(imagen);
    final quienesSomos = ListTile(
      title: Text('Quines Somos'),
      leading: getIcon('quienesSomos'),
      onTap: () {
        final route = MaterialPageRoute(builder: (context) {
          return QuienesSomosPage();
        });
        Navigator.push(context, route);
      },
    );
    opciones.add(quienesSomos);
    final salir = ListTile(
      title: Text('Salir'),
      leading: getIcon('quienesSomos'),
      onTap: () {

        Navigator.pushReplacementNamed(context, 'register2.0');
      },
    );
    opciones.add(salir);
    return opciones;

  }
}
