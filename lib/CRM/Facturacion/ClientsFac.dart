import 'package:Balewaterproject/BackGroundPantalla.dart';
import 'package:Balewaterproject/CRM/Ventas/Balance.dart';
import 'package:Balewaterproject/Menus/BannerBaleWater.dart';
import 'package:Balewaterproject/model/Record.dart';
import 'package:Balewaterproject/util.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:toast/toast.dart';

import '../../Datos_Firebase.dart';
import 'MostrarFactura.dart';
String text_e;
class ClientsFac extends StatelessWidget{
  int id;
  String texte;
  ClientsFac({Key key, this.id, this.texte}): super (key: key);

  @override
  Widget build(BuildContext context) {
    text_e = texte;
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
      body: Container(
        child:  Column(
          children: <Widget>[


            Expanded(child: _buildBody(context, id)),
            //_mostrarFactura(),
          ],
        ),
      ),
    );
  }
}


Widget _buildBody(BuildContext context, int id ) {
  return StreamBuilder<QuerySnapshot>(
    stream: Firestore.instance
        .collection('comanda')
        .where("id", isEqualTo: id )
        .snapshots(),
    builder: (context, snapshot) {
      if (!snapshot.hasData) return LinearProgressIndicator();
      return _buildList(context, snapshot.data.documents );
    },
  );

}

Widget _buildList(BuildContext context, List<DocumentSnapshot> snapshot) {
  return
    ListView(
      padding: const EdgeInsets.only(top: 30.0),
      children: snapshot.map((data) =>
          _buildListItem(context, data)).toList(),
    );
}

Widget _buildListItem(BuildContext context, DocumentSnapshot datos) {
  final record = Record.fromSnapshot(datos);
  return StreamBuilder<QuerySnapshot>(
    stream: Firestore.instance.collection("comanda").snapshots(),
    builder: (context, snapshot) {
      if (!snapshot.hasData) return LinearProgressIndicator();


      return  mostrarFactura(context, record);
    },
  );
}

Widget mostrarFactura(BuildContext context, Record record){
  final screenSize = MediaQuery.of(context).size;
  double iva = record.importComanda * 21/100;
  double totalFact = record.importComanda + iva;

  return Container(
    margin: EdgeInsets.all(10.0),
    height: screenSize.height - 100,
    child: Card(
      child: Column(
          children: <Widget>[

            Padding(
              padding: const EdgeInsets.all(18.0),
              child: Container(
                  width: screenSize.width,
                  child: Column(
                      children: <Widget>[
                        Text( text_e,   style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                            fontSize: 18.0
                        ),),
                        Divider(),
                        _dades_Empresa(),
                        _dades_Client(record),
                        _cabecera(),
                        dades_Venda(record),
                        SizedBox(
                          height: 120.0,
                        ),
                        Divider(
                          color: Colors.black,
                          height: 16,
                        ),
                        Row(
                          children: <Widget>[
                            _icone_Print(context),
                            total_Factura(record, iva, totalFact),
                          ],
                        ),
                      ]
                  )
              ),
            )
          ]
      ),
    ),
  );
}

Container total_Factura(Record record, double iva, double totalFact) {
  return Container(
    margin: EdgeInsets.only(
        top: 0.0,
        left: 80.0),
    child: Column(
      children: <Widget>[
        _lineaCard( "Total ..." , record.importComanda.toString()),
        _lineaCard( "iva 21% ..." , iva.toString()),
        _lineaCard( "Total factura ..." , totalFact.toString()),
      ],
    ),
  );
}

Container _icone_Print(BuildContext context) {
  return Container(
    margin: EdgeInsets.only(
        top: 30.0,
        left: 10.0),
    width: 50.0,
    height: 50.0,
    child:
    FloatingActionButton(
      onPressed: () {
        Toast.show("Imprimint factura", context, duration: Toast.LENGTH_LONG, gravity:  Toast.BOTTOM);
      },
      child: Icon(Icons.print),
      mini: true,
    ),
  );
}

