import 'package:Balewaterproject/BackGroundPantalla.dart';
import 'package:Balewaterproject/CRM/Compras/ComandesARebre.dart';
import 'package:Balewaterproject/CRM/Compras/ComandesProveidor.dart';
import 'package:Balewaterproject/CRM/Ventas/Balance.dart';
import 'package:Balewaterproject/CRM/Compras/ContacteProveidor.dart';
import 'package:Balewaterproject/CRM/Compras/Proveidors.dart';
import 'package:Balewaterproject/CRM/Ventas/Clients.dart';
import 'package:Balewaterproject/CRM/Ventas/Productes.dart';
import 'package:Balewaterproject/Menus/BannerBaleWater.dart';
import 'package:Balewaterproject/Menus/MenuItem.dart';
import 'package:Balewaterproject/Providers/StockModel.dart';
import 'package:Balewaterproject/CRM/Compras/LlistarProduct.dart';
import 'package:flutter/material.dart';

import 'MenuVendes.dart';

class MenuCompras extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BackGroundPantalla(
        child:  Column(
          children: <Widget>[
            BannerBaleWater(texte: "Compres"),
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
                MenuItem(page: Proveidors(), text: "Proveidors", width: 130, image: "image/providers.jpeg" ),
                MenuItem(page: ComandesProveidor(), text: "Comandes", width: 130, image: "image/recollida2.jpeg"),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                MenuItem(page: Productes(), text: "Productes", width: 130, image: "image/productes.jpeg"),
                MenuItem(page: ComandesARebre(), text: "Prod a rebre", width: 130, image: "image/recollida2.jpeg"),
              ],
            ),

             MenuItem(page: ContacteProveidor(), text: "Contacte", width: 150, image: "image/recollida2.jpeg"),

          ],
        )
    );
  }
}