import 'package:Balewaterproject/BackGroundPantalla.dart';
import 'package:Balewaterproject/Menus/BannerBaleWater.dart';
import 'package:Balewaterproject/Menus/MenuFactures.dart';
import 'package:Balewaterproject/Menus/MenuItem.dart';
import 'package:flutter/material.dart';

class ProveidorsFac extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BackGroundPantalla(
        child:  Column(
          children: <Widget>[
            BannerBaleWater(texte: "Factures"),
            SizedBox(
              height: 50.0,
            ),
            enConstruccio(),
          ],
        ),
      ),
    );
  }
}
Widget enConstruccio(){
  return Card(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(15.0),
    ),
    child: Column(

        children: <Widget>[
          //const SectionTitle(title: 'Tappable'),
          SizedBox(
            height: 150,
          ),
          Image.asset("image/enconstruccio.jpeg",
              width: 200,
              height: 120,
              fit:BoxFit.fill ),

        ]
    ),
  );
}