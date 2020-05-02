import 'package:Balewaterproject/BackGroundPantalla.dart';
import 'package:Balewaterproject/CRM/Ventas/Balance2.dart';
import 'package:Balewaterproject/Menus/BannerBaleWater.dart';
import 'package:flutter/material.dart';

class Balance extends StatelessWidget{
  @override
  Widget build(BuildContext context) {

    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
      body: BackGroundPantalla(
        child:  Column(
          children: <Widget>[
            BannerBaleWater(texte: "Productes Proveidors"),
            Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Balance2()),
                )
          ],
        ),
      ),
    );

  }
}
