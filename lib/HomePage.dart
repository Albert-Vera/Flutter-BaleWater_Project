import 'package:Balewaterproject/BackGroundPantalla.dart';
import 'package:Balewaterproject/LoadDataFromFirestone.dart';
import 'package:Balewaterproject/Menus/MenuCompras.dart';
import 'package:Balewaterproject/Menus/MenuFactures.dart';
import 'package:Balewaterproject/Menus/MenuInvetari.dart';
import 'package:Balewaterproject/Menus/MenuPrincipal.dart';
import 'package:Balewaterproject/Menus/MenuVendes.dart';
import 'package:Balewaterproject/NavegadorBoton.dart';
import 'package:Balewaterproject/medio_basura/Home.dart';
import 'package:Balewaterproject/util.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:meta/meta.dart';
import 'dart:convert' show base64;

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
           NavegadorBoton(navCallback: (String namedRoute) {
            print("Navigating to $namedRoute");
            _navigatorKey.currentState.pushReplacementNamed(namedRoute);
          }),
        ],
      ),
    );
  }

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
          body: Stack(
            children: <Widget>[
              Container(
                  margin: EdgeInsets.only(
                      top: 30.0,
                      right: 15.0,
                      left: 15.0
                  ),
                  height: 600.0,
                  width: 370.0,
                  decoration: new BoxDecoration(
                      border: Border.all(),
                      color: Colors.white,
                      boxShadow: [
                        new BoxShadow(
                            color: Color(0xFFc5cdd9),

                            offset: new Offset(10.0, 10.0),
                            blurRadius: 10.0
                        )
                      ],
                      borderRadius: new BorderRadius.circular(30.0),

                      gradient: new LinearGradient(
                          colors: [
                            Color(0xFFF3F4F7),
                            Color(0xFF281236)
                          ],
                          begin: const FractionalOffset(1.0, 0.1),
                          end: const FractionalOffset(1.0, 1.0)
                      )
                  ),
                  child: Column(
                    children: <Widget>[
                      bannerLogin(),
                      graella(context)
                    ],
                  )

              )

            ],

          )
      );
  }
  }
  Widget bannerLogin() {
    return Container(
      margin: EdgeInsets.only(
          top: 35.0,
          left: 40.0,
          right: 40.0
      ),
      child:  Image.asset("image/banner.png"),
    );
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
              GestureDetector(

                onTap: () => pushPage(context, LoadDataFromFirestore()),

                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0)
                  ),
                  elevation: 17,

                  child: Column(
                    children: <Widget>[
                      Image.asset("image/carro.jpeg",
                          height: 50.0,
                          width: 50.0),
                      Container(
                        width: 100.0,
                        padding: const EdgeInsets.only(
                            top: 10.0),
                        child: Text('Comandes a servir',
                          style: TextStyle(fontSize: 18.0,
                              color: Colors.black ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              GestureDetector(
                onTap: () => pushPage(context, MenuVendes()),
                child: Card(
                  elevation: 57,
                  child: Column(
                    children: <Widget>[
                      Icon(
                        Icons.transit_enterexit,
                        size: 45.0,
                      ),
                      Container(
                        width: 100.0,
                        padding: const EdgeInsets.only(


                            top: 10.0
                        ),

                        child: Text('Comandes a recollir',
                          style: TextStyle(fontSize: 18.0,
                              color: Colors.black ),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
//          Row(
//            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//            children: <Widget>[
//              GestureDetector(
//
//                onTap: () => pushPage(context, MenuVendes()),
//
//                child: Card(
//                  elevation: 57,
//
//                  child: Column(
//                    children: <Widget>[
//                      Icon(
//                        Icons.add_shopping_cart,
//                        size: 45.0,
//                      ),
//                      Container(
//                        width: 100.0,
//                        padding: const EdgeInsets.only(
//                            top: 10.0),
//
//                        child: Text('Comandes a servir',
//                          style: TextStyle(fontSize: 18.0,
//                              color: Colors.black ),
//                        ),
//                      ),
//                    ],
//                  ),
//                ),
//              ),
//
//              GestureDetector(
//                onTap: () => pushPage(context, MenuVendes()),
//                child: Card(
//                  elevation: 57,
//                  child: Column(
//                    children: <Widget>[
//                      Icon(
//                        Icons.transit_enterexit,
//                        size: 45.0,
//                      ),
//                      Container(
//                        width: 100.0,
//                        padding: const EdgeInsets.only(
//                            top: 10.0
//                        ),
//                        child: Text('Comandes a recollir',
//                          style: TextStyle(fontSize: 18.0,
//                              color: Colors.black ),
//                        ),
//                      ),
//                    ],
//                  ),
//                ),
//              )
//            ],
//          ),
        ],
      )


    );


}

class OtherScreen extends StatelessWidget {
  final String name;

  OtherScreen(this.name);

  @override
  Widget build(BuildContext context) {
    return  ScreenBackground(
      child:  Center(
        child:  Text( this.name, style: Theme
            .of(context)
            .textTheme

            .display3),

      ),

    );
  }
}


class ScreenBackground extends StatelessWidget {
  final Widget child;

  ScreenBackground({@required this.child});

  @override
  Widget build(BuildContext context) {
    return new Material(
      color: colorBackground,
      child:  DefaultTextStyle(
        style:  TextStyle(
          color: colorPrimary,
          fontFamily: 'Roboto',
          fontSize: 16.0,
        ),
        child: child,
      ),
    );
  }
}
