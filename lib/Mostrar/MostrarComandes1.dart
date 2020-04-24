import 'package:Balewaterproject/BackGroundPantalla.dart';
import 'package:Balewaterproject/Experimento.dart';
import 'package:Balewaterproject/Menus/BannerBaleWater.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';

class MostrarComandes1 extends StatefulWidget{

  String coleccion;

  MostrarComandes1( {
    Key key,
  this.coleccion}): super(key: key);

  @override
  _MostrarComandes1State createState() => _MostrarComandes1State();
}

class _MostrarComandes1State extends State<MostrarComandes1> {
  QuerySnapshot querySnapshot;

  @override
  void initState() {
    super.initState();
    getComandesList().then((results) {
      setState(() {
        querySnapshot = results;
      });
    });
  }
  //get firestore instance
  getComandesList() async {
    return await Firestore.instance.collection(this.widget.coleccion).getDocuments();
  }
  @override
  Widget build(BuildContext context) {
    if (querySnapshot != null) {
    return Scaffold(
      body: BackGroundPantalla(
        child:  Column(
          children: <Widget>[
            //BannerBaleWater(),
             mostraComandes(context),
          ],
        ),
      ),
    );
    } else {
      return Center(
        child: CircularProgressIndicator(),
      );
    }
  }

  Widget mostraComandes(BuildContext context){
    return Expanded(child:
    ListView.builder(
        shrinkWrap: true,
        primary: false,
        itemCount: querySnapshot.documents.length,
        padding: EdgeInsets.all(12),
        itemBuilder: (context,i ) => FlipCard(
            onFlip:(){
              // de momento ninguna condición
            },
            direction: FlipDirection.VERTICAL,
            front: impresioDades(context,i),
            back: alertDialog(context)
        )
    ),
    );
  }
  Widget impresioDades(BuildContext context, int i  ) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10.0),
      height: 200.0,
      child: Card(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              linea( "id Comande: " +"${querySnapshot.documents[i].data['id']}", "Nom: " +
                  "${querySnapshot.documents[i].data['nom']}" + "   " +
                  "${querySnapshot.documents[i].data['cognoms']}"),
              Divider(),
              linea("Data Comanda: " + "${querySnapshot.documents[i].data['nom']}" ,
                  "Data Servei: " + "${querySnapshot.documents[i].data['nom']}" + "\n"),
              linea("Id producte: " + "${querySnapshot.documents[i].data['id']}" ,
                  "Producte: " + "${querySnapshot.documents[i].data['nom']}" + "\n"),
              linea("Lloguer:  4 h." , "Localitat: " + "${querySnapshot.documents[i].data['nom']}")
            ]
        ),
      ),
    );
  }
  AlertDialog alertDialog(BuildContext context ) {
    //GlobalKey<FlipCardState> thisCard = ;
    return AlertDialog(
      title: Text('El producte ha sigut servit ?'),
      content: SingleChildScrollView(
        child: ListBody(
          children: <Widget>[
            Text('El producte has donará per entregat.'),
          ],
        ),
      ),
      actions: <Widget>[
        FlatButton(
          child: Text('Ok.'),
          onPressed: () {
            //cambiarEstatComanda(context, record);
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