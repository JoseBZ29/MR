import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce/widgets/argumentos.dart';
import 'package:ecommerce/widgets/search_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import '../widgets/service_form.dart';

class SearchTab extends StatefulWidget {
  @override
  _SearchTabState createState() => _SearchTabState();
}

class _SearchTabState extends State<SearchTab> {
 String name = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
        title: SearchBar()
      ),
        body: ListView(
                  children: <Widget>[Column(
          children: <Widget>[
            Container(
                height: MediaQuery.of(context).size.height/1.3,
                width: MediaQuery.of(context).size.width/1,
                child: StreamBuilder<QuerySnapshot>(
                  stream: name != "" && name != null
                      ? Firestore.instance
                          .collection('Categorias')
                          .snapshots()
                      : Firestore.instance.collection("Categorias").snapshots(),
                  builder:
                      (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.hasError) return new Text('Error: ${snapshot.error}');
                    switch (snapshot.connectionState) {
                      case ConnectionState.waiting:
                        return new Text('Loading...');
                      default:
                        return new ListView(
                          children:
                              snapshot.data.documents.map((DocumentSnapshot document) {
                            return Column(
                              children: <Widget>[
                                ListTile(
                                  leading: Image.network(document['imagen']),
                                  title: Text(document.documentID),
                                  subtitle: Text(document['Desc']),
                                  onTap: (){
                                    List grupo=[];
                                    grupo.add(document.documentID);
                                    Navigator.pushNamed(context, 'listaCat',arguments: Argumentos(grupo));
                                  },
                                ),
                                Divider()
                              ],
                            );
                          }).toList(),
                        );
                    }
                  },
                ),
                
              ),
          ],
    ),
                  ]
        ));

    
  }
  void initiateSearch(String val) {
    setState(() {
      name = val;
    });
  }
}
