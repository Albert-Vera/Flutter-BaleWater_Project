import 'package:Balewaterproject/BackGroundPantalla.dart';
import 'package:Balewaterproject/Menus/BannerBaleWater.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';

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
void _deleteFirebase(BuildContext context, Record record, String coleccion){
  Firestore.instance.collection(coleccion).document("0" + record.id.toString())
      .delete();
}
void _writeFirebase(BuildContext context, Record record, String coleccion) {
  Firestore.instance.collection(coleccion).document("0" + record.id.toString())
      .setData({
    'id': record.id,
    'nom': record.nom,
    'cognoms': record.cognoms,
    'data_servei': record.dat_servei,
    'data_comanda': record.dat_comanda,
    'horas': record.horas,
    'product_id': record.product_id,
    'recollida': record.recollida,
    'servida': record.servida});
}
Widget _impresioDades(BuildContext context, Record record ) {

  return Container(

    margin: EdgeInsets.symmetric(vertical: 10.0),
    height: 200.0,
    child: Card(
      child: Row(
        children: <Widget>[
          Container(
            width: 155.0,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                _lineaCard( "Comanda:" , "0" + record.id.toString()),
                _lineaCard("Client: " , record.nom ),
                _lineaCard("Id producte: " , record.product_id ),
                _lineaCard("Lloguer: " , record.horas.toString() + " h.")
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
                  _lineaCard( "Data Servei" , record.dat_servei),
                  _lineaCard("Cognoms: " , record.cognoms),
                  _lineaCard("Data Comanda: " ,record.dat_comanda),
                  _lineaCard("Localitat: " , record.cognoms)
                ]
            ),
          )
        ],
      )
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
                    fontSize: 16.0
                  ),
                  textAlign: TextAlign.end),

          )
        ],
      ),
    ),
  );
}
class Record {
  final String nom, cognoms, product_id;
  String dat_servei, dat_comanda;
  final int id, horas;
  bool recollida, servida;
  final DocumentReference reference;

  Record.fromMap(Map<String, dynamic> map, {this.reference})
      : assert(map['id'] != null),
        assert(map['nom'] != null),
        assert(map['cognoms'] != null),
        assert(map['recollida'] != null),
        assert(map['servida'] != null),
        assert(map['data_servei'] != null),
        assert(map['data_comanda'] != null),
        assert(map['product_id'] != null),
        assert(map['horas'] != null),
        id = map['id'],
        nom = map['nom'],
        cognoms = map['cognoms'],
        recollida = map['recollida'],
        horas = map['horas'],
        product_id = map['product_id'],
        dat_servei = map['data_servei'],
        dat_comanda= map['data_comanda'],
        servida = map['servida'];

  Record.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data, reference: snapshot.reference);

  @override
  String toString() => "Record<$nom:$cognoms>";
}
