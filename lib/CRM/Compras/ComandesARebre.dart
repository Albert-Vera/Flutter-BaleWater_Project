import 'package:Balewaterproject/Menus/BannerBaleWater.dart';
import 'package:flutter/material.dart';

import '../../BackGroundPantalla.dart';
class ComandesARebre extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
      body: BackGroundPantalla(
        child:  Column(
          children: <Widget>[
            BannerBaleWater(texte: "Comandes pendents"),

          ],
        ),
      ),
    );
  }
}
//TODO aqui un cop feta una comanda a proveidor, pasa aqui