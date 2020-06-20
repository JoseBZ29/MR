import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_country_picker/flutter_country_picker.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PasswordPage extends StatefulWidget {
  PasswordPage({Key key}) : super(key: key);

  @override
  _PasswordPageState createState() => _PasswordPageState();
}

class _PasswordPageState extends State<PasswordPage> {
  String _password;
  String _password2;
  String _comparador;
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  bool _isLogin = false;
  String codigo;

  _registro() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final form = _formKey.currentState;
    if (!form.validate()) {
      _scaffoldKey.currentState.hideCurrentSnackBar();

      return;
    }

    form.save();
    _scaffoldKey.currentState.showSnackBar(SnackBar(
        content: Text('Registrando....'),
      ));
    String celular = prefs.getString('celular');
    final FirebaseUser user = await FirebaseAuth.instance.currentUser();
    String correo = prefs.getString('correo');
    await Firestore.instance.collection('Usuarios').document().setData({
      'Contraseña': '$_password',
      'Celular': '$celular',
      'Correo': '$correo'
    });
    String username = 'merecomiendanmx@gmail.com';
    final smtpServer = SmtpServer('smtp.sendgrid.net',
        port: 587,
        username: 'apikey',
        password:
            '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');
    // Use the SmtpServer class to configure an SMTP server:
    // final smtpServer = SmtpServer('smtp.domain.com');
    // See the named arguments of SmtpServer for further configuration
    // options.

