import 'package:Balewaterproject/Menus/BannerBaleWater.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../BackGroundPantalla.dart';

class ComandesProveidor extends StatelessWidget{
  @override
  Widget build(BuildContext context) {

    final screenSize = MediaQuery.of(context).size;
    var a = -1;
    return Scaffold(
      body: BackGroundPantalla(
        child:  Column(
          children: <Widget>[
            BannerBaleWater(texte: "Tete",),
            Text("Prueba counter"),
            StreamBuilder(
              stream: Firestore.instance.collection("productosZZZ").document("productid").snapshots(),
              builder: (context, snapshot){
                if(!snapshot.hasData){
                  return Text("Loading");
                }
                return Text("Stock: " + snapshot.data['stock'].toString());
              },
            ),
            RaisedButton(
              onPressed: (){
                Firestore.instance.collection("productosZZZ").document("productid").updateData({"stock" : FieldValue.increment(a)});
              },
              child: Text("Suma 1"),
            )
          ],
        ),
      ),
    );
  }

}