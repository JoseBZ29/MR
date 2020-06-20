import 'package:ecommerce/screens/service_details_presupuesto_page.dart';
import 'package:ecommerce/widgets/service_form.dart';
import 'package:ecommerce/widgets/service_form_presupuesto.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ServiceDetails extends StatefulWidget {
  static final routeName = 'service_details';
  
  @override
  _ServiceDetailsState createState() => _ServiceDetailsState();
}

class _ServiceDetailsState extends State<ServiceDetails> {
  
  @override
  Widget build(BuildContext context) {
    final List serviceName = ModalRoute.of(context).settings.arguments;
    print(serviceName[0]);
    if(serviceName[0]=='Otros'){
      return  ServiceDetailsPresupuesto();
    }else{
      return  ServiceForm(serviceTitle: serviceName[0]);
    }
    
  }
}


