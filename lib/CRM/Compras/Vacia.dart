import 'package:Balewaterproject/Menus/BannerBaleWater.dart';
import 'package:Balewaterproject/Menus/MenuCompras.dart';
import 'package:Balewaterproject/model/RecordProveidor.dart';
import 'package:Balewaterproject/util.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../BackGroundPantalla.dart';
import '../../Datos_Firebase.dart';

String producte;
int unitats;
class Vacia extends StatelessWidget {
  String nomProducte;
  int unitatTextField;
  Vacia({ Key key,
    this.nomProducte,
    this.unitatTextField}):super (key: key);

  @override
  Widget build(BuildContext context) {
    producte = nomProducte;
    unitats = unitatTextField;
    print( "unitats : ........................................................................" + unitats.toString());
    return Scaffold(
      body: BackGroundPantalla(
          child: Column(
            children: <Widget>[
              BannerBaleWater(texte: "Comandes a servir",),
              Expanded(child:
              _buildBody(context),
              ),
              _comandaEnviada(context),
            ],
          )
      ),
    );
  }
}

Widget _buildBody(BuildContext context) {
  return StreamBuilder<QuerySnapshot>(
    stream: Firestore.instance.collection("comandaProveidor").snapshots(),
    builder: (context, snapshot) {
      if (!snapshot.hasData) return LinearProgressIndicator();
      if (snapshot.data.documents.isEmpty)   {
        Firestore.instance.collection("comandaProveidor").document("0")
            .setData({
          'idComanda':  0,
          'nomProducte': 's',
          'idProducte': 's',
          'nomProveidor':  's',
          'idProveidor':  's',
          'dataComanda':  's',
          'dataEntrega':  's',
          'unitats': unitats,
          'preuUnitat':  1,
          'preuTotal':  1 })
            .then((_) {

        }).catchError((onError) {
          print(onError);
        });
      }

      return _buildList(context, snapshot.data.documents );
    },
  );
}

Widget _buildList(BuildContext context, List<DocumentSnapshot> snapshot) {
  return
    ListView(
      padding: const EdgeInsets.only(top: 30.0),
      children: snapshot.map((data) =>
          _buildListItem(context, data)).toList(),
    );
}

Widget _buildListItem(BuildContext context, DocumentSnapshot datos) {
  final record = RecordProveidor.fromSnapshot(datos);



      _writeComandaFirebase(context,record,  datos.data.length);


      return Text("JOroba quq joroba  " + record.nomProducte);

}
Widget _writeComandaFirebase(BuildContext context, RecordProveidor record, int tamany ) {
  print("..............................................................................111.a.............  " + producte.toString());
  //if ( ah == tamany) {
    Firestore.instance.collection("comandaProveidor").document(tamany.toString())
        .setData({
      'idComanda': tamany,
      'nomProducte': producte,
      'idProducte': 's',
      'nomProveidor': 's',
      'idProveidor': 's',
      'dataComanda': 's',
      'dataEntrega': 's',
      'unitats': unitats,
      'preuUnitat': 1000,
      'preuTotal': (record.preuUnitat)* unitats})
        .then((_) {

    }).catchError((onError) {
      print(onError);
    });
  //}
}
AlertDialog _comandaEnviada(BuildContext context) {
  return AlertDialog(

    title: Text('Comande enviada ' ),
    content: SingleChildScrollView(

      child:
      Text('Rebràs confirmació del proveidor ' ),
      // Text('You\’re like me. I’m never satisfied.'),

    ),
    actions: <Widget>[
      FlatButton(
        child: Text('Ok.'),
        onPressed: () {
          pushPage(context, MenuCompras());
        },
      ),
    ],
  );
}