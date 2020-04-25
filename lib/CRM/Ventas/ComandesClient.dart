import 'package:Balewaterproject/BackGroundPantalla.dart';
import 'package:Balewaterproject/Menus/BannerBaleWater.dart';
import 'package:Balewaterproject/Mostrar/MostrarComandes1.dart';
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
    return _buildBody(context);

//    return Scaffold(
//      body: BackGroundPantalla(

//            child: Column(
//            children: <Widget>[
//              BannerBaleWater(),
    // QUISIERA aqui un DRAGGAbleScrollableSheet
//              _buildBody(context)
//            ],
//          )

//      ),
//    );
  }
}


Widget _buildBody(BuildContext context) {
  return StreamBuilder<QuerySnapshot>(
    stream: Firestore.instance.collection('comanda').snapshots(),
    builder: (context, snapshot) {
      if (!snapshot.hasData) return LinearProgressIndicator();

      return _buildList(context, snapshot.data.documents);
    },
  );
}


Widget _buildList(BuildContext context, List<DocumentSnapshot> snapshot) {
  return ListView(
    padding: const EdgeInsets.only(top: 30.0),
    children: snapshot.map((data) => _buildListItem(context, data)).toList(),
  );
}
Widget _buildListItem(BuildContext context, DocumentSnapshot data) {
  final record = Record.fromSnapshot(data);

  return StreamBuilder<QuerySnapshot>(
    stream: Firestore.instance.collection('comanda').snapshots(),
    builder: (context, snapshot) {
      if (!snapshot.hasData) return LinearProgressIndicator();
      if (record.servida == false){
        deleteFirebase(context, record, "perRecollir");
        writeFirebase(context, record, "comandesAservir");
        return mostraComandes(context, record);
      } else if (record.recollida == false){
        deleteFirebase(context, record, "comandesAservir");
        writeFirebase(context, record, "perRecollir");
        return mostraComandes(context, record);
      } else {
        deleteFirebase(context, record, "perRecollir");
        return Container();
      }
    },
  );
}

void deleteFirebase(BuildContext context, Record record, String coleccion){
  Firestore.instance.collection(coleccion).document("0" + record.id.toString())
      .delete();
}

void writeFirebase(BuildContext context, Record record, String coleccion) {
  Firestore.instance.collection(coleccion).document("0" + record.id.toString())
      .setData({
    'id': record.id,
    'nom': record.nom,
    'cognoms': record.cognoms});
}

// Un pedido servido se pasa a estado servido
Widget cambiarEstatComanda(BuildContext context, Record record){
  Firestore.instance.collection("comanda").document("0" + record.id.toString())
      .updateData({
    'servida': record.servida = true,
  });
  return mostraComandes(context, record);
}
Widget mostraComandes(BuildContext context, Record record ){
  return   FlipCard(

      onFlip:(){
        // de momento ninguna condición
      },
      direction: FlipDirection.VERTICAL,
      front: impresioDades(context, record),
      back: alertDialog(context, record)

  );

}
Widget impresioDades(BuildContext context, Record record,  ) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 10.0),
    height: 200.0,
    child: Card(
      child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            linea( "id Comande: 0" +record.id.toString(), record.nom + "   " +
                record.cognoms),
            Divider(),
            linea("Data Comanda: " +
                record.nom, "Data Servei: " + record.nom+ "\n"),
            linea("Id producte: P1" , "Producte: " +
                record.nom+ "\n"),
            linea("Lloguer:  4 h." , "Localitat: " +
                record.cognoms)
          ]
      ),
    ),
  );
}

AlertDialog alertDialog(BuildContext context, Record record, ) {
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
          cambiarEstatComanda(context, record);
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
Widget linea( String text_1, String text_2){
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
        assert(map['recollida'] != null),
        assert(map['servida'] != null),
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