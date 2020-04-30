import 'package:Balewaterproject/BackGroundPantalla.dart';
import 'package:Balewaterproject/CRM/Ventas/Clients.dart';
import 'package:Balewaterproject/CRM/Ventas/ComandesClient.dart';
import 'package:Balewaterproject/Menus/BannerBaleWater.dart';
import 'package:Balewaterproject/Menus/MenuItem.dart';
import 'package:Balewaterproject/Mostrar/ComandesARecollir.dart';
import 'package:Balewaterproject/Mostrar/Productes.dart';
import 'package:flutter/material.dart';

class MenuVendes extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BackGroundPantalla(
        child:  Column(
          children: <Widget>[
            BannerBaleWater(texte: "Vendes"),
            graella(context)
          ],
        ),
      ),
    );
  }

  Widget graella(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(top: 50.0, left: 10.0),
        height: 300,
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                MenuItem(page: Clients(), text: "Clients", width: 130, image: "image/clients.jpeg" ),
                MenuItem(page: ComandesClient(), text: "Comandes", width: 130, image: "image/comandes.png"),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                MenuItem(page: Productes(), text: "Productes", width: 130, image: "image/productes.jpeg"),
                MenuItem(page: ComandesARecollir(coleccion: "perRecollir"), text: "Com servides", width: 130, image: "image/servides.png"),
              ],
            ),
          ],
        )
    );
  }
}