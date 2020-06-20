import 'package:flutter/material.dart';




class BottomSheetWidget extends StatefulWidget {
  const BottomSheetWidget({Key key}) : super(key: key);

  @override
  _BottomSheetWidgetState createState() => _BottomSheetWidgetState();
}

class _BottomSheetWidgetState extends State<BottomSheetWidget> {
  @override
   build(BuildContext context) {
     
    
    return Container(
      
      margin:  const EdgeInsets.only(top: 1, left:1, right: 1),
      height: 200,
      decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
                BoxShadow(blurRadius:10,color: Colors.grey[300], spreadRadius: 5)
              ]
            ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Container(
            
            height: 180,
            
            child: Column(
              children: <Widget>[

                SheetButton2(),
                DecoretedText(),
                SheetButton(),

              ],
            ),
          )
        ],
      ),
    );
  }
}

class DecoretedText extends StatelessWidget {
  const DecoretedText({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      alignment: Alignment.center,
      padding: const EdgeInsets.all(10),
      margin:  const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(10) ,
      ),
      child: Text('Aqui va la info'),

    );
  }
}

class SheetButton extends StatefulWidget {
  SheetButton({Key key}) : super(key: key);

  @override
  _SheetButtonState createState() => _SheetButtonState();
}

class _SheetButtonState extends State<SheetButton> {

  bool check=false;
  bool succes=false;

  @override
  Widget build(BuildContext context) {
    return !check
    ? MaterialButton(
      color: Colors.green,
      shape: RoundedRectangleBorder(
  borderRadius: new BorderRadius.circular(18.0),
  
),
      onPressed: () async{

        setState(() {
          check=true;
        });

        await Future.delayed(Duration(seconds:2));

        setState(() {
          succes=true;
        });

        await Future.delayed(Duration(seconds: 3));

        setState(() {
          Navigator.pop(context);
        });
      },
      child: Text('Confirmar', style: TextStyle(color: Colors.white),),
    )
    :!succes
    ? CircularProgressIndicator()
    : Icon(Icons.check, color: Colors.green);
    
    
    
  }
}


class SheetButton2 extends StatefulWidget {
  SheetButton2({Key key}) : super(key: key);

  @override
  _SheetButtonState2 createState() => _SheetButtonState2();
}

class _SheetButtonState2 extends State<SheetButton2> {

  bool check=false;
  bool succes=false;

  @override
  Widget build(BuildContext context) {
    return
     Container(
       margin: EdgeInsets.all(5),
       
      alignment: Alignment.centerLeft,
      child: MaterialButton(
        color: Colors.red,
        shape: RoundedRectangleBorder(
  borderRadius: new BorderRadius.circular(18.0),
),

        onPressed: (){
          Navigator.pop(context);

        },
        child: Icon(Icons.close),
      ),
    );
  }
}
