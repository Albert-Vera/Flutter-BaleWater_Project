import 'package:Balewaterproject/BackGroundPantalla.dart';
import 'package:Balewaterproject/Datos_Firebase.dart';
import 'package:Balewaterproject/Menus/BannerBaleWater.dart';
import 'package:Balewaterproject/medio_basura/ReEscriureFire.dart';
import 'package:Balewaterproject/model/Record.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../util.dart';
import 'DadesClient.dart';

class ComandesAServir extends StatefulWidget{
  String coleccion;

  ComandesAServir( {
    Key key,
    this.coleccion}): super(key: key);
  @override
  _ComandesAServirState createState() => _ComandesAServirState();
}
class _ComandesAServirState extends State<ComandesAServir> {
  @override
  Widget build(BuildContext context) {

   //ReEscriureFire().escriure();

    return Scaffold(
      body: BackGroundPantalla(
          child: Column(
            children: <Widget>[
              BannerBaleWater(texte: "Comandes a servir",),
              Expanded(child:
                buildBody(context, "comandesAservir")
              ),
            ],
          )
      ),
    );
  }
}
