import 'dart:async';
import 'package:ecommerce/utils/utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

class AccountPage extends StatefulWidget {
  static final routeName = 'stepper_form_page';
  @override
  _AccountPageState createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  

  final _codeController = TextEditingController();
  final _mailController = TextEditingController();
  final _nameController = TextEditingController();
  final _passController = TextEditingController();
  bool _enabled = false;
  int currentStep;
  bool _autoValidate = true;
  String phoneNo;
  String Correo,Nombre,Contrasena,Telefono;
  List<StepState> _listState;
  GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  final RoundedLoadingButtonController _btnController = new RoundedLoadingButtonController();

  @override
  void initState() { 
    currentStep=0;
    _listState = [
      StepState.indexed,
      StepState.editing,
      StepState.complete
    ];
    super.initState();
  }

Future<bool> loginUser(String phone,BuildContext context) async{
  print(phone);
  FirebaseAuth _auth = FirebaseAuth.instance;
  _auth.verifyPhoneNumber(
    phoneNumber: phone.trim(), 
    timeout: Duration(seconds: 60), 
    verificationCompleted: (AuthCredential credential) async{
      Navigator.of(context).pop();
      AuthResult result = await _auth.signInWithCredential(credential);
      FirebaseUser user = result.user;
      if(user != null){
         Navigator.of(context).pop();
         setState(() {
           _enabled=true; 
         });
      }
    }, 
    verificationFailed: (AuthException exception){
      print(exception.message);
    }, 
    codeSent: (String verificationId, [int forceResendingToken]){
      showGeneralDialog(
    context: context,
    barrierDismissible: true,
    barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
    barrierColor: Colors.black,
    transitionDuration: Duration(microseconds: 200),
    pageBuilder: (BuildContext context,Animation first,Animation second){
          return Center(
        child: Container(
          width: MediaQuery.of(context).size.width-10,
          height: MediaQuery.of(context).size.height-80,
          padding: EdgeInsets.all(20),
          color: Colors.white,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Image.asset('assets/images/logo_splash.png', width: 100,),
              Text('Para validar su celular, le enviaremos un SMS con un codigo que debera introducir para confirmar su celular.',style: TextStyle(fontSize: 15,color: Colors.black,decoration: TextDecoration.none,),textAlign: TextAlign.center,),
              Container(
                child: Card(
                  elevation: 0,
                  color: Colors.white,
                  child:TextField(
                    keyboardType: TextInputType.text,
                    controller: _codeController,
                    decoration: InputDecoration(
                      hintText: 'Codigo de seguridad',
                      labelText: 'Ingrese el codigo de seguridad',
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0))
                    ),
                  )
                ),
              ),
              //aqui iria el perro boton con animacion alv
              RoundedLoadingButton(
              color: Colors.greenAccent,
              child: Text('Tap me!', style: TextStyle(color: Colors.white)),
              controller: _btnController,
              onPressed: () async{
                final code = _codeController.text.trim();
                  AuthCredential credential = PhoneAuthProvider.getCredential(
                    verificationId: verificationId, 
                    smsCode: code);
                    AuthResult result = await _auth.signInWithCredential(credential);
                    FirebaseUser user = result.user;
                    if( user != null ){
                       setState(() {
                         _enabled=true;
                         _btnController.success();
                       });
                    }else {
                      print('Error');
                    }
                    await Future.delayed(Duration(seconds:1));
                    Navigator.of(context).pop();
              },
              )
            ],
          ),
        ),
      );
        },
        );
    }, 
    codeAutoRetrievalTimeout: null);
}

