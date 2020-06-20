import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class Boton extends StatelessWidget {

  List<dynamic> cartas;

  Boton({@required this.cartas});

  @override
  Widget build(BuildContext context) {
    return 
        CupertinoButton(
          child: Container(
            height: 150,
            width: 150,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage('http://via.placeholder.com/150x150'),
                fit: BoxFit.cover,
              ),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Container(
              margin: EdgeInsets.fromLTRB(0, 70,0, 0),
              child: 
              Center(
                child: Text(
                "Mindfulness",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w600),
                ),
              ),
            ),
          ),
          onPressed: () {},
        );
  }
}