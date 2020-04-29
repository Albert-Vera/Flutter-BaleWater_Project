import 'dart:collection';

import 'package:flutter/cupertino.dart';

class Producto {
  var nombre;
  var stock;
}

class StockModel extends ChangeNotifier {
  final List<Producto> _productos = [];

  UnmodifiableListView<Producto> get productos => UnmodifiableListView(_productos);



}