import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:ecommerce/globals.dart' as globals;

class TimePicker extends StatefulWidget {
  TimePicker({Key key}) : super(key: key);

  @override
  _TimePickerState createState() => _TimePickerState();
}

class _TimePickerState extends State<TimePicker> {
  TimeOfDay time=TimeOfDay.now();

  String tiempo(int valor,int hora){
    if(valor<10){
      return hora.toString()+':'+'0'+valor.toString();
    }else{
      return hora.toString()+':'+valor.toString();
    }
  }
  
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    globals.hora=TimeOfDay.now();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width/2,
      child: Column(
        children: <Widget>[
          ListTile(contentPadding: EdgeInsets.only(left:MediaQuery.of(context).size.width/45),title: Icon(LineIcons.clock_o,size: MediaQuery.of(context).size.height/15,color: Color.fromRGBO(59, 164, 171, 0.9),)),
          Row(
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(left:MediaQuery.of(context).size.height/30,bottom: 5),
                child: Text('Hora')
                ),
            ],
          ),
          Container(
            padding: EdgeInsets.only(left: 10, right: 10),
            child: TextField(
                readOnly: true,
                onTap: () {
                  print('Hora');
                  _pickTime();
                },
                decoration: InputDecoration(
                  prefixIcon: Icon(
                    LineIcons.clock_o,
                    color: Color.fromRGBO(59, 164, 171, 0.9),
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
                  //hintText: time.toString() == TimeOfDay.now().toString() ? 'Hora que se realizará el servicio': time.hour.toString() + ':' + time.minute.toString(),
                  hintText: tiempo(time.minute,time.hour),
                  hintStyle: TextStyle(color: Colors.black),
                  fillColor: Colors.grey[200],
                  filled: true,
                )),
          )
        ],
      ),
    );
  }

  _pickTime() async {
    TimeOfDay t = await showTimePicker(
      
      context: context, initialTime: time);
    if (t != null)
      setState(() {
        time = t;
        globals.hora=t.hour.toString()+":"+t.minute.toString();
      });
  }
}
