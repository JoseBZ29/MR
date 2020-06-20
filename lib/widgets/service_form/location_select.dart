import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';

class LocationSelect extends StatefulWidget {
  LocationSelect({Key key}) : super(key: key);

  @override
  _LocationSelectState createState() => _LocationSelectState();
}

class _LocationSelectState extends State<LocationSelect> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: GestureDetector(
        onTap: () {
          FocusScopeNode currentFocus = FocusScope.of(context);

        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
          Navigator.pushNamed(context, 'mapa_curso');
        },
        child: Container(
          padding: EdgeInsets.only(top: 20, left: 10),
          child: Row(
            children: <Widget>[
              Icon(
                LineIcons.map_marker,
                color: Colors.blueAccent,
              ),
              Text(
                "Selecciona la ubicación",
                textAlign: TextAlign.left,
                style: TextStyle(
                  color: Colors.blueAccent,
                  fontSize: 18,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
