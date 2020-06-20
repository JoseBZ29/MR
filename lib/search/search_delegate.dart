import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce/providers/provider_servicios.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';

class DataSearch extends SearchDelegate {
  String selected;

  @override
  List<Widget> buildActions(BuildContext context) {
    // TODO: implement buildActions
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    // TODO: implement buildLeading
    return IconButton(
        icon: AnimatedIcon(
          icon: AnimatedIcons.menu_arrow,
          progress: transitionAnimation,
        ),
        onPressed: () {
          close(context, null);
        });
  }

  @override
  Widget buildResults(BuildContext context) {
    // TODO: implement buildResults
    return Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance
          .collection('Profesiones')
          .where("Profecion", isGreaterThanOrEqualTo: query)
          .snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) return new Text('Error: ${snapshot.error}');
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return new Text('Cargando...');
          default:
            return new ListView(
              children:
                  snapshot.data.documents.map((DocumentSnapshot document) {
                print(document['Profecion']);
                return new ListTile(
                    title: new Text(document['Profecion']),
                    onTap: () {
                      Navigator.pushNamed(context, 'service_details',
                          arguments: document['Profecion']);
                    });
              }).toList(),
            );
        }
      },
    );
  }
}
