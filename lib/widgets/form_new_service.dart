import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FormNewService extends StatefulWidget {
  FormNewService({Key key}) : super(key: key);

  @override
  _FormNewServiceState createState() => _FormNewServiceState();
}

class _FormNewServiceState extends State<FormNewService> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
          child: Container(
         child: Container(
        child: Column(
      children: <Widget>[
        Text('Alan'),
        Container(
          height: MediaQuery.of(context).size.height * .5,
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Container(
                  color: Colors.blue,
                  width: double.infinity,
                  height: 100,
                ),
                Expanded(child: Text('Hola'))
              ],
            ),
          ),
        )
      ],
    )),
      ),
    );
  }
}