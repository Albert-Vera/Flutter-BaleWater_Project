import 'package:Balewaterproject/Menus/BannerBaleWater.dart';
import 'package:Balewaterproject/Menus/MenuCompras.dart';
import 'package:flutter/material.dart';

import '../../BackGroundPantalla.dart';
import '../../util.dart';
class ComandesARebre extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
      body: BackGroundPantalla(
        child:  Column(
          children: <Widget>[
            BannerBaleWater(texte: "Comandes pendents"),
            _noComandes(context),
          ],
        ),
      ),
    );
  }
}
//TODO aqui un cop feta una comanda a proveidor, pasa aqui
//TODO fer document de firebase per comandes a rebre, comandes fetas

AlertDialog _noComandes(BuildContext context) {
  print( "...................................................................sss................");
  return AlertDialog(

    title: Text('Comandes a rebre ' ),
    content: SingleChildScrollView(

      child:
      Text('No hi ha comandes pendents ' ),
      // Text('You\’re like me. I’m never satisfied.'),

    ),
    actions: <Widget>[
      FlatButton(
        child: Text('Ok.'),
        onPressed: () {
          print( "...................................................................22222................");
          pushPage(context, MenuCompras());
        },
      ),
    ],
  );
}