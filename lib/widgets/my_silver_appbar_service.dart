import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class MySilverAppBarService extends StatelessWidget {
  
  

  final String title;

  const MySilverAppBarService({@required this.title});
 @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      backgroundColor: Colors.white,
      expandedHeight: MediaQuery.of(context).size.height * .2,
      floating: true,
      pinned: true,
      iconTheme: IconThemeData(color: Colors.black),
      flexibleSpace: FlexibleSpaceBar(
          centerTitle: true,
          title: Text(title,
              style: TextStyle(
                color: Colors.black,
                fontSize: 16.0,
              )),
          background: Container(
            height: 100,
            child: SvgPicture.asset(
              'assets/images/business.svg',
              height: MediaQuery.of(context).size.height * .1,
            ),
          )),
    );
  }
}