    // Create our message.
    final message = new Message()
      ..from = new Address(username)
      ..recipients.add('$correo')
      ..subject = 'Bienvenido a Me Recomiendan'
      ..text = 'This is the plain text.\nThis is line 2 of the text part.'
      ..html = '''<p>&nbsp;</p>
<!-- [if gte mso 15]>
<style type="text/css">
table {
font-size:0px;
mso-margin-top-alt:0px;
}

.fullwidthhalfleft {
width: 49% !important;
float:left !important;
}

.fullwidthhalfright {
width: 50% !important;
float:right !important;
}
</style>
<![endif]--><!-- [if t]><![endif]--><!-- [if t]><![endif]--><!-- [if t]><![endif]--><!-- [if t]><![endif]--><!-- [if t]><![endif]--><!-- [if t]><![endif]-->
<table style="margin: 0; padding: 0; width: 100% !important;" border="0" width="100%" cellspacing="0" cellpadding="0" align="center">
<tbody>
<tr>
<td class="wrap" align="center" valign="top" width="100%"><center><!-- content -->
<div style="padding: 0px;">
<table border="0" width="100%" cellspacing="0" cellpadding="0">
<tbody>
<tr>
<td style="padding: 0px;" valign="top">
<table class="email-root-wrapper" style="max-width: 600px; min-width: 240px; margin: 0 auto;" width="600" cellspacing="0" cellpadding="0" align="center">
<tbody>
<tr>
<td style="padding: 0px;" valign="top">
<table style="border: 0px none;" border="0" width="100%" cellspacing="0" cellpadding="0">
<tbody>
<tr>
<td style="padding: 0px;" valign="top">
<table width="100%" cellspacing="0" cellpadding="0">
<tbody>
<tr>
<td class="pattern" style="padding: 0px;">
<table border="0" width="100%" cellspacing="0" cellpadding="0">
<tbody>
<tr>
<td style="padding: 0px;" align="center" valign="top">
<table style="border: 0px none;" border="0" width="100" cellspacing="0" cellpadding="0">
<tbody>
<tr>
<td style="padding: 0px;" valign="top"><img class="img100x76" style="display: block;" src="https://images.chamaileon.io/5e3912273f3ce500070853f0/5e3912273f3ce500070853fa/1583389101837_image001.jpg" alt="" width="100" height="76" border="0" /></td>
</tr>
</tbody>
</table>
</td>
</tr>
</tbody>
</table>
<table border="0" width="100%" cellspacing="0" cellpadding="0">
<tbody>
<tr>
<td style="padding: 15px;" valign="top">
<div style="text-align: left; font-family: Arial; font-size: 28px; color: #00a891; line-height: 28px; mso-line-height: exactly;">
<p style="padding: 0; margin: 0; text-align: center;">Bienvenido a Me Recomiendan</p>
</div>
</td>
</tr>
</tbody>
</table>
<table border="0" width="100%" cellspacing="0" cellpadding="0">
<tbody>
<tr>
<td style="padding: 10px;" valign="top">
<div style="text-align: left; font-family: Arial; font-size: 17px; color: #000000; line-height: 22px; mso-line-height: exactly; mso-text-raise: 2px;">
<p style="padding: 0; margin: 0; text-align: center;">Tu nombre de Usuario es $correo</p>
</div>
</td>
</tr>
</tbody>
</table>
<table border="0" width="100%" cellspacing="0" cellpadding="0">
<tbody>
<tr>
<td style="padding: 10px;" valign="top">
<div style="text-align: left; font-family: Arial; font-size: 14px; color: #000000; line-height: 22px; mso-line-height: exactly; mso-text-raise: 4px;">
<p style="padding: 0; margin: 0; text-align: center;">Ya puedes iniciar sesion desde nuestra App</p>
<p style="padding: 0; margin: 0; text-align: center;">Te deseamos suerte en este nuevo comienzo</p>
<p style="padding: 0; margin: 0; text-align: center;">Desde ahora te ayudaremos a tener trabajo continuamente</p>
</div>
</td>
</tr>
</tbody>
</table>
<table border="0" width="100%" cellspacing="0" cellpadding="0">
<tbody>
<tr>
<td style="padding: 0; mso-cellspacing: 0in;" valign="top">
<table id="c0p0r" class="c0p0r" style="float: left; padding-left: 150px;" border="0" width="0" cellspacing="0" cellpadding="0" align="left">
<tbody>
<tr>
<td style="padding: 0px;" valign="top">
<table border="0" width="100%" cellspacing="0" cellpadding="0">
<tbody>
<tr>
<td style="padding: 0px;" align="center" valign="top">
<table style="border: 0px none;" border="0" width="142" cellspacing="0" cellpadding="0">
<tbody>
<tr>
<td style="padding: 0px;" valign="top"><a class="imglink" href="https://play.google.com/store/apps?hl=es_MX" target="_blank"><img class="img142x43" style="display: block;" src="https://images.chamaileon.io/5e3912273f3ce500070853f0/5e3912273f3ce500070853fa/1583387891204_image007.png" alt="" width="142" height="43" border="0" /></a></td>
</tr>
</tbody>
</table>
</td>
</tr>
</tbody>
</table>
</td>
</tr>
</tbody>
</table>
<!-- [if gte mso 9]></td><td valign="top" style="padding:0;"><![endif]-->
<table id="c0p0r" class="c0p0r" style="float: left; width: 152.2px;" border="0" cellspacing="0" cellpadding="0" align="left">
<tbody>
<tr>
<td style="padding: 0px; width: 148.2px;" valign="top">
<table border="0" width="100%" cellspacing="0" cellpadding="0">
<tbody>
<tr>
<td style="padding: 0px;" align="center" valign="top">
<table style="border: 0px none;" border="0" width="142" cellspacing="0" cellpadding="0">
<tbody>
<tr>
<td style="padding: 0px;" valign="top"><a class="imglink" href="https://www.apple.com/mx/ios/app-store/" target="_blank"><img class="img142x44" style="display: block;" src="https://images.chamaileon.io/5e3912273f3ce500070853f0/5e3912273f3ce500070853fa/1583387879279_image005.png" alt="" width="142" height="44" border="0" /></a></td>
</tr>
</tbody>
</table>
</td>
</tr>
</tbody>
</table>
</td>
</tr>
</tbody>
</table>
</td>
</tr>
</tbody>
</table>
</td>
</tr>
</tbody>
</table>
</td>
</tr>
</tbody>
</table>
</td>
</tr>
</tbody>
</table>
</td>
</tr>
</tbody>
</table>
<table border="0" width="100%" cellspacing="0" cellpadding="0">
<tbody>
<tr>
<td style="padding: 0px;" valign="top">
<table class="email-root-wrapper" style="max-width: 600px; min-width: 240px; margin: 0 auto;" width="600" cellspacing="0" cellpadding="0" align="center">
<tbody>
<tr>
<td style="padding: 0px;" valign="top">
<table style="border: 0px none;" border="0" width="100%" cellspacing="0" cellpadding="0">
<tbody>
<tr>
<td style="padding: 0px;" valign="top">
<table width="100%" cellspacing="0" cellpadding="0">
<tbody>
<tr>
<td class="pattern" style="padding: 0px;">
<table border="0" width="100%" cellspacing="0" cellpadding="0">
<tbody>
<tr>
<td style="padding: 20px;" valign="top">
<table width="100%" cellspacing="0" cellpadding="0">
<tbody>
<tr>
<td style="padding: 0px;">
<table style="border-top: 2px solid #00a891;" border="0" width="100%" cellspacing="0" cellpadding="0">
<tbody>
<tr>
<td valign="top">
<table width="100%" cellspacing="0" cellpadding="0">
<tbody>
<tr>
<td style="padding: 0px;">&nbsp;</td>
</tr>
</tbody>
</table>
</td>
</tr>
</tbody>
</table>
</td>
</tr>
</tbody>
</table>
</td>
</tr>
</tbody>
</table>
<table border="0" width="100%" cellspacing="0" cellpadding="0">
<tbody>
<tr>
<td style="padding: 10px;" valign="top">
<div style="text-align: left; font-family: Arial; font-size: 14px; color: #000000; line-height: 22px; mso-line-height: exactly; mso-text-raise: 4px;">
<p style="padding: 0; margin: 0; text-align: center;">Hemos recibido correctamente tu informacion</p>
<p style="padding: 0; margin: 0; text-align: center;">Recuerda que la seguridad es muy importante para nosotros</p>
</div>
</td>
</tr>
</tbody>
</table>
<table border="0" width="100%" cellspacing="0" cellpadding="0">
<tbody>
<tr>
<td style="padding: 0; mso-cellspacing: 0in;" valign="top">
<table id="c135p22r" class="c135p22r" style="float: left;" border="0" width="135" cellspacing="0" cellpadding="0" align="left">
<tbody>
<tr>
<td style="padding: 0px;" valign="top">
<table border="0" width="100%" cellspacing="0" cellpadding="0">
<tbody>
<tr>
<td style="padding: 0px;" align="center" valign="top">
<table style="border: 0px none;" border="0" width="49" cellspacing="0" cellpadding="0">
<tbody>
<tr>
<td style="padding: 0px;" valign="top"><img class="img49x39" style="display: block;" src="https://images.chamaileon.io/5e3912273f3ce500070853f0/5e3912273f3ce500070853fa/1583388389221_image012.png" alt="" width="49" height="39" border="0" /></td>
</tr>
</tbody>
</table>
</td>
</tr>
</tbody>
</table>
</td>
</tr>
</tbody>
</table>
<!-- [if gte mso 9]></td><td valign="top" style="padding:0;"><![endif]-->
<table id="c465p77r" class="c465p77r" style="float: left;" border="0" width="465" cellspacing="0" cellpadding="0" align="left">
<tbody>
<tr>
<td style="padding: 0px;" valign="top">
<table border="0" width="100%" cellspacing="0" cellpadding="0">
<tbody>
<tr>
<td style="padding: 10px;" valign="top">
<div style="text-align: left; font-family: Arial; font-size: 13px; color: #000000; line-height: 22px; mso-line-height: exactly; mso-text-raise: 4px;">
<p style="padding: 0; margin: 0;">Tu perfil y la informacion sera validada por nuestros expertos</p>
</div>
</td>
</tr>
</tbody>
</table>
</td>
</tr>
</tbody>
</table>
</td>
</tr>
</tbody>
</table>
<table border="0" width="100%" cellspacing="0" cellpadding="0">
<tbody>
<tr>
<td style="padding: 0; mso-cellspacing: 0in;" valign="top">
<table id="c135p22r" class="c135p22r" style="float: left;" border="0" width="135" cellspacing="0" cellpadding="0" align="left">
<tbody>
<tr>
<td style="padding: 0px;" valign="top">
<table border="0" width="100%" cellspacing="0" cellpadding="0">
<tbody>
<tr>
<td style="padding: 23px;" align="center" valign="top">
<table style="border: 0px none;" border="0" width="49" cellspacing="0" cellpadding="0">
<tbody>
<tr>
<td style="padding: 0px;" valign="top"><img class="img49x39" style="display: block;" src="https://images.chamaileon.io/5e3912273f3ce500070853f0/5e3912273f3ce500070853fa/1583388389221_image012.png" alt="" width="49" height="39" border="0" /></td>
</tr>
</tbody>
</table>
</td>
</tr>
</tbody>
</table>
</td>
</tr>
</tbody>
</table>
<!-- [if gte mso 9]></td><td valign="top" style="padding:0;"><![endif]-->
<table id="c465p77r" class="c465p77r" style="float: left;" border="0" width="465" cellspacing="0" cellpadding="0" align="left">
<tbody>
<tr>
<td style="padding: 0px;" valign="top">
<table border="0" width="100%" cellspacing="0" cellpadding="0">
<tbody>
<tr>
<td style="padding: 10px;" valign="top">
<div style="text-align: left; font-family: Arial; font-size: 13px; color: #000000; line-height: 22px; mso-line-height: exactly; mso-text-raise: 4px;">
<p style="padding: 0; margin: 0;">Si fuera necesario nuestro personal se contactara contigo a tu correo electronico $correo o al telefono que nos proporcionaste (+52) $celular</p>
</div>
</td>
</tr>
</tbody>
</table>
</td>
</tr>
</tbody>
</table>
</td>
</tr>
</tbody>
</table>
<table border="0" width="100%" cellspacing="0" cellpadding="0">
<tbody>
<tr>
<td style="padding: 0; mso-cellspacing: 0in;" valign="top">
<table id="c135p22r" class="c135p22r" style="float: left;" border="0" width="135" cellspacing="0" cellpadding="0" align="left">
<tbody>
<tr>
<td style="padding: 0px;" valign="top">
<table border="0" width="100%" cellspacing="0" cellpadding="0">
<tbody>
<tr>
<td style="padding: 0px;" align="center" valign="top">
<table style="border: 0px none;" border="0" width="49" cellspacing="0" cellpadding="0">
<tbody>
<tr>
<td style="padding: 0px;" valign="top"><img class="img49x39" style="display: block;" src="https://images.chamaileon.io/5e3912273f3ce500070853f0/5e3912273f3ce500070853fa/1583388389221_image012.png" alt="" width="49" height="39" border="0" /></td>
</tr>
</tbody>
</table>
</td>
</tr>
</tbody>
</table>
</td>
</tr>
</tbody>
</table>
<!-- [if gte mso 9]></td><td valign="top" style="padding:0;"><![endif]-->
<table id="c465p77r" class="c465p77r" style="float: left;" border="0" width="465" cellspacing="0" cellpadding="0" align="left">
<tbody>
<tr>
<td style="padding: 0px;" valign="top">
<table border="0" width="100%" cellspacing="0" cellpadding="0">
<tbody>
<tr>
<td style="padding: 10px;" valign="top">
<div style="text-align: left; font-family: Arial; font-size: 13px; color: #000000; line-height: 22px; mso-line-height: exactly; mso-text-raise: 4px;">
<p style="padding: 0; margin: 0;">En breve tu perfil sera activado</p>
</div>
</td>
</tr>
</tbody>
</table>
</td>
</tr>
</tbody>
</table>
</td>
</tr>
</tbody>
</table>
</td>
</tr>
</tbody>
</table>
</td>
</tr>
</tbody>
</table>
</td>
</tr>
</tbody>
</table>
</td>
</tr>
</tbody>
</table>
<table border="0" width="100%" cellspacing="0" cellpadding="0">
<tbody>
<tr>
<td style="padding: 0px;" valign="top">
<table class="email-root-wrapper" style="max-width: 600px; min-width: 240px; margin: 0 auto;" width="600" cellspacing="0" cellpadding="0" align="center">
<tbody>
<tr>
<td style="padding: 0px;" valign="top">
<table style="border: 0px none;" border="0" width="100%" cellspacing="0" cellpadding="0">
<tbody>
<tr>
<td style="padding: 0px;" valign="top">
<table width="100%" cellspacing="0" cellpadding="0">
<tbody>
<tr>
<td style="padding: 0px;">
<table style="background-color: #ffffff;" border="0" width="100%" cellspacing="0" cellpadding="0" bgcolor="#FFFFFF">
<tbody>
<tr>
<td style="padding: 20px;" valign="top">
<table width="100%" cellspacing="0" cellpadding="0">
<tbody>
<tr>
<td style="padding: 0px;">
<table style="border-top: 2px solid #00a891;" border="0" width="100%" cellspacing="0" cellpadding="0">
<tbody>
<tr>
<td valign="top">
<table width="100%" cellspacing="0" cellpadding="0">
<tbody>
<tr>
<td style="padding: 0px;">&nbsp;</td>
</tr>
</tbody>
</table>
</td>
</tr>
</tbody>
</table>
</td>
</tr>
</tbody>
</table>
</td>
</tr>
</tbody>
</table>
<table class="full-width" border="0" width="100%" cellspacing="0" cellpadding="0">
<tbody>
<tr>
<td style="padding: 0px;" align="center" valign="top">
<table class="full-width" style="border: 0px none;" border="0" width="600" cellspacing="0" cellpadding="0">
<tbody>
<tr>
<td style="padding: 0px;" valign="top"><img class="full-width img600x317" style="display: block; max-width: 100%; height: auto;" src="https://images.chamaileon.io/5e3912273f3ce500070853f0/5e3912273f3ce500070853fa/1583389055784_WhatsApp%20Image%202020-03-05%20at%2012.17.13%20AM%20%281%29.jpeg" alt="" width="600" height="317" border="0" /></td>
</tr>
</tbody>
</table>
</td>
</tr>
</tbody>
</table>
<table border="0" width="100%" cellspacing="0" cellpadding="0">
<tbody>
<tr>
<td style="padding: 20px;" valign="top">
<table width="100%" cellspacing="0" cellpadding="0">
<tbody>
<tr>
<td style="padding: 0px;">
<table style="border-top: 2px solid #00a891;" border="0" width="100%" cellspacing="0" cellpadding="0">
<tbody>
<tr>
<td valign="top">
<table width="100%" cellspacing="0" cellpadding="0">
<tbody>
<tr>
<td style="padding: 0px;">&nbsp;</td>
</tr>
</tbody>
</table>
</td>
</tr>
</tbody>
</table>
</td>
</tr>
</tbody>
</table>
</td>
</tr>
</tbody>
</table>
</td>
</tr>
</tbody>
</table>
</td>
</tr>
</tbody>
</table>
</td>
</tr>
</tbody>
</table>
</td>
</tr>
</tbody>
</table>
<table border="0" width="100%" cellspacing="0" cellpadding="0">
<tbody>
<tr>
<td style="padding: 0px;" valign="top">
<table class="email-root-wrapper" style="max-width: 600px; min-width: 240px; margin: 0 auto;" width="600" cellspacing="0" cellpadding="0" align="center">
<tbody>
<tr>
<td style="padding: 0px;" valign="top">
<table class="full-width" border="0" width="100%" cellspacing="0" cellpadding="0">
<tbody>
<tr>
<td style="padding: 0px;" align="center" valign="top">
<table class="full-width" style="border: 0px none;" border="0" width="600" cellspacing="0" cellpadding="0">
<tbody>
<tr>
<td style="padding: 0px;" valign="top"><img class="full-width img600x391" style="display: block; max-width: 100%; height: auto;" src="https://images.chamaileon.io/5e3912273f3ce500070853f0/5e3912273f3ce500070853fa/1583388958116_WhatsApp%20Image%202020-03-05%20at%2012.14.55%20AM.jpeg" alt="" width="600" height="391" border="0" /></td>
</tr>
</tbody>
</table>
</td>
</tr>
</tbody>
</table>
</td>
</tr>
</tbody>
</table>
</td>
</tr>
</tbody>
</table>
</div>
<!-- content end --></center></td>
</tr>
</tbody>
</table>''';
    try {
      final sendReport = await send(message, smtpServer);
      print('Message sent: ' + sendReport.toString());
    } on MailerException catch (e) {
      print('Message not sent.');
      print(e);
      for (var p in e.problems) {
        print('Problem: ${p.code}: ${p.msg}');
      }
    }

