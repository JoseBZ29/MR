import 'package:carousel_pro/carousel_pro.dart';
import 'package:ecommerce/search/search_delegate.dart';
import 'package:ecommerce/widgets/my_appbar.dart';
import 'package:ecommerce/widgets/search_bar.dart';
import 'package:ecommerce/widgets/search_bar2.dart';
import 'package:ecommerce/widgets/urgent_services.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeTab extends StatefulWidget {
  @override
  _HomeTabState createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {

    String nombre;
 @override
  void initState() {
    super.initState();
    init();
  }

   init() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    nombre = prefs.getString('nombre') ?? 'Nombre';
    setState(() {
      
    });
  }
  
  @override
  Widget build(BuildContext context) {
    final List<String> images = [
      "assets/images/1.jpg",
      "assets/images/2.png",
      "assets/images/3.png",
      "assets/images/4.png",
      "assets/images/5.png",
    ];

    
    return Container(
        child: Column(
      children: <Widget>[
        MyAppBar('$nombre'),
        SearchBar(),
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                SizedBox(
                    height: 200.0,
                    width: double.infinity,
                    child: Carousel(
                      autoplayDuration: Duration(seconds: images.length+2) ,
                      animationDuration: Duration(milliseconds: 500),
                      images: images.map(
                        (url) {
                          return Container(
                            child: Image.asset(url, fit: BoxFit.fill),
                          );
                        },
                      ).toList(),
                      dotSize: 4.0,
                      dotSpacing: 15.0,
                      dotColor: Colors.purpleAccent,
                      indicatorBgPadding: 5.0,
                      dotBgColor: Colors.black.withOpacity(0.5),
                      borderRadius: true,
                    )),
                
                
                UrgentServices(
                  r: 59,
                  g: 164,
                  b: 171,
                  pagina: 'fast_service_page',
                  images: <String>[
                    'assets/home/servicios_urgentes/Veterinario.png',
                    'assets/home/servicios_urgentes/enfermera.png',
                    'assets/home/servicios_urgentes/inyeccion.png',
                    'assets/home/servicios_urgentes/ambulancia.png'
                  ],

                  serviceTitle: <String>[
                    'Veterinario',
                    'Enfermería',
                    'Inyecciones',
                    'Ambulancia',
                  ], titulo: 'Salud',

                ),

                UrgentServices(
                  r: 154,
                  g: 115,
                  b: 156,
                  pagina: 'fast_service_page',
                  images: <String>[
                    'assets/home/servicios_urgentes/cerrajero.png',
                    'assets/home/servicios_urgentes/llave.png',
                    'assets/home/servicios_urgentes/gas.png',
                    'assets/home/servicios_urgentes/plomeria.png'
                  ],
                  serviceTitle: <String>[
                    'Cerrajero Auto',
                    'Cerrajero',
                    'Fuga de gas',
                    'Fontanero',
                  ], titulo: 'Urgencia',
                ),
                UrgentServices(
                  r: 202,
                  g: 72,
                  b: 82,
                  pagina: 'fast_service_page',
                  images: <String>[
                    'assets/home/servicios_urgentes/grua.png',
                    'assets/home/servicios_urgentes/ponchadura.png',
                    'assets/home/servicios_urgentes/gasolina.png',
                    'assets/home/servicios_urgentes/bateria.png'
                  ],
                  serviceTitle: <String>[
                    'Mecánica',
                    'Ponchadura',
                    'Gasolina',
                    'Batería',
                  ], titulo: 'Emergencia',
                ),
                UrgentServices(
                  r: 80,
                  g: 111,
                  b: 136,
                  pagina: 'service_details',
                  images: <String>[
                    'assets/home/servicios_urgentes/pintura.png',
                    'assets/home/servicios_urgentes/albanil.png',
                    'assets/home/servicios_urgentes/electrico.png',
                    'assets/home/servicios_urgentes/otros.png'
                  ],
                  serviceTitle: <String>[
                    'Pintura',
                    'Construcción',
                    'Electricista',
                    'Otros',
                  ], titulo: 'Servicios',
                ),
                
              ],
            ),
          ),
        )
      ],
    ));
  }
}
