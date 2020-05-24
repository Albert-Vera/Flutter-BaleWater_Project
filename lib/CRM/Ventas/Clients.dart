import 'package:Balewaterproject/BackGroundPantalla.dart';
import 'package:Balewaterproject/Menus/BannerBaleWater.dart';
import 'package:Balewaterproject/model/Record.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flip_card/flip_card.dart';

import '../../Datos_Firebase.dart';


class Clients extends StatefulWidget{
  @override
  _ClientsState createState() => _ClientsState();
}

class _ClientsState extends State<Clients> {
  @override
  Widget build(BuildContext context) {

    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      body: BackGroundPantalla(
          child: Column(
            children: <Widget>[
              BannerBaleWater(texte: "Llistat de clients",),
              Expanded(child:
              _buildBody(context, "comanda"),
              ),
            ],
          )
      ),
    );
  }

}
Widget _buildBody(BuildContext context, String coleccio) {
  return StreamBuilder<QuerySnapshot>(
    stream: Firestore.instance.collection(coleccio).snapshots(),
    builder: (context, snapshot) {
      if (!snapshot.hasData) return LinearProgressIndicator();

       return _buildList(context, snapshot.data.documents, coleccio );
    },
  );
}

Widget _buildList(BuildContext context, List<DocumentSnapshot> snapshot, String coleccio) {
  return
    ListView(
      padding: const EdgeInsets.only(top: 30.0),
      children: snapshot.map((data) =>
          _buildListItem(context, data, coleccio)).toList(),
    );
}
Future<DocumentSnapshot> busqueda (Record record) async {
  List<DocumentSnapshot> documentList = (await Firestore.instance
      .collection("clients")
      .where("nom", isEqualTo: record.nom)
      .where("cognoms", isEqualTo: record.cognoms)
      .getDocuments())
      .documents;
  print("dkalsdkla --------------------------------------------------  " + documentList.length.toString());
  return  documentList;
}

Widget _buildListItem(BuildContext context, DocumentSnapshot datos, String coleccio)  {
  final record = Record.fromSnapshot(datos);
  print("dkalsdkla -----------------------111111---------------------------  " + numeroRepetidos.toString());
      final  <Future> a =  busqueda(record); // si meto ASYNC el metodo no admite async

      if ( numeroRepetidos != null) {
        if (numeroRepetidos == 0) {
          _writeFirebase(context, record);
          return _mostrarDetall(context, record);
        } else {
          return Container();
        }
      }
      return Container();
}
Container _mostrarDetall(BuildContext context, Record record) {
  final screenSize = MediaQuery.of(context).size;
  return Container(
    margin: EdgeInsets.all(10.0),
    decoration: new BoxDecoration(boxShadow: [
      BoxShadow(
        color: Colors.blueAccent.withOpacity(0.2),
        blurRadius: 2.0,
      ),
    ],
        borderRadius: BorderRadius.circular(15.0)
    ),
    child: Card(
        child: Column(
          children: <Widget>[
            Container(
              width: screenSize.width,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    lineaCard( "Id Client:" , record.idClient.toString()),
                    lineaCard( "Nom :" , record.nom ),
                    lineaCard("Cognoms: " , record.cognoms ),
                    lineaCard( "email:" , record.email),
                    lineaCard( "Tel·lefon:" , record.telef ),
                    lineaCard( "adreça:" , record.adreca ),
                    lineaCard( "localitat:" , record.localitat ),
                    lineaCard( "Provincia:" , record.provincia ),
                    lineaCard( "Data registre:" , record.dat_comanda ),


//                    Row(
//                      children: <Widget>[
//                        _btnRetroceso(context, record ),
//                        if (texte != "") _boton(context, record),
//                      ],
//                    )
                  ]
              ),
            ),
          ],
        )
    ),
  );
}
void deleteFirebase(BuildContext context, Record record, String coleccion) {
  Firestore.instance.collection(coleccion).document(record.id.toString())
      .delete();
}

void _writeFirebase(BuildContext context, Record record  ) {
  StreamBuilder<QuerySnapshot>(
    stream: Firestore.instance
        .collection('client')
        .where("cognoms", isEqualTo: record.cognoms)
        .where("nom", isEqualTo: record.nom)
        .snapshots(),
    builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> data) {
      if (!data.hasData) {

        Firestore.instance.collection("client").document(record.id.toString())
            .setData({
          'idClient': record.idClient,
          'nom': record.nom,
          'cognoms': record.cognoms,
          'email': record.email,
          'provincia': record.provincia,
          'telf': record.telef,
          'data_comanda': record.dat_comanda,
          'adreca': record.adreca,
          'localitat': record.localitat,
          'cp': record.cp,})
            .then((_) {

        }).catchError((onError) {
          print(onError);
        });
      }
      return Center(
        child: CircularProgressIndicator(),
      );
    },
  );



}
