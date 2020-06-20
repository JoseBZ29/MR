import 'package:flutter/material.dart';

class FullScreenWidget extends StatefulWidget {
  FullScreenWidget({Key key}) : super(key: key);

  @override
  _FullScreenWidgetState createState() => _FullScreenWidgetState();
}

class _FullScreenWidgetState extends State<FullScreenWidget> {
  bool check=false;
  bool succes=false;
  String dropdownValue='+52';
  @override
  Widget build(BuildContext context) {
    return Center(
        child: Container(
          width: MediaQuery.of(context).size.width-10,
          height: MediaQuery.of(context).size.height-80,
          padding: EdgeInsets.all(20),
          color: Colors.white,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Image.asset('assets/celular.gif'),
              Text('Para validar su celular, le enviaremos un SMS con un codigo que debera introducir para confirmar su celular.',style: TextStyle(fontSize: 15,color: Colors.black,decoration: TextDecoration.none,),textAlign: TextAlign.center,),
              Container(
                child: Card(
                  elevation: 0,
                  color: Colors.white,
                  child:TextField(

                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                      hintText: 'Telefono',
                      labelText: 'Telefono',

                      icon: DropdownButton<String>(
                        value: dropdownValue,
                        iconSize: 24,
                        elevation: 16,
                      onChanged: (String newValue) {
                        setState(() {
                          dropdownValue = newValue;
                        });
                      },
                      items: <String>['+52','+51','+68']
                        .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        })
                        .toList(),
                      ),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0))
                    ),
                  )
                ),
              ),
              !check
              ? MaterialButton(
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
                color: Colors.black,
                shape: RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(18.0), 
                ),
                child: Icon(Icons.arrow_forward,color: Colors.white)
              )
              :!succes
              ? CircularProgressIndicator()
              : Icon(Icons.check, color: Colors.green),
            ],
          ),
        ),
      );
  }
}