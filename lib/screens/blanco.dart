import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';


class BlancoPage extends StatefulWidget {
  BlancoPage({Key key}) : super(key: key);

  @override
  _BlancoPageState createState() => _BlancoPageState();
}

class _BlancoPageState extends State<BlancoPage> {

  modal(){
    AwesomeDialog(
        context: context,
        animType: AnimType.BOTTOMSLIDE,
        headerAnimationLoop: true,
        dialogType: DialogType.SUCCES,
        btnOkColor: Color.fromRGBO(59, 164, 171, 1),
        tittle: 'Orden de servicio generada',
        btnOkText: 'Entendido',
        dismissOnTouchOutside: false,
        desc:
            'Se ha generado la orden de pago con número de folio x8620 el 15/02/2020 por la cantidad de 1,160, IVA incluido',
        btnOkOnPress: () {
          debugPrint('OnClcik');
          Navigator.pop(context);
          Navigator.pop(context);
          Navigator.pushReplacementNamed(context, 'servicioEnCurso');
        },
        btnOkIcon: Icons.check_circle,
        onDissmissCallback: () {
          debugPrint('Dialog Dissmiss from callback');
        }).show();
  }

@override
void initState(){
  super.initState();
  WidgetsBinding.instance.addPostFrameCallback((_){
    modal();
  });
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
      ),
    );
  }
}