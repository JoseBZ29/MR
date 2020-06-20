import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:ecommerce/globals.dart' as globals;

class DatePicker extends StatefulWidget {
  DatePicker({Key key}) : super(key: key);

  @override
  _DatePickerState createState() => _DatePickerState();
}

class _DatePickerState extends State<DatePicker> {
  DateTime _dateTime;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width/2,
      child: Column(
        children: <Widget>[
          ListTile(contentPadding: EdgeInsets.only(left:MediaQuery.of(context).size.width/45),title: Icon(LineIcons.calendar,size: MediaQuery.of(context).size.height/15,color: Color.fromRGBO(59, 164, 171, 0.9),)),
          Row(
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(left:MediaQuery.of(context).size.height/30,bottom: 5),
                child: Text('Fecha')
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
                    LineIcons.calendar,
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
                  hintText: _dateTime==null ? 'Selecione una fecha': _dateTime.day.toString()+'/'+_dateTime.month.toString()+"/"+_dateTime.year.toString(),
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
    showDatePicker(
      context: context, 
      initialDate: DateTime.now(), 
      firstDate: DateTime(2001), 
      lastDate: DateTime(2026)
      ).then((date){
        setState(() {
          _dateTime=date;
          globals.fecha=_dateTime.day.toString()+'/'+_dateTime.month.toString()+"/"+_dateTime.year.toString();
        });
      });
  }
}
