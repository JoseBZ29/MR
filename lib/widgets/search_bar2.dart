import 'package:ecommerce/bottom_navigation/search_tab.dart';
import 'package:ecommerce/screens/home_page.dart';
import 'package:ecommerce/search/search_delegate.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';

import 'bottom_menu.dart';

class SearchBar2 extends StatefulWidget {
  @override
  _SearchBar2State createState() => _SearchBar2State();
}

class _SearchBar2State extends State<SearchBar2> {
  String _buscador;
  final bottom=BottomMenu();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Container(
          width: double.infinity,
          padding: EdgeInsets.all(10.0),
          child: TextField(
            onTap: () {
              setState(() {
                print(bottom.currentPage);
                bottom.onChange(2);
              });
            },
            autocorrect: true,
            decoration: InputDecoration(
              contentPadding:
                  new EdgeInsets.symmetric(vertical: 1.0, horizontal: 10.0),
              hintText: 'Buscar servicio...',
              prefixIcon: Icon(
                LineIcons.search,
                color: Colors.grey,
              ),
              hintStyle: TextStyle(
                color: Colors.grey,
              ),
              alignLabelWithHint: true,
              filled: true,
              fillColor: Color.fromRGBO(192, 195, 196, .25),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(20.0)),
                borderSide: BorderSide(
                    color: Color.fromRGBO(192, 195, 196, .25), width: 0),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
                borderSide: BorderSide(
                    color: Color.fromRGBO(192, 195, 196, .25), width: 0),
              ),
            ),
          )),
    );
  }
}
