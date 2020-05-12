import 'package:Balewaterproject/Mostrar/ComandesAServir.dart';
import 'package:Balewaterproject/util.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'Mostrar/ComandesARecollir.dart';
import 'Mostrar/DadesClient.dart';
import 'model/Record.dart';




  int modificarDatos(){
    Firestore.instance.collection("castle").document("1").updateData({"enAlmacen" : FieldValue.increment(-1)});
    return 0;
  }


Widget buildBody(BuildContext context, String coleccio) {
  return StreamBuilder<QuerySnapshot>(
    stream: Firestore.instance.collection(coleccio).snapshots(),
    builder: (context, snapshot) {
      if (!snapshot.hasData) return LinearProgressIndicator();
      if (snapshot.data.documents.isEmpty)  return comanServidasVacio(context);
      else return buildList(context, snapshot.data.documents, coleccio );
    },
  );
}

Widget buildList(BuildContext context, List<DocumentSnapshot> snapshot, String coleccio) {
  return
    ListView(
      padding: const EdgeInsets.only(top: 30.0),
      children: snapshot.map((data) =>
          buildListItem(context, data, coleccio)).toList(),
    );
}

Widget buildListItem(BuildContext context, DocumentSnapshot datos, String coleccio) {
  final record = Record.fromSnapshot(datos);
  return StreamBuilder<QuerySnapshot>(
    stream: Firestore.instance.collection("comanda").snapshots(),
    builder: (context, snapshot) {

      if (!snapshot.hasData) return LinearProgressIndicator();
      if (record.servida == false) {
        deleteFirebase(context, record, "perRecollir");
        writeFirebase(context, record, "comanda");
        writeFirebase(context, record, "comandesAservir");
        return impresioDades(context, record, coleccio);
      } else if (record.recollida == false) {
        deleteFirebase(context, record, "comandesAservir");
        writeFirebase(context, record, "comanda");
        writeFirebase(context, record, "perRecollir");
        return impresioDades(context, record, coleccio);
      } else {
        deleteFirebase(context, record, "perRecollir");
        return impresioDades(context, record, coleccio);
      }
    },
  );
}

void deleteFirebase(BuildContext context, Record record, String coleccion) {
  Firestore.instance.collection(coleccion).document(record.id.toString())
      .delete();
}

void writeFirebase(BuildContext context, Record record, String coleccion) {
  String a = record.dat_servei.substring(3,5);
  String b = record.dat_servei.substring(0,2);
  Firestore.instance.collection(coleccion).document(record.id.toString())
      .setData({
    'id': record.id,
    'nom': record.nom,
    'cognoms': record.cognoms,
    'data_servei': record.dat_servei,
    'data_comanda': record.dat_comanda,
    'horas': record.horas,
    'product_id': record.product_id,
    'recollida': record.recollida,
    'servida': record.servida,
    'importComanda': record.importComanda,
    'productNom': record.product_Nom,
    'adreca': record.adreca,
    'localitat': record.localitat,
    'cp': record.cp,
    'mes' : int.parse(a),
    'dia' : int.parse(b)});
}
Widget stockProducte(BuildContext context, Record record) {
  return StreamBuilder(
      stream: Firestore.instance.collection("productes").document(
          record.product_id).snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return Text("Loading");
        return Container(
          width: double.maxFinite,
          child: Padding(
            padding: const EdgeInsets.only(top: 14, right: 5.0),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Text("Disponibles:" ,
                      textAlign: TextAlign.start),
                ),
                Expanded(
                  child: Text(snapshot.data['enAlmacen'].toString(),
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                          fontSize: 14.0
                      ),
                      textAlign: TextAlign.end),

                ),
              ],
            ),
          ),
        );
      });
}
Widget impresioDades(BuildContext context, Record record, String coleccio) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 8.0),
    height: 120.0,
    child: Container(
      decoration: new BoxDecoration(boxShadow: [
        new BoxShadow(
          color: Colors.blueAccent.withOpacity(0.2),
          blurRadius: 2.0,
        ),
      ]),
      child: Card(
          child: Row(
            children: <Widget>[
              Container(
                width: 155.0,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      lineaCard( "Comanda:" , "0" + record.id.toString()),
                      lineaCard("Id producte: " , record.product_id ),
                      boton(context, record, coleccio)
                    ]
                ),
              ),
              VerticalDivider(
                width: 5.0,
              ),
              Container(
                width: 160.0,
                child: Column(

                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      lineaCard( "Servei:" , record.dat_servei),
                      lineaCard("Lloguer: " , record.horas.toString() + " h."),
                    ]
                ),
              )
            ],
          )
      ),
    ),
  );
}

Widget lineaCard( String text_1, String text_2){
  // final screenSize = MediaQuery.of(context).size;
  return  Container(
    width: double.maxFinite,
    //color: Colors.tealAccent,
    child: Padding(
      padding: const EdgeInsets.only(top: 15.0),
      child: Row(

        children: <Widget>[
          Expanded(
            child: Text(text_1,
                textAlign: TextAlign.start),
          ),
          Expanded(
            child: Text(text_2,
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                    fontSize: 14.0
                ),
                textAlign: TextAlign.end),
          )
        ],
      ),
    ),
  );
}
AlertDialog comanServidasVacio(BuildContext context) {
  return AlertDialog(
    title: Text('Comandes a Recollir'),
    content: SingleChildScrollView(
      child:
      Text('No hi ha comandes per recollir'),
      // Text('You\’re like me. I’m never satisfied.'),

    ),
    actions: <Widget>[
      FlatButton(
        child: Text('Ok.'),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
    ],
  );
}
Widget boton(BuildContext context, Record record, String coleccio){
  return Container(
    margin: EdgeInsets.only(top: 10.0),
    height: 32,
    child: RaisedButton(
      onPressed: () {
        //TODO cal posar parametres per recollida i servida, ruta,
        if ( coleccio == "perRecollir")
        pushPage(context, DadesClient(record: record, texte: "RECOLLIDA", texte2: "recollit", ruta: ComandesARecollir(),));
        else pushPage(context, DadesClient(record: record, texte: "SERVIDA", texte2: "servit", ruta: ComandesAServir(),));
      },
      textColor: Colors.white,
      padding: const EdgeInsets.all(0.0),
      child: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: <Color>[
              Color(0xFF0D47A1),
              Color(0xFF1976D2),
              Color(0xFF42A5F5),
            ],
          ),
        ),
        padding: const EdgeInsets.all(10.0),
        child: const Text(
            'Més dades',
            style: TextStyle(fontSize: 13)
        ),
      ),
    ),
  );
}
