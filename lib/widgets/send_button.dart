import 'package:flutter/material.dart';

class SendButton extends StatefulWidget {
  @override
  _SendButtonState createState() => _SendButtonState();
}

class _SendButtonState extends State<SendButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Container(
        child: Column(
          children: <Widget>[
            Divider(
              height: 1,
              thickness: 2,
              color: Color.fromRGBO(0, 0, 0, 0.05),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * .02,
            ),
            MaterialButton(
              onPressed: () {
                Navigator.pushNamed(context, 'web');//aqui es we 
              },
              color: Colors.black,
              textColor: Colors.white,
              child: Text('Enviar solicitud de servicio'),
              height: 50,
              minWidth: 300,
              onLongPress: null,
              disabledColor: Colors.grey,
              shape: RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(18.0),
                side: BorderSide(color: Colors.black),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * .02,
            )
          ],
        ),
      ),
    );
  }
}
