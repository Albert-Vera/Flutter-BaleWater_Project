import 'package:Balewaterproject/BackGroundPantalla.dart';
import 'package:Balewaterproject/Menus/BannerBaleWater.dart';
import 'package:Balewaterproject/Mostrar/MostrarComandes1.dart';
import 'package:Balewaterproject/Mostrar/proba.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';

class Experimento extends StatefulWidget{
  @override
  _ExperimentoState createState() => _ExperimentoState();
}
class _ExperimentoState extends State<Experimento> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BackGroundPantalla(
          child: Column(
            children: <Widget>[
              BannerBaleWater(),
              Expanded(child:_buildBody(context, "comanda")),
             // Expanded(child:_buildBody(context, "comandesAservir")),

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

      return _buildList(context, snapshot.data.documents, coleccio);
    },
  );
}
Widget _buildList(BuildContext context, List<DocumentSnapshot> snapshot, String coleccio) {
  return
  ListView(
    padding: const EdgeInsets.only(top: 30.0),
    children: snapshot.map((data) => _buildListItem(context, data, coleccio)).toList(),
  );
}
Widget _buildListItem(BuildContext context, DocumentSnapshot data, String coleccio) {
  final record = Record.fromSnapshot(data);

  return StreamBuilder<QuerySnapshot>(
    stream: Firestore.instance.collection(coleccio).snapshots(),
    builder: (context, snapshot) {
      if (!snapshot.hasData) return LinearProgressIndicator();
      if (record.servida == false){
        _deleteFirebase(context, record, "perRecollir");
        _writeFirebase(context, record, "comandesAservir");
        return _mostraComandes(context, record);
      }else
      if (record.recollida == false){
        _deleteFirebase(context, record, "comandesAservir");
        _writeFirebase(context, record, "perRecollir");
       return _mostraComandes(context, record);
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
    'cognoms': record.cognoms});
}
// Un pedido servido se pasa a estado servido
void _cambiarEstatComanda(BuildContext context, Record record){
  Firestore.instance.collection("comanda").document("0" + record.id.toString())
      .updateData({
    'servida': record.servida = true,
  });
}
Widget _mostraComandes(BuildContext context, Record record ){
  return   FlipCard(
      onFlip:(){
        // de momento ninguna condición
      },
      direction: FlipDirection.VERTICAL,
      front: _impresioDades(context, record),
      back: _alertDialog(context, record)

  );

}
Widget _impresioDades(BuildContext context, Record record,  ) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 10.0),
    height: 200.0,
    child: Card(
      child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            _lineaCard( "id Comande: 0" +record.id.toString(), record.nom + "   " +
                record.cognoms),
            Divider(),
            _lineaCard("Data Comanda: " +
                record.nom, "Data Servei: " + record.nom+ "\n"),
            _lineaCard("Id producte: P1" , "Producte: " +
                record.nom+ "\n"),
            _lineaCard("Lloguer:  4 h." , "Localitat: " +
                record.cognoms)
          ]
      ),
    ),
  );
}
AlertDialog _alertDialog(BuildContext context, Record record, ) {
  //GlobalKey<FlipCardState> thisCard = ;
  return AlertDialog(
    title: Text('El producte ha sigut servit ?'),
    content: SingleChildScrollView(
      child: ListBody(
        children: <Widget>[
          Text('El producte has donará per entregat.'),
          // Text('You\’re like me. I’m never satisfied.'),
        ],
      ),
    ),
    actions: <Widget>[
      FlatButton(
        child: Text('Ok.'),
        onPressed: () {
          _cambiarEstatComanda(context, record);
          // _buildBody(context);
          //thisCard.currentState.toggleCard();
        },
      ),
      FlatButton(
        child: Text('Cancel.'),
        //onPressed: () {
        // Navigator.of(context).initState();

        //},
      ),
    ],
  );
}
Widget _lineaCard( String text_1, String text_2){
  // final screenSize = MediaQuery.of(context).size;
  return  Container(
    width: 250.0,
    //color: Colors.tealAccent,
    child: Row(
      children: <Widget>[
        Expanded(
          child: Text(text_1,
              textAlign: TextAlign.start),
        ),
        Expanded(
          child: Text(text_2,
              textAlign: TextAlign.start),
        )
      ],
    ),
  );
}
class Record {
  final String nom, cognoms;
  final int id;
  bool recollida, servida;
  final DocumentReference reference;

  Record.fromMap(Map<String, dynamic> map, {this.reference})
      : assert(map['id'] != null),
        assert(map['nom'] != null),
        assert(map['cognoms'] != null),
//        assert(map['recollida'] != null),
//        assert(map['servida'] != null),
        id = map['id'],
        nom = map['nom'],
        cognoms = map['cognoms'],
        recollida = map['recollida'],
        servida = map['servida'];

  Record.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data, reference: snapshot.reference);

  @override
  String toString() => "Record<$nom:$cognoms>";
}