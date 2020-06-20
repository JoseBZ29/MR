import 'package:flutter/material.dart';

class ServiceDescription extends StatelessWidget {
  final String description;

  const ServiceDescription({@required this.description});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 20, right: 10, left: 10),
      color: Colors.white,
      height: MediaQuery.of(context).size.height * .15,
      child: Text(
        description,
        style: TextStyle(fontSize: 17),
      ),
    );
  }
}
