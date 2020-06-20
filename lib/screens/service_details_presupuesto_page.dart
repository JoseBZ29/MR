import 'package:ecommerce/widgets/service_form.dart';
import 'package:ecommerce/widgets/service_form_presupuesto.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ServiceDetailsPresupuesto extends StatefulWidget {
  static final routeName = 'service_details';
  ServiceDetailsPresupuesto();
  
  @override
  _ServiceDetailsPresupuestoState createState() => _ServiceDetailsPresupuestoState();
}

class _ServiceDetailsPresupuestoState extends State<ServiceDetailsPresupuesto> {
  
  @override
  Widget build(BuildContext context) {
    final List serviceName = ModalRoute.of(context).settings.arguments;
    return  ServiceFormPresupuesto(serviceTitle: serviceName[0]);
  }
}


