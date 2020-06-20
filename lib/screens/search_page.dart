import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage>
    with SingleTickerProviderStateMixin {

  @override
  Widget build(BuildContext context) {

        
        final String titulo = ModalRoute.of(context).settings.arguments;

        return Scaffold(
          appBar: AppBar(
            title: Text('$titulo'),
            centerTitle: true,
            elevation: 0.0, 
            iconTheme: IconThemeData(
              color: Colors.black,
            ),
            textTheme: TextTheme(
              title: TextStyle(
                color: Colors.black,
                fontSize: 20.0,
              )
            ),
            backgroundColor: Colors.white,
          ),
          body: SafeArea(
                  child: Column(
              children: <Widget>[
                Expanded(
                  child:  StreamBuilder<QuerySnapshot>(
            stream: Firestore.instance
                        .collection('Profesiones')
                        .where("Grupo", isEqualTo: "$titulo")
                        .snapshots(),
            builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasError)
                return new Text('Error: ${snapshot.error}');
              switch (snapshot.connectionState) {
                case ConnectionState.waiting: return new Text('Loading...');
                default:
                  return new ListView(
                          children: snapshot.data.documents
                              .map((DocumentSnapshot document) {
                                print(document['Profecion']);
                            return new ListTile(
                              title: new Text(document['Profecion']),
                              onTap: () {
                                Navigator.pushNamed(context, 'service_details', arguments:document['Profecion']);
                              }
                            );
                          }).toList(),
                  );
              }
            },
        ),
                  
                ),
              ],
            ),
          )
        );
      }


}
