import 'package:Balewaterproject/Menus/BannerBaleWater.dart';
import 'package:Balewaterproject/Menus/MenuCompras.dart';
import 'package:Balewaterproject/util.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../BackGroundPantalla.dart';

class Vacia extends StatefulWidget {
  String productId;
  String nomProducte;
  int unitats;

  Vacia({ Key key,
    this.productId,
    this.nomProducte,
    this.unitats}):super (key: key);

  @override
  _VaciaState createState() => _VaciaState();
}

class _VaciaState extends State<Vacia> {

  @override
  void initState() {
    _writeComandaFirebase();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print( "unitats : ........................................................................" + widget.unitats.toString());
    return Scaffold(
      body: BackGroundPantalla(
          child: Column(
            children: <Widget>[
              BannerBaleWater(texte: "Comandes a servir",),
              Expanded(child: _buildBody(context),),
              _comandaEnviada(context),
            ],
          )
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance.collection("comandaProveidor").snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return LinearProgressIndicator();
        return _buildList(context, snapshot.data.documents );
      },
    );
  }

  Widget _buildList(BuildContext context, List<DocumentSnapshot> snapshot) {
    return
      ListView.builder(
        padding: const EdgeInsets.only(top: 30.0),
        itemCount: snapshot.length,
        itemBuilder: (context, index){
            return _buildListItem(context, snapshot[index]);
        }
      );
  }

  Widget _buildListItem(BuildContext context, DocumentSnapshot datos) {
    return Text(" bla bla bla");
  }

  void _writeComandaFirebase() async {

    print("PRODUCTID_________________________" + widget.productId);
    var idComanda = (await Firestore.instance.collection("comandaProveidor").getDocuments()).documents.length + 1;
    var preu = (await Firestore.instance.collection("productes").document(widget.productId).get()).data["precioCoste"];

    print("..............................................................................111.a.............  " + idComanda.toString());

    Firestore.instance.collection("comandaProveidor").document(idComanda.toString())
      .setData({
      'idComanda': idComanda,
      'nomProducte': widget.nomProducte,
      'idProducte': 's',
      'nomProveidor': 's',
      'idProveidor': 's',
      'dataComanda': 's',
      'dataEntrega': 's',
      'unitats': widget.unitats,
      'preuUnitat': preu,
      'preuTotal': (preu)*widget.unitats});
  }

  AlertDialog _comandaEnviada(BuildContext context) {
    return AlertDialog(
      title: Text('Comande enviada ' ),
      content: SingleChildScrollView(
        child:
        Text('Rebràs confirmació del proveidor ' ),
      ),
      actions: <Widget>[
        FlatButton(
          child: Text('Ok.'),
          onPressed: () {
            pushPage(context, MenuCompras());
          },
        ),
      ],
    );
  }
}

