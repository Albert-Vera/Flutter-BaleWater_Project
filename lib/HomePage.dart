import 'package:Balewaterproject/BackGroundPantalla.dart';
import 'package:Balewaterproject/CRM/Ventas/ComandesClient.dart';
import 'package:Balewaterproject/LoadDataFromFirestone.dart';
import 'package:Balewaterproject/Menus/BannerBaleWater.dart';
import 'package:Balewaterproject/Menus/MenuCompras.dart';
import 'package:Balewaterproject/Menus/MenuFactures.dart';
import 'package:Balewaterproject/Menus/MenuInvetari.dart';
import 'package:Balewaterproject/Menus/MenuItem.dart';
import 'package:Balewaterproject/Menus/MenuPrincipal.dart';
import 'package:Balewaterproject/Menus/MenuVendes.dart';
import 'package:Balewaterproject/MyApp.dart';
import 'package:Balewaterproject/NavegadorBarraInferior.dart';
import 'package:Balewaterproject/medio_basura/Home.dart';
import 'package:Balewaterproject/util.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:meta/meta.dart';
import 'dart:convert' show base64;

import 'CRM/Ventas/Clients.dart';

final colorBackground = const Color(0xFFF3F4F7);
final colorPrimary = const Color(0xFF35465B);
final colorAccent = const Color(0xFF7576FD);
final colorGrey = const Color(0xFFA5ADB7);

class HomePage extends StatefulWidget {
  @override
  HomePageState createState() =>  HomePageState();
}

class HomePageState extends State<HomePage> {
  final _navigatorKey =  GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Bale Water',
      theme:  ThemeData(
        brightness: Brightness.light,
        backgroundColor: colorBackground,
        primaryColor: colorPrimary,
        accentColor: colorAccent,
        splashColor: colorAccent,
        disabledColor: colorGrey,
      ),
      home:  Column(
        children: <Widget>[
          Expanded(
            child: new Navigator(
              key: _navigatorKey,
              onGenerateRoute: _onGenerateRoute,
            ),
          ),
          NavegadorBarraInferior(navCallback: (String namedRoute) {
            print("Navigating to $namedRoute");
            _navigatorKey.currentState.pushReplacementNamed(namedRoute);
          }),
        ],
      ),
    );
  }
// Barra menu inferior
  Route<dynamic> _onGenerateRoute(RouteSettings settings) {
    Widget child;
    if (settings.name == '/') {
      child =  ScreenHome();
    }
    else if (settings.name == '/vendes') {
      child =  MenuVendes();
    }
    else if (settings.name == '/compres') {
      child =  MenuCompras();
    }
    else if (settings.name == '/factures') {
      child =  MenuFactures();
    }
    else if (settings.name == '/inventari') {
      child =  MenuInventari();
    }
    if (child != null) {
      return  MaterialPageRoute(builder: (c) => child);
    }
    return null;
  }
}

class ScreenHome extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return

      Scaffold(
          body: BackGroundPantalla(
            child: Column(
              children: <Widget>[
                BannerBaleWater(),
                graella(context)
              ],
            ),
          )
      );
  }
}
Widget graella(BuildContext context) {
  return Container(
      margin: EdgeInsets.only(
          top: 100.0,
          left: 20.0),
      height: 300,
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              MenuItem(page: ComandesClient(), icon: Icons.add_shopping_cart, text: "Comandes a servir", width: 100 ),
              MenuItem(page: MenuVendes(), icon: Icons.transit_enterexit, text: "Comandes a recollir", width: 100),
            ],
          ),
        ],
      )
  );
}
