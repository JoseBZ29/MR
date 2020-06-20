import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CelularPage extends StatelessWidget {
  const CelularPage({Key key}) : super(key: key);
  static final routeName = 'celular_page';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/login.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(

          child:Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Container(
                height: 150,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                color: Colors.white,
              ),
              child: Column(
              children: <Widget>[
                Container(
                  height: 40,
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(2),
                  margin:  const EdgeInsets.all(2),
                  child: Text('Usa tu cuenta para comenzar'),
                ),
                MaterialButton(
                  padding: const EdgeInsets.only(left:66,right:66,top: 15,bottom: 15),
                  color: Colors.green,
                  shape: RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(0.0),
                ),
                  onPressed: (){
                    Navigator.pushReplacementNamed(context, 'login');
                  },
                  
                  child: Text('Bienvenido devuelta',style: TextStyle(color:Colors.white)),
                ),
                Container(
                  padding: const EdgeInsets.all(2),
                  margin:  const EdgeInsets.all(2),
                ),
                MaterialButton(

                  padding: const EdgeInsets.only(left:50,right:50,top: 15,bottom: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(0.0),
                    side: BorderSide(color: Colors.grey[300])
                  ),
                  onPressed: (){
                    Navigator.pushReplacementNamed(context, 'register2.0');
                  },
                  
                  child: Text('¿Aun no estas registrado?',style:TextStyle(color: Colors.green)),
                ),
              ],
              )
              )
            ],
          ),
        ),
      )
    );
  }
}