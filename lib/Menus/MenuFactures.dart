
import 'package:Balewaterproject/BackGroundPantalla.dart';
import 'package:Balewaterproject/CRM/Ventas/Clients.dart';
import 'package:Balewaterproject/CRM/Ventas/ComandesClient.dart';
import 'package:Balewaterproject/LoadDataFromFirestone.dart';
import 'package:Balewaterproject/medio_basura/Home.dart';
import 'package:flutter/material.dart';

import '../util.dart';
import 'BannerBaleWater.dart';
import 'MenuItem.dart';
import 'MenuVendes.dart';

class MenuFactures extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BackGroundPantalla(
        child:  Column(
          children: <Widget>[
            BannerBaleWater(),
            graella(context)
          ],
        ),
      ),
    );
  }

  Widget graella(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(top: 100.0, left: 20.0),
        height: 300,
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                MenuItem(page: Clients(), icon: Icons.add_shopping_cart, text: "Clients", width: 100 ),
                MenuItem(page: MenuVendes(), icon: Icons.transit_enterexit, text: "Proveidors", width: 100),
              ],
            ),
            MenuItem(page: MenuVendes(), icon: Icons.transit_enterexit, text: "Pagaments", width: 150),

          ],
        )
    );
  }
}