List<Step>  createSteps(BuildContext context){
  List<Step> steps = [
    Step(
      title: const Text('Información de Cuenta'),
      isActive: true,
      state: currentStep == 0
            ? _listState[1]
            : currentStep > 0 ? _listState[2] : _listState[0],
      content: Column(
        children: <Widget>[
          TextFormField(
            decoration: InputDecoration(
              labelText: 'Ejemplo: merecomiendas@gmail.com',
              icon: Icon(Icons.mail)
              ),
            controller: _mailController,
            keyboardType: TextInputType.emailAddress,
            validator: (value) {
              if(isEmail(value)){
                return null;
              }else{
                return 'Ingresa un Email valido';
              }
            },
            maxLines: 1,
          )
        ],
      ),
    ),
    Step(
      isActive: true,
      state: currentStep == 1
            ? _listState[1]
            : currentStep > 1 ? _listState[2] : _listState[0],
      title: const Text('Información Personal'),
      content: Column(
        children: <Widget>[
          TextFormField(
            decoration: InputDecoration(
              labelText: 'Nombre Completo',
              icon: Icon(Icons.person)
            ),
            controller: _nameController,
            keyboardType: TextInputType.text,
            validator: (value) {
              if(isName(value)){
                return null;
              }else{
                return 'Ingresa nombre valido';
              }
            },
            maxLines: 1,
          ),
        ],
      ),
    ),
    Step(
      isActive: true,
      state: currentStep == 2
            ? _listState[1]
            : currentStep > 2 ? _listState[2] : _listState[0],
      title: const Text('Ajustes de Seguridad'),
      content: Column(
        children: <Widget>[
          TextFormField(
            decoration: InputDecoration(
              labelText: 'Contraseña',
              icon: Icon(Icons.lock)
            ),
            controller: _passController,
            keyboardType: TextInputType.visiblePassword,
            maxLines: 1,
          ),
          TextFormField(
            decoration: InputDecoration(
              labelText: 'Numero Telefonico',
              icon: Icon(Icons.phone)
            ),
            keyboardType: TextInputType.text,
            maxLines: 1,
            onChanged: (value){
              this.phoneNo = value;
            },
          ),
        ],
      ),
    ),
  ];
  return steps;
}
  
  @override
  Widget build(BuildContext context) {
    List<Step> _stepList = createSteps(context);
    var _onPressed;
    if (_enabled){
        _onPressed = (){
          submit(context);
        };
    }
    return new Scaffold(
        resizeToAvoidBottomInset: false,
        body: 
        Container(
          child: Form(
          key: _formKey,
          autovalidate: _autoValidate,
          child: Column(
            children: <Widget>[
          Expanded(
            child: Stepper(
              steps: _stepList,
              currentStep: currentStep,
              onStepContinue: (){
                setState(() {
                  if (currentStep < _stepList.length - 1) {
                        currentStep++;
                      } else if(currentStep == 2){
                        //submit();
                        loginUser(phoneNo,context);
                      } 
                      else {
                        currentStep = _stepList.length - 1;
                      }
                });
              },
              onStepTapped: (int i) {
                    setState(() {
                      currentStep = i;
                    });
                  },
              onStepCancel: (){
                setState(() {
                  if (currentStep > 0) {
                        currentStep--;
                      } else {
                        currentStep = 0;
                      }
                });
              }
            ),
          ),
           Container(
            margin: const EdgeInsets.all(5),
            child: RaisedButton(
              child: Text('Registrarme'),
              color: Colors.green,
              textColor: Colors.white,
              onPressed: _onPressed)
          ),
          Container(
            margin: const EdgeInsets.only(bottom: 150),
            child: Image.asset('assets/images/logo_splash.png', width: 100),
          )
        ]),),));
  }


  Widget modal(BuildContext context){

    showDialog(context: context,
      builder: (BuildContext context){
        return AlertDialog(
          title: new Text("Registro Exitoso"),
          content: new Text("Bienvenido a Me Recomiendan , Ahora solo tienes que iniciar sesión con tu correo y contraseña para gozar de nuestros servicios"),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("Entiendo"),
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.pushReplacementNamed(context, 'login');
              },
            ),
          ],
        );
      }
    );
  }

  void submit(BuildContext context){
    if (!_formKey.currentState.validate()){
      showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Datos Incorrectos"),
          content: new Text("Por favor revisa los datos ingresados, alguno de ellos no cumple con los requisitos necesarios"),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("Entiendo"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    ) ;
    }else{
      modal(context); 
      Correo = _mailController.text.trim();
      Nombre = _nameController.text.trim();
      Contrasena = _passController.text.trim();
      Telefono = phoneNo;
      Firestore.instance.collection('Usarios').document().setData({ 'Nombre': Nombre, 'Correo': Correo, 'Contraseña': Contrasena, 'Telefono': Telefono });
    }  
  }
}