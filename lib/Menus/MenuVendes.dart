import 'package:Balewaterproject/BackGroundPantalla.dart';
import 'package:Balewaterproject/CRM/Ventas/Clients.dart';
import 'package:Balewaterproject/Menus/BannerBaleWater.dart';
import 'package:Balewaterproject/Menus/MenuItem.dart';
import 'package:flutter/material.dart';

class MenuVendes extends StatelessWidget{
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
                MenuItem(page: Clients(), icon: Icons.add_shopping_cart, text: "Clients"),
                MenuItem(page: MenuVendes(), icon: Icons.transit_enterexit, text: "Comandes"),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                MenuItem(page: MenuVendes(), icon: Icons.add_shopping_cart, text: "Presupostus"),
                MenuItem(page: MenuVendes(), icon: Icons.transit_enterexit, text: "Comandes servides"),
              ],
            ),
          ],
        )
    );
  }
}