Container dades_Venda(Record record) {
  return Container(
      margin: EdgeInsets.only(
          top: 10.0,
          left: 20.0),
      width: double.maxFinite,
      decoration: new BoxDecoration(boxShadow: [
        BoxShadow(
          color: Colors.blueAccent.withOpacity(0.1),
          blurRadius: 2.0,
        ),
      ],
          borderRadius: BorderRadius.circular(5.0)
      ),
      child:  Row(
          children: <Widget>[
            Container(
                margin: EdgeInsets.only(left: 0.0),
                child:
                Text(record.id.toString()+ "    ")
            ),
            Container(
                margin: EdgeInsets.only(left: 10),
                child: Text(record.product_Nom)),
            Container(
                margin: EdgeInsets.only(left: 25),
                child: Text(record.importComanda.toString())),
            Container(
                margin: EdgeInsets.only(left: 35),
                child: Text(record.horas.toString())),
            Container(
                margin: EdgeInsets.only(left: 60),
                child: Text(record.importComanda.toString())),
          ]
      )
  );
}

Container _dades_Client(Record record) {
  return Container(
      margin: EdgeInsets.only(
          top: 20.0,
          left: 120.0),
      width: 120.0,
      decoration: new BoxDecoration(boxShadow: [
        BoxShadow(
          color: Colors.tealAccent.withOpacity(0.1),
          blurRadius: 2.0,
        ),
      ],
          borderRadius: BorderRadius.circular(5.0)
      ),
      child:  Column(
          children: <Widget>[
            Text(record.nom + " " + record.cognoms),
            Text(record.adreca),
            Text(record.cp.toString() + " " + record.localitat),
          ]
      )
  );
}

Container _dades_Empresa() {
  return Container(
    margin: EdgeInsets.only(
        top: 5.0,
        right: 172.0),
    width: double.maxFinite,
    decoration: new BoxDecoration(boxShadow: [
      BoxShadow(
        color: Colors.tealAccent.withOpacity(0.1),
        blurRadius: 2.0,
      ),
    ],
        borderRadius: BorderRadius.circular(5.0)
    ),
    child:  Column(
      children: <Widget>[
        Text( "Bale Water, S.L.", textAlign: TextAlign.start,),
        Text( "C/ Balmes, 45 ", textAlign: TextAlign.start  ),
        Text( "08032 - Barcelona", textAlign: TextAlign.start ),
      ],
    ),

  );
}

Widget _lineaCard( String text_1, String text_2){
  // final screenSize = MediaQuery.of(context).size;
  return  Container(
    width: 150,
    //color: Colors.tealAccent,
    child: Padding(
      padding: const EdgeInsets.only(top: 10.0),
      child: Row(

        children: <Widget>[
          Expanded(
            child: Text(text_1,
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                    fontSize: 11.0
                ),
                textAlign: TextAlign.start),
          ),
          Expanded(
            child: Text(text_2,
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                    fontSize: 10.0
                ),
                textAlign: TextAlign.end),
          )
        ],
      ),
    ),
  );
}
Widget _cabecera(){
  return Container(
      margin: EdgeInsets.only(top: 40.0),
      // color: Colors.blueAccent.withOpacity(0.15),
      height: 54.0,
      width: double.maxFinite,
      child: Column(
        children: <Widget>[
//          SizedBox(
//            height: 60.0,
//            width: 50.0,
//          ),
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
                  padding: const EdgeInsets.only(left: 20.0),
                  child: Text("Producte",
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                        fontSize: 14.0
                    ),),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20.0),
                  child: Text("Preu",
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                        fontSize: 14.0
                    ),),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20.0),
                  child: Text("Hores",
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                        fontSize: 14.0
                    ),),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 40.0),
                  child: Text("Total",
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                        fontSize: 14.0
                    ),),
                ),
              ],
            ),
          ),
          Expanded(child: Divider(
            color: Colors.black,
            height: 36,
          ))
        ],
      )

  );
}