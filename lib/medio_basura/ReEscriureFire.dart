import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';


class ReEscriureFire{

  void escriure() {
    Firestore.instance.collection("productes").document("FB-055")
        .setData(
        {
          'averiados': 0,
          'enAlmacen': 5,
          'id': "FB-055",
          'imageCastle': "https://firebasestorage.googleapis.com/v0/b/balewaterproject-580af.appspot.com/o/happyCastle.jpeg?alt=media&token=0b006b62-2966-4464-8d73-8d23fc2d0240",
          'nomCastle': "Tobogán",
          'precioCoste': 3500,
          'precioAlquiler': 350,
          'proveedor': "JB-Hinchables",
          'servidas': 0,
          'stock': 5

        }

    );
  }
}