    Navigator.pushNamed(context, 'registroCompletado');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ingresa tu contraseña'),
        centerTitle: true,
        backgroundColor: Color.fromRGBO(59, 164, 171, 0.9),
      ),
      body: Center(
        child: ListView(children: <Widget>[
          Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height / 30,
                      left: MediaQuery.of(context).size.width / 30,
                      right: MediaQuery.of(context).size.width / 30),
                  child: TextFormField(
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                      icon: Icon(Icons.vpn_key),
                      hintText: 'Escribe una contraseña',
                    ),
                    onSaved: (val) {
                      setState(() {
                        _password = val;
                      });
                    },
                    onChanged: (val) {
                      setState(() {
                        _comparador = val;
                      });
                    },
                    validator: (val) {
                      if (val.isEmpty) {
                        return 'Ingrese una contraseña';
                      } else if (val.length < 6) {
                        return 'Ingrese una contraseña de minimo 6 caracteres';
                      } else {
                        return null;
                      }
                    },
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height / 30,
                      left: MediaQuery.of(context).size.width / 30,
                      right: MediaQuery.of(context).size.width / 30),
                  child: TextFormField(
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                      icon: Icon(Icons.vpn_key),
                      hintText: 'Escribe de nuevo tu contraseña',
                    ),
                    validator: (val) {
                      if (val.isEmpty) {
                        return 'Ingrese una contraseña valida';
                      } else if (val != _comparador) {
                        return 'Las contraseñas no coinciden';
                      } else {
                        return null;
                      }
                    },
                  ),
                ),
                Container(
                    padding: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height / 15),
                    child: FlatButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0)),
                        padding: EdgeInsets.only(
                            top: MediaQuery.of(context).size.width / 32,
                            bottom: MediaQuery.of(context).size.width / 32,
                            left: MediaQuery.of(context).size.height / 15,
                            right: MediaQuery.of(context).size.height / 15),
                        color: Color.fromRGBO(59, 164, 171, 0.9),
                        onPressed: () {
                          _registro();
                        },
                        child: Text(
                          'Guardar contraseña',
                          style: TextStyle(
                              fontSize: MediaQuery.of(context).size.height / 35,
                              color: Colors.white),
                        ))),
                Container(
                    margin: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height / 4),
                    child: Image.asset(
                      'assets/images/logoMe.png',
                      scale: 1.5,
                    ))
              ],
            ),
          ),
        ]),
      ),
    );
  }
}
