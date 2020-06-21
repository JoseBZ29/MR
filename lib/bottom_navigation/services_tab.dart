import 'package:ecommerce/screens/Pedidos_Curso.dart' as encurso;
import 'package:ecommerce/screens/Pedidos_Terminados_Page.dart' as terminados;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ServicesTab extends StatefulWidget {
  String iden;
  @override
  _ServicesTabState createState() => _ServicesTabState();
}

class _ServicesTabState extends State<ServicesTab>
    with SingleTickerProviderStateMixin {
  TabController controller;

  String iden = '';
  identificador() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    iden = pref.getString('identificadorUser');
    print(iden);
  }

  @override
  void initState() {
    super.initState();
    controller = new TabController(length: 2, vsync: this);
    identificador();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: TabBar(
        indicatorColor: Colors.indigoAccent,
        controller: controller,
        tabs: [
          
          Tab(child: Text('Pedidos pendientes',style: TextStyle(color:Colors.black),),),
          Tab(child: Text('Pedidos en curso',style: TextStyle(color:Colors.black),),)
        ],
      ),
      body: new TabBarView(
          controller: controller,
          children: <Widget>[ new terminados.Terminados(iden), new encurso.Curso(iden)]),
    );
  }
}
