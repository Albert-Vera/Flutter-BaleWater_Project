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

      if ( record.servida == true) int stock = 1;
      return _impresioDades(context, record);
    },
  );
}
Widget _impresioDades(BuildContext context, Record record ) {

  return Container(

    margin: EdgeInsets.symmetric(vertical: 10.0),
    height: 200.0,
    child: Card(
      child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            _lineaCard( "id Comande: 0" + record.id.toString(), record.nom + "   " +
                record.cognoms),
            Divider(),
            _lineaCard("Data Comanda: " +
                record.nom, "Data Servei: " + record.data_servei+ "\n"),
            _lineaCard("Id producte: " + record.product_id, "Producte: " +
                record.nom+ "\n"),
            _lineaCard("Lloguer: " + record.horas.toString() + " h.", "Localitat: " +
                record.cognoms)
          ]
      ),
    ),
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
  final String nom, cognoms, data_servei, product_id;
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
        assert(map['product_id'] != null),
        assert(map['horas'] != null),
        id = map['id'],
        nom = map['nom'],
        cognoms = map['cognoms'],
        recollida = map['recollida'],
        horas = map['horas'],
        product_id = map['product_id'],
        data_servei = map['data_servei'],
        servida = map['servida'];

  Record.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data, reference: snapshot.reference);

  @override
  String toString() => "Record<$nom:$cognoms>";
}
