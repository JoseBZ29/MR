import 'package:ecommerce/bottom_navigation/home_tab.dart';
import 'package:ecommerce/bottom_navigation/profile_tab.dart';
import 'package:ecommerce/bottom_navigation/search_tab.dart';
import 'package:ecommerce/bottom_navigation/services_tab.dart';
import 'package:ecommerce/screens/QRpage.dart';
import 'package:ecommerce/screens/pruebas.dart';
import 'package:ecommerce/widgets/my_page_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import '../widgets/bottom_menu.dart';

class HomePage extends StatefulWidget {
  static final routeName = 'home';

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {

  int currentPage = 0;
  

  //PageController _pageViewController;
  final _menu = [
    BottomMenuItem(icon: LineIcons.home, label: "Inicio", content: HomeTab()),
    BottomMenuItem(
        icon: LineIcons.search, label: "Buscar", content: SearchTab()),
    BottomMenuItem(
        icon: LineIcons.user, label: "Perfil", content: ProfileTab()),
    BottomMenuItem(
        icon: LineIcons.briefcase, label: "Servicios", content: ServicesTab()),
  ];

  @override
  void initState() {
    super.initState();
    //_pageViewController = PageController(initialPage: 0);
  }

  @override
  void dispose() {
  
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Center(
        child: SafeArea(
            child: MyPageView(
              children:_menu.map<Widget>((item) => item.content).toList(),
              currentPage: currentPage,
            )
        ),
      ),


      bottomNavigationBar: BottomMenu(
        items: _menu,
        currentPage: currentPage,
        onChange: (int newCurrentPage) {
          setState(() {
            currentPage = newCurrentPage;
          });
        },
      ),
    );
  }
}
