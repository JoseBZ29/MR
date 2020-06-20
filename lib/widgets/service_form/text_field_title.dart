
import 'package:flutter/material.dart';

class TextFieldTitle extends StatefulWidget {


  @override
  _TextFieldTitleState createState() => _TextFieldTitleState();
}

class _TextFieldTitleState extends State<TextFieldTitle> {
  @override
  Widget build(BuildContext context) {
    return Container(
                            padding: EdgeInsets.only(left: 10, right: 10),
                            child :TextField(
                              decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20.0)),
                              borderSide: BorderSide(
                                  color: Color.fromRGBO(192, 195, 196, .25),
                                  width: 0),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.0)),
                              borderSide: BorderSide(
                                  color: Color.fromRGBO(0, 0, 0, .25),
                                  width: 0),
                            ),
                            hintText: "Título del servicio",
                            fillColor: Colors.grey[200],
                            filled: true,
                          )),
                          );
  }
}