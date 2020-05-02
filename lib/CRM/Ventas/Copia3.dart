
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'GraphWidget.dart';

class Copia3 extends StatefulWidget {
  final List<DocumentSnapshot> documents;
  final double total;
  final List<double> perDay;

  Copia3({Key key, this.documents})
      : total = documents.map((doc) => doc['importComanda'])
      .fold(0.0, (a, b) => a + b),
        perDay = List.generate(30, (int index) {
          return documents.where((doc) => doc['dia'] == (index + 1))
              .map((doc) => doc['importComanda'])
              .fold(0.0, (a, b) => a + b);
        }),
        super(key: key);

  @override
  _Copia3State createState() => _Copia3State();
}

class _Copia3State extends State<Copia3> {
  @override
  Widget build(BuildContext context) {
    return Expanded(

      child: Column(
        children: <Widget>[

          _cabecera(),
          _list(),
        ],
      ),
    );
  }
  Widget _cabecera(){
    return Container(
        color: Colors.blueAccent.withOpacity(0.15),
        height: 54.0,
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 15.0),
              child: Row(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(left: 20.0),
                    child: Text("id",
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                          fontSize: 14.0
                      ),),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 70.0),
                    child: Text("Nom client",
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                          fontSize: 14.0
                      ),),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 60.0),
                    child: Text("Data servei",
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                          fontSize: 14.0
                      ),),
                  ),
                ],
              ),
            ),
            Padding(padding: const EdgeInsets.only(right: 30.0),
              child: Text("Producte",
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w400,
                    fontSize: 12.0
                ),),
            )
          ],
        )

    );
  }
  Widget _item( int id, String name, String productId, String value) {
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
          child: Text("$value",
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
          String  client = widget.documents[index].data['nom'] + " " + widget.documents[index].data['cognoms'];
          String dataServei = (widget.documents[index].data['data_servei']);
          return _item( id, client, producte, dataServei);
        },
        separatorBuilder: (BuildContext context, int index) {
          return Container(
            color: Colors.blueAccent.withOpacity(0.2),
            height: 6.0,
          );
        },
      ),
    );
  }
}