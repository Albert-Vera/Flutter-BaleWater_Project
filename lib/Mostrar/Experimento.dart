import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'MetodosFirebase.dart';

class Experimento extends StatelessWidget{


  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance.collection("Comanda").snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return LinearProgressIndicator();
        return _buildList(context, snapshot.data.documents);
      },
    );
  }

  Widget _buildList(BuildContext context, List<DocumentSnapshot> snapshot) {
    return ListView.builder(
      padding: const EdgeInsets.only(top: 30.0),
      itemCount: snapshot.length,
      itemBuilder: (context, index){
        return _buildListItem(context, snapshot.elementAt(index));
      },
//      children: snapshot.map((data) => _buildListItem(context, data)).toList(),
    );
  }
   _buildListItem(BuildContext context, DocumentSnapshot data) {
    final record = Record.fromSnapshot(data);

    return StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance.collection("Comanda").snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return LinearProgressIndicator();
        if ( record.servida == false ){
          deleteFirebase(record, "perRecollir");
          writeFirebase(record, "comandesAservir");
          return Text("cosas");
        }else
        if ( record.recollida == false ){
          deleteFirebase(record, "comandesAservir");
          writeFirebase(record, "perRecollir");
          return Text("cosas");
        }else {
          deleteFirebase(record, "perRecollir");
          return Text("cosas");
        }
      },
    );
  }
//  void _deleteFirebase(BuildContext context, Record record, String coleccion){
//    Firestore.instance.collection(coleccion).document("0" + record.id.toString())
//        .delete();
//  }
//  void _writeFirebase(BuildContext context, Record record, String coleccion) {
//
//    Firestore.instance.collection(coleccion).document("0" + record.id.toString())
//        .setData({
//      'id': record.id,
//      'nom': record.nom,
//      'cognoms': record.cognoms});
//  }
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