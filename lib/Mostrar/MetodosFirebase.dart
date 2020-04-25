

import 'package:cloud_firestore/cloud_firestore.dart';

void deleteFirebase(Map record, String coleccion){
  Firestore.instance.collection(coleccion).document("0" + record["id"])
    .delete();
}

void writeFirebase(Map record, String coleccion) {
  Firestore.instance.collection(coleccion).document("0" + record["id"])
    .setData({
    'id': record["id"],
    'nom': record["nom"],
    'cognoms': record["cognoms"]);
}