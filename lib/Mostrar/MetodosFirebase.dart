

import 'package:cloud_firestore/cloud_firestore.dart';

void deleteFirebase(DocumentSnapshot data, String coleccion){
  Firestore.instance.collection(coleccion).document("0" + data["id"])
    .delete();
}

void writeFirebase(DocumentSnapshot data, String coleccion) {
  Firestore.instance.collection(coleccion).document("0" + data["id"])
    .setData({
    'id': data["id"],
    'nom': data["nom"],
    'cognoms': data["cognoms"]});
}