import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';

class PruebasPage extends StatefulWidget {
  PruebasPage({Key key}) : super(key: key);

  @override
  _PruebasPageState createState() => _PruebasPageState();
}

class _PruebasPageState extends State<PruebasPage> {
  List hola=['ajsoajslk'];
  modal(BuildContext context) {
    AwesomeDialog(
        context: context,
        animType: AnimType.BOTTOMSLIDE,
        headerAnimationLoop: true,
        dialogType: DialogType.SUCCES,
        btnOkColor: Color.fromRGBO(59, 164, 171, 1),
        tittle: 'Orden de servicio generada',
        btnOkText: 'Entendido',
        desc:
            'Se ha generado la orden de pago con número de folio x8620 el 15/02/2020 por la cantidad de 1,160, IVA incluido',
        btnOkOnPress: () {
          debugPrint('OnClcik');
        },
        btnOkIcon: Icons.check_circle,
        onDissmissCallback: () {
          debugPrint('Dialog Dissmiss from callback');
        }).show();
  }
  modalOriginal(BuildContext context){
    showDialog(
      context: context,
      builder: (buildcontext) {
        return AlertDialog(
          title: Text("Orden de servicio generada",textAlign: TextAlign.center,),
          content: Container(
            height: MediaQuery.of(context).size.height/5.5,
            child: Column(
              children: <Widget>[
                Text('Se ha generado la orden de pago con el número de folio x8620 el 15/02/2020 por la cantidad de:',style: TextStyle(color:Color.fromRGBO(59, 164, 171, 1)),),
                Container(
                  padding: EdgeInsets.only(top:MediaQuery.of(context).size.height/40),
                  child: Text('1,000.00 IVA incluido',style: TextStyle(color:Color.fromRGBO(59, 164, 171, 1))))
              ],
            ),
          ),
          actions: <Widget>[
            Center(
              child: RaisedButton(
                color: Color.fromRGBO(59, 164, 171, 1),
                child: Text("Entendido", style: TextStyle(color: Colors.white),),
                onPressed: (){ Navigator.of(context).pop(); },
              ),
            )
          ],
        );
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(
      children: <Widget>[
        FlatButton(
            onPressed: () {
              Navigator.pushNamed(context, 'servicioEnCurso');
            },
            child: Text('QR Page')),
        FlatButton(
            onPressed: () {
              modal(context);
            },
            child: Text('Modal')),
                    FlatButton(
            onPressed: () {
              modalOriginal(context);
            },
            child: Text('Modal original')),
            FlatButton(onPressed: (){
              Navigator.pushNamed(context, 'servicioEnCurso');
            }, child: Text('Botones Page')),
            FlatButton(onPressed: (){
              Navigator.pushNamed(context, 'ajustePresupuesto');
            }, child: Text('Ajuste presupuesto')),
            FlatButton(onPressed: (){
              Navigator.pushNamed(context, 'aceptarPresupuesto');
            }, child: Text('Aceptar presupuesto')),
            FlatButton(onPressed: (){
              Navigator.pushNamed(context, 'finalizarServicio');
            }, child: Text('Finalizar servicio')),
            FlatButton(onPressed: (){
              Navigator.pushNamed(context, 'servicePresupuesto', arguments:hola);
            }, child: Text('Servicio con presupuesto')),
      ],
    ));
  }
}
