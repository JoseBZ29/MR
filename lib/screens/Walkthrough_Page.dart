import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:introduction_screen/introduction_screen.dart';

class WalkThrough extends StatelessWidget {
  static final routeName = 'WalkThrough';

  List<PageViewModel> getPages(context) {
    return [
      PageViewModel(
          image: Image.asset(
            "assets/images/ServiciosNecesitas.png",
            scale: 1.6,
          ),
          title: "Todos",
          body: "los servicios",
          footer: Text(
            'que necesitas',
            style: GoogleFonts.robotoMono(
                fontWeight: FontWeight.w300,
                fontSize: MediaQuery.of(context).size.height / 35),
          ),
          decoration: PageDecoration(
            imagePadding: EdgeInsets.only(top:MediaQuery.of(context).size.height/30),
            titlePadding: EdgeInsets.only(
                top: MediaQuery.of(context).size.height / 20,
                bottom: MediaQuery.of(context).size.height / 40),
            titleTextStyle: GoogleFonts.robotoMono(
                fontWeight: FontWeight.w300,
                fontSize: MediaQuery.of(context).size.height / 35),
            bodyTextStyle: GoogleFonts.robotoMono(
                fontWeight: FontWeight.w300,
                fontSize: MediaQuery.of(context).size.height / 35),
          )),
     // PageViewModel(
       //   image:
         //     Image.asset("assets/images/logoMe2.png", fit: BoxFit.fitHeight),
         // title: "Te esperamos pronto",
         // body: "",
          //decoration: PageDecoration(
            //  titlePadding:
              //    EdgeInsets.only(top: MediaQuery.of(context).size.height / 10),
             // titleTextStyle: TextStyle(
               //   fontSize: MediaQuery.of(context).size.height / 18))),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: IntroductionScreen(
          globalBackgroundColor: Colors.white,
          dotsDecorator: DotsDecorator(
              size: const Size.square(10.0),
              activeSize: const Size(20.0, 10.0),
              color: Colors.black26,
              spacing: const EdgeInsets.symmetric(horizontal: 3.0),
              activeShape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25.0))),
          pages: getPages(context),
          done: Text(
            "Terminar",
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
          ),
          onDone: () {
            Navigator.pushReplacementNamed(context, 'register2.0');
          },
          showSkipButton: true,
          skip: const Icon(Icons.skip_next),
        ),
      ),
    );
  }
}
