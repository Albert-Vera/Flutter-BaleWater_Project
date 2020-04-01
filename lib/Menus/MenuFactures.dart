import 'package:Balewaterproject/CRM/Ventas/ComandesClient.dart';
import 'package:Balewaterproject/LoadDataFromFirestone.dart';
import 'package:Balewaterproject/medio_basura/Home.dart';
import 'package:flutter/material.dart';

import '../util.dart';
import 'BannerBaleWater.dart';
import 'MenuVendes.dart';

class MenuFactures extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            margin:EdgeInsets.only(
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
                    begin: const FractionalOffset(1.0,0.1 ),
                    end: const FractionalOffset(1.0, 1)
                )
            ),
            child: Column(
              children: <Widget>[
                BannerBaleWater(),
                graella(context)
              ],
            ),
          )

        ],
      ),
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

                  onTap: () => pushPage(context, MenuVendes()),

                  child: Card(
                    elevation: 57,

                    child: Column(
                      children: <Widget>[
                        Icon(
                          Icons.add_shopping_cart,
                          size: 45.0,
                        ),
                        Container(
                          width: 100.0,
                          padding: const EdgeInsets.only(
                              top: 10.0),
//                      splashColor: Colors.blue.withAlpha(30),
//                      onTap: () {
//                        print('Card tapped.');
//                      },
                          child: Text('Clients',
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
//                      splashColor: Colors.blue.withAlpha(30),
//                      onTap: () {
//                        print('Card tapped.');
//                      },
                          child: Text('Proveidors',
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
            Row(

              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                GestureDetector(

                  onTap: () => pushPage(context, MenuVendes()),

                  child: Card(
                    elevation: 57,

                    child: Column(
                      children: <Widget>[
                        Icon(
                          Icons.add_shopping_cart,
                          size: 45.0,
                        ),
                        Container(
                          width: 150.0,
                          padding: const EdgeInsets.only(
                              top: 10.0),
//                      splashColor: Colors.blue.withAlpha(30),
//                      onTap: () {
//                        print('Card tapped.');
//                      },
                          child: Text('Pagaments',
                            style: TextStyle(fontSize: 18.0,
                                color: Colors.black ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

//                GestureDetector(
//                  onTap: () => pushPage(context, MenuVendes()),
//                  child: Card(
//                    elevation: 57,
//                    child: Column(
//                      children: <Widget>[
//                        Icon(
//                          Icons.transit_enterexit,
//                          size: 45.0,
//                        ),
//                        Container(
//                          width: 100.0,
//                          padding: const EdgeInsets.only(
//
//
//                              top: 10.0
//                          ),
////                      splashColor: Colors.blue.withAlpha(30),
////                      onTap: () {
////                        print('Card tapped.');
////                      },
//                          child: Text('Comandes servidas',
//                            style: TextStyle(fontSize: 18.0,
//                                color: Colors.black ),
//                          ),
//                        ),
//                      ],
//                    ),
//                  ),
//                )
    ],
            ),
          ],
        )


    );


  }
}