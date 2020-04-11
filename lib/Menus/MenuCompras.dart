import 'package:Balewaterproject/BackGroundPantalla.dart';
import 'package:Balewaterproject/CRM/Ventas/Clients.dart';
import 'package:Balewaterproject/Menus/BannerBaleWater.dart';
import 'package:Balewaterproject/Menus/MenuItem.dart';
import 'package:flutter/material.dart';

import 'MenuVendes.dart';

class MenuCompras extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BackGroundPantalla(
        child:  Column(
          children: <Widget>[
            BannerBaleWater(),
            Expanded(child: graella(context))
          ],
        ),
      ),
    );
  }

  Widget graella(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(top: 0.0, left: 20.0),
        height: 300,
        child: Column(
          children: <Widget>[

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                MenuItem(page: Clients(), text: "Proveidors", width: 130, image: "image/providers.jpeg" ),
                MenuItem(page: MenuVendes(), text: "Comandes", width: 130, image: "image/recollida2.jpeg"),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                MenuItem(page: MenuVendes(), text: "Productes", width: 130, image: "image/productes.jpeg"),
                MenuItem(page: MenuVendes(), text: "Prod a rebre", width: 130, image: "image/recollida2.jpeg"),
              ],
            ),

             MenuItem(page: MenuVendes(), text: "Prod a xxx", width: 150, image: "image/recollida2.jpeg"),

          ],
        )
    );
  }
}