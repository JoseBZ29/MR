
import 'package:ecommerce/screens/QRpage.dart';
import 'package:ecommerce/screens/QRpageCotizacion.dart';
import 'package:ecommerce/screens/QRpageFinalizar.dart';
import 'package:ecommerce/screens/QRpageFinalizarCot.dart';
import 'package:ecommerce/screens/QRpageFinalizarPresupuesto.dart';
import 'package:ecommerce/screens/QRpagePresupuesto.dart';
import 'package:ecommerce/screens/aceptarCotizacionPage.dart';
import 'package:ecommerce/screens/ajustePresupuestoPage.dart';
import 'package:ecommerce/screens/ayuda_page.dart';
import 'package:ecommerce/screens/blanco.dart';
import 'package:ecommerce/screens/celular_page.dart';
import 'package:ecommerce/screens/chat.dart';
import 'package:ecommerce/screens/correo_page.dart';
import 'package:ecommerce/screens/detalleCotizacion1.dart';
import 'package:ecommerce/screens/detallesCotizaciones.dart';
import 'package:ecommerce/screens/esperaPage.dart';
import 'package:ecommerce/screens/esperaPresupuestpPage.dart';
import 'package:ecommerce/screens/fast_service_page.dart';
import 'package:ecommerce/screens/finalizarServicio.dart';
import 'package:ecommerce/screens/listaCat.dart';
import 'package:ecommerce/screens/listaMateriales.dart';
import 'package:ecommerce/screens/listaMaterialesCotizacion.dart';
import 'package:ecommerce/screens/login.dart';
import 'package:ecommerce/screens/login2.0.dart';
import 'package:ecommerce/screens/map_page.dart';
import 'package:ecommerce/screens/mapservice_page.dart';
import 'package:ecommerce/screens/micuenta_page.dart';
import 'package:ecommerce/screens/pago_page.dart';
import 'package:ecommerce/screens/password_page.dart';
import 'package:ecommerce/screens/quienesSomos_page.dart';
import 'package:ecommerce/screens/register_page2.0.dart';
import 'package:ecommerce/screens/registro_cel2.0.dart';
import 'package:ecommerce/screens/registro_completado.dart';
import 'package:ecommerce/screens/search_page.dart';
import 'package:ecommerce/screens/service_details_page.dart';
import 'package:ecommerce/screens/service_details_presupuesto_page.dart';
import 'package:ecommerce/screens/servicioEnCursoPage.dart';
import 'package:ecommerce/screens/servicioEnCursoPageCot.dart';
import 'package:ecommerce/screens/servicioEnCursoPagePresupuesto.dart';
import 'package:ecommerce/screens/validacion_cel.dart';
import 'package:ecommerce/widgets/webView_widget.dart';
import 'package:ecommerce/widgets/webView_widgetCotizacion.dart';
import 'package:ecommerce/widgets/webView_widgetPresupusto.dart';
import 'package:flutter/material.dart';

import '../bottom_navigation/search_tab.dart';
import '../screens/Stepper_Form_Page.dart';
import '../screens/Walkthrough_Page.dart';
import '../screens/home_page.dart';

Map<String, WidgetBuilder> getAplicationRoute() {
  return <String, WidgetBuilder>{
    'cuenta': (BuildContext context) => MiCuentaPage(),
    'pagos': (BuildContext context) => PagoPage(),
    'ayuda': (BuildContext context) => AyudaPage(),
    'quinesSomos': (BuildContext context) => QuienesSomosPage(),
    'home_page': (BuildContext context) => HomePage(),
    'GMap': (BuildContext context) => GMap(),
    'service_details': (BuildContext context) => ServiceDetails(),
    'WalkThrough': (BuildContext context) => WalkThrough(),
    'celular_page': (BuildContext context) => CelularPage(),
    'account_page': (BuildContext context) => AccountPage(),
    'mapa_curso': (BuildContext context) => MapaServicio(),
    'login': (BuildContext context) => LoginScreen(),
    'search_page': (BuildContext context) => SearchPage(),
    'fast_service_page': (BuildContext context) => HomeServiceDetails(),
    'web': (BuildContext context)=> GetCurrentURLWebView(),
    'searchTab' :(BuildContext context)=>SearchTab(),
    'register2.0' :(BuildContext context)=>Register20Page(),
    'registroCel2.0'  :(BuildContext context)=>RegistroCel2Page(),
    'validarCel2.0'   :(BuildContext context)=>ValidarCelPage(),
    'registroCompletado'    :(BuildContext context)=>RegistroCompletadoPage(),
    'login2.0'        :(BuildContext context)=>Login2Page(),
    'passwordPage'    :(BuildContext context)=>PasswordPage(),
    'correoPage'      :(BuildContext context)=>CorreoPage(),
    'listaCat'        :(BuildContext context)=>ListaCatPage(),
    'esperaPage'      :(BuildContext context)=>EsperaPage(),
    'qrPage'          :(BuildContext context)=>QRPage(),
    'servicioEnCurso'   :(BuildContext context)=>ServicioEnCursoPage(),
    'ajustePresupuesto'   :(BuildContext context)=> AjustePresupuestoPage(),
    'aceptarPresupuesto'    :(BuildContext context) =>AceptarCotizacionPage(),
    'finalizarServicio'     :(BuildContext context)=>FinalizarServicioPage(),
    'pagoPage'              :(BuildContext context)=>GetCurrentURLWebView(),
    'blanco'                :(BuildContext context)=>BlancoPage(),
    'servicePresupuesto'      :(BuildContext context)=>ServiceDetailsPresupuesto(),
    'esperaPresupuesto'       :(BuildContext context)=>EsperaPresupuestoPage(),
    'listaMateriales'         :(BuildContext context)=>ListaMaterialesPage(),
    'pagoPagePresupuesto'     :(BuildContext context)=>GetCurrentURLWebViewPresupuesto(),
    'qrPageFinalizar'         :(BuildContext context)=>QRPageFinalizar(),
    'detallesCotizacion'      :(BuildContext context)=>DetallesCotizacionesPage(),
    'detalleCotizacion'       :(BuildContext context)=>DetalleCotizacionPage(),
    'listaMaterialesCotizacion' :(BuildContext context)=>ListaMaterialesCotizacionPage(),
    'pagoCotizacion'            :(BuildContext context)=>PagoCotizacion(),
    'qrCotizacion'      :(BuildContext context)=>QRCotizacionPage(),
    'servicioEnCursoCot'    :(BuildContext context)=>ServicioEnCursoCotPage(),
    'qrPageFinalizarCot'      :(BuildContext context)=>QRPageFinalizarCot(),
    'qrPagePresupuesto'       :(BuildContext context)=>QRPagePresupuesto(),
    'servicioEnCursoPresupuesto'    :(BuildContext context)=>ServicioEnCursoPresupuestoPage(),
    'qrFinalizarPresupuesto'      :(BuildContext context)=>QRPageFinalizarPresupuesto()
    
  };
}
