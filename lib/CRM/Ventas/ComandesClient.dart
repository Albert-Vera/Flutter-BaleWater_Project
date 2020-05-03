import 'package:Balewaterproject/BackGroundPantalla.dart';
import 'package:Balewaterproject/Menus/BannerBaleWater.dart';
import 'package:Balewaterproject/Menus/HomePage.dart';
import 'package:Balewaterproject/Mostrar/DadesClient.dart';
import 'package:Balewaterproject/model/Record.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';

import '../../util.dart';

class ComandesClient extends StatefulWidget{
  @override
  _ComandesClientState createState() => _ComandesClientState();
}
class _ComandesClientState extends State<ComandesClient> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BackGroundPantalla(
          child: Column(
            children: <Widget>[
              BannerBaleWater(texte: "Comandes"),
              Expanded(child:
              _buildBody(context)
              ),
            ],
          )
      ),
    );
  }
}
Widget _buildBody(BuildContext context) {
  return StreamBuilder<QuerySnapshot>(
    stream: Firestore.instance.collection("comanda").snapshots(),
    builder: (context, snapshot) {
      if (!snapshot.hasData) return LinearProgressIndicator();
      return _buildList(context, snapshot.data.documents);
    },
  );
}
Widget _buildList(BuildContext context, List<DocumentSnapshot> snapshot ) {
  return
    ListView(
      padding: const EdgeInsets.only(top: 30.0),
      children: snapshot.map((data) => _buildListItem(context, data )).toList(),
    );
}
Widget _buildListItem(BuildContext context, DocumentSnapshot datos ) {
  final record = Record.fromSnapshot(datos);

  return StreamBuilder<QuerySnapshot>(
    stream: Firestore.instance.collection("comanda").snapshots(),
    builder: (context, snapshot) {
      if (!snapshot.hasData) return LinearProgressIndicator();
      if (record.servida == false){
        _deleteFirebase(context, record, "perRecollir");
        _writeFirebase(context, record, "comanda");
        _writeFirebase(context, record, "comandesAservir");
        return _impresioDades(context, record);
      }else
      if (record.recollida == false){
        _deleteFirebase(context, record, "comandesAservir");
        _writeFirebase(context, record, "comanda");
        _writeFirebase(context, record, "perRecollir");
        return _impresioDades(context, record);
      }else {
        _deleteFirebase(context, record, "perRecollir");
        return Container();
      }
    },
  );
}

//void _obtenirMes_Dia(Record record) {
//  Firestore.instance.collection("comanda").document("0" + record.id.toString())
//      .setData({
//    'mes': record.dat_servei.substring(3,5),
//    'dia': record.dat_servei.substring(0,2),
//  });
//}
void _deleteFirebase(BuildContext context, Record record, String coleccion){
  Firestore.instance.collection(coleccion).document(record.id.toString())
      .delete();
}
void _writeFirebase(BuildContext context, Record record, String coleccion) {
  String a = record.dat_servei.substring(3,5);
  String b = record.dat_servei.substring(0,2);
  Firestore.instance.collection(coleccion).document( record.id.toString())
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
Widget _impresioDades(BuildContext context, Record record ) {

  return Container(

    margin: EdgeInsets.symmetric(vertical: 10.0),
    height: 120.0,
    child: Container(
      decoration: new BoxDecoration(boxShadow: [
        new BoxShadow(
          color: Colors.blueAccent.withOpacity(0.2),
          blurRadius: 5.0,
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
                      _lineaCard( "Comanda:" , "0" + record.id.toString()),
                      _lineaCard("Id producte: " , record.product_id ),
                      _botonVerClient(context, record)
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
                      _lineaCard( "Servei:" , record.dat_servei),
                      _lineaCard("Lloguer: " , record.horas.toString() + " h."),
                    ]
                ),
              )
            ],
          )
      ),
    ),
  );

}

Widget _botonVerClient(BuildContext context, Record record) {
  return Padding(
    padding: const EdgeInsets.only(top: 10.0),
    child: Container(
      width: 120.0,
      color: Colors.tealAccent,
      child: GestureDetector(
        onTap: ()=> pushPage(context, DadesClient(record: record, texte: "", texte2: "", ruta: ComandesClient(),)),
        child: Text("Més detalls",
          style: TextStyle(
              color: Colors.blueAccent,
              fontWeight: FontWeight.w500,
              fontSize: 20.0
          ),
        ),
      ),
    ),
  );
}
Widget _lineaCard( String text_1, String text_2){
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

