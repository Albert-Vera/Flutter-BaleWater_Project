
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'GraphWidget.dart';

class Balance3 extends StatefulWidget {
  final List<DocumentSnapshot> documents;
   double total;
  final List<double> perDay;
 // final Map<String, double> categories;

  Balance3({Key key, this.documents})
      : total = documents.map((doc) => doc['importComanda'])
            .fold(0.0, (a, b) => a + b),
        perDay = List.generate(30, (int index) {
          return documents.where((doc) => doc['dia'] == (index + 1))
              .map((doc) => doc['importComanda'])
              .fold(0.0, (a, b) => a + b);
        }),
        super(key: key);

  @override
  _Balance3State createState() => _Balance3State();
}

class _Balance3State extends State<Balance3> {
  @override
  Widget build(BuildContext context) {
    return Expanded(

      child: Column(
        children: <Widget>[
          _expenses(),
          _graph(),
          Container(
            color: Colors.blueAccent.withOpacity(0.15),
            height: 24.0,
          ),


        _list(),
        ],
      ),
    );
  }

  Widget _expenses() {
    return Column(
      children: <Widget>[
        Text("€${widget.total.toStringAsFixed(2)}",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 25.0,
          ),
        ),
        Text("Total vendes",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16.0,
            color: Colors.blueGrey,
          ),
        ),
      ],
    );
  }

  Widget _graph() {
    return Container(
      height: 120.0,
      child: GraphWidget(
        data: widget.perDay,
      ),
    );
  }

  Widget _item( int id, String name, String productId, double value) {
    return ListTile(
      leading: Padding(
        padding: const EdgeInsets.only(top: 10.0),
        child: Text(id.toString(),
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 15.0
          ),),
      ),
      title: Text(name,
        style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 15.0
        ),
      ),
      subtitle: Text(productId,
        style: TextStyle(
          fontSize: 16.0,
          color: Colors.blueGrey,
        ),
      ),
      trailing: Container(
        decoration: BoxDecoration(
          color: Colors.blueAccent.withOpacity(0.2),
          borderRadius: BorderRadius.circular(5.0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text("€$value",
            style: TextStyle(
              color: Colors.blueAccent,
              fontWeight: FontWeight.w500,
              fontSize: 16.0,
            ),
          ),
        ),
      ),
    );
  }

  Widget _list() {
    return Expanded(
      child: ListView.separated(
        itemCount: widget.documents.length,
        itemBuilder: (BuildContext context, int index) {
          var id = widget.documents[index].data['id'];
          var producte = widget.documents[index].data['productNom'];
           String  proId = widget.documents[index].data['product_id'];
          double preu = (widget.documents[index].data['importComanda']).toDouble();
          return _item( id, producte, proId, preu);
        },
        separatorBuilder: (BuildContext context, int index) {
          return Container(
            color: Color(0xFFc5cdd9).withOpacity(1),
            height: 6.0,
          );
        },
      ),
    );
  }
  //Lee de Firebase disponible de producto en almacén
//  Widget stockProducte(BuildContext context, Record record) {
//    return StreamBuilder(
//        stream: Firestore.instance.collection("comanda").document(
//            record.product_id).snapshots(),
//        builder: (context, snapshot) {
//          if (!snapshot.hasData) return Text("Loading");
//          return Padding(
//            padding: const EdgeInsets.all(8.0),
//            child: Text("Disponibles en almacén: " + snapshot.data['enAlmacen'].toString()),
//          );
//        });
//  }
}