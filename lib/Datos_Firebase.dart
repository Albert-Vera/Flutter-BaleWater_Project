import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';




  int modificarDatos(){
    Firestore.instance.collection("castle").document("1").updateData({"enAlmacen" : FieldValue.increment(-1)});
    return 0;
  }


