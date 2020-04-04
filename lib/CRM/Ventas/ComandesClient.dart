import 'package:Balewaterproject/BackGroundPantalla.dart';
import 'package:Balewaterproject/Menus/BannerBaleWater.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ComandesClient extends StatefulWidget{
  @override
  _ComandesClientState createState() => _ComandesClientState();
}

class _ComandesClientState extends State<ComandesClient> {

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
    return await Firestore.instance.collection('comanda').getDocuments();
  }

  QuerySnapshot querySnapshot;
  @override
  Widget build(BuildContext context) {



    if (querySnapshot != null) {
      return Scaffold(
        body: BackGroundPantalla(
          child:  Column(
            children: <Widget>[
              BannerBaleWater(),
              mostraComandes()
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

  Widget mostraComandes(){
    var flip = false;

    return SingleChildScrollView(
      child: ListView.builder(
          shrinkWrap: true,
          primary: false,
          itemCount: querySnapshot.documents.length,
          padding: EdgeInsets.all(12),

        itemBuilder: (context, i) => FlipCard(
            onFlip:(){
             // de momento ninguna condición
            },
            direction: FlipDirection.VERTICAL,
            front: Container(
              margin: EdgeInsets.symmetric(vertical: 10.0),
              height: 200.0,
              child: Card(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                     linea( "id Comande: 023   ", "${querySnapshot.documents[i].data['nom']}" + "   " +
                         "${querySnapshot.documents[i]
                             .data['cognoms']}"),
                      Divider(),
                      linea("Data Comanda: " +
                          "${querySnapshot.documents[i]
                              .data['dataComanda']}", "Data Servei: " +
                          "${querySnapshot.documents[i]
                              .data['dataServei']}\n"),
                      linea("Id producte: P1" , "Producte: " +
                          "${querySnapshot.documents[i]
                              .data['nomCastle']}\n"),
                      linea("Lloguer:  4 h." , "Localitat: " +
                          "${querySnapshot.documents[i]
                              .data['localitat']}")
                    ]
                ),
              ),
            ),
            back: AlertDialog(
              title: Text('El producte ha sigut servit'),
              content: SingleChildScrollView(
                child: ListBody(
                  children: <Widget>[
                    Text('El producte has donará per entregat.'),
                   // Text('You\’re like me. I’m never satisfied.'),
                  ],
                ),
              ),
              actions: <Widget>[
                FlatButton(
                  child: Text('Ok.'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                FlatButton(
                  child: Text('Cancel.'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            )
        ),
      ),
    );
  }
  Widget linea( String text_1, String text_2){
    final screenSize = MediaQuery.of(context).size;
    return  Container(
      width: screenSize.width,
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