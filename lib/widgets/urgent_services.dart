import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';

// class ServiceItems {
//   final String title;
//   final List<String> images;
//   final List<Color> colors;
//   final List<String> subtitles;
//   ServiceItems(
//       {@required this.images,
//       @required this.title,
//       @required this.colors,
//       @required this.subtitles});
// }

class UrgentServices extends StatelessWidget {
  final String titulo;
  final List<String> serviceTitle;
  final List<String> images;
  final int r;
  final int g;
  final int b;
  final String pagina;

  const UrgentServices(
      {@required this.serviceTitle,
      @required this.images,
      @required this.titulo,
      @required this.r,
      @required this.g,
      @required this.b,
      @required this.pagina});

  @override
  Widget build(BuildContext context) {
    // List<String> servicios = [
    //   'Salud',
    //   'Emergencia',
    //   'Urgencia',
    //   'Servicios',
    // ];

    // List<IconData> icons = [
    //   LineIcons.map,
    //   LineIcons.sort_numeric_asc,
    //   LineIcons.clock_o,
    //   LineIcons.cab,
    // ];

    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        return Column(children: <Widget>[
          SizedBox(
            height: 30,
          ),
          Container(
            padding: EdgeInsets.only(left: 15),
            alignment: Alignment.topCenter,
            child: Text(
              titulo,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18,color: Color.fromRGBO(r, g, b, 0.9)),
            ),
          ),
          Container(
            width: constraints.maxWidth,
            child: Wrap(
              children: serviceTitle.asMap().entries.map((url) {
                int idx = url.key;
                return Column(
                  children: <Widget>[
                    Container(
                        padding: EdgeInsets.all(
                            constraints.maxWidth / serviceTitle.length * .20),
                        width: constraints.maxWidth / serviceTitle.length,
                        height: constraints.maxWidth / serviceTitle.length,
                        child: GestureDetector(
                          onTap: () {
                            print('Hola');
                            Navigator.pushNamed(context, pagina,
                                arguments: [url.value, images[idx]]);
                          },
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(50),
                              child: Container(
                                decoration: BoxDecoration(boxShadow: [
                                  BoxShadow(
                                      color: Colors.white, spreadRadius: 3)
                                ]),
                                child: Image.asset(images[idx]),
                              )),
                        )),
                    Text(url.value,style: TextStyle(color:Color.fromRGBO(r, g, b, 0.9)),)
                  ],
                );
              }).toList(),
            ),
          ),
        ]);
      },
    );
  }
}


