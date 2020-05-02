import 'package:Balewaterproject/Menus/BannerBaleWater.dart';
import 'package:Balewaterproject/Mostrar/ComandesAServir.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../BackGroundPantalla.dart';
import '../util.dart';
import 'ComandesAServir.dart';

class DadesClient22 extends StatelessWidget {
  Record record22;
  DadesClient22({
    Key key,
    this.record22}): super(key: key);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BackGroundPantalla(
          child: Column(
            children: <Widget>[
              BannerBaleWater(texte: "Detall comanda",),
              Expanded(child:
              _mostrarDetall(context, record22)
              ),
            ],
          )
      ),
    );
  }

  Container _mostrarDetall(BuildContext context, Record record) {
    final screenSize = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.all(10.0),
      decoration: new BoxDecoration(boxShadow: [
        BoxShadow(
          color: Colors.blueAccent.withOpacity(0.2),
          blurRadius: 2.0,
        ),
      ],
          borderRadius: BorderRadius.circular(15.0)
      ),
      child: Card(
          child: Column(
            children: <Widget>[
              Container(
                width: screenSize.width,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      _lineaCard( "Id Comanda:" , record.id.toString() ),
                      _lineaCard( "Id Producte:" , record.product_id ),
                      _lineaCard("Nom producte: " , record.product_Nom ),
                      _lineaCard( "Nom client:" , record.nom + " " +record.cognoms),
                      _lineaCard( "Data comanda:" , record.dat_comanda ),
                      _lineaCard( "Data servei:" , record.dat_servei ),
                      _lineaCard( "Horas:" , record.horas.toString() ),
                      _lineaCard( "Servida:" , record.servida.toString() ),
                      _lineaCard( "Recollida:" , record.recollida.toString() ),
                      _stockProducte(context, record),
                      _boton(context, record),
                      //_botonVerClient(context)
                    ]
                ),
              ),
            ],
          )
      ),
    );
  }
  Widget _boton(BuildContext context, Record record){
    return Container(
       height: 40,
      child: RaisedButton(
        onPressed: () {
          pushPage(context, _alertDialog(context, record));
        },
        textColor: Colors.white,
        padding: const EdgeInsets.all(0.0),
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: <Color>[
                Color(0xFF0D47A1),
                Color(0xFF1976D2),
                Color(0xFF42A5F5),
              ],
            ),
          ),
          padding: const EdgeInsets.all(10.0),
          child: const Text(
              'SERVIDA',
              style: TextStyle(fontSize: 20)
          ),
        ),
      ),
    );
  }
  AlertDialog _alertDialog(BuildContext context, Record record) {
    print("Maravillososoooooooooooooooooooooooooooooooooo111");
    return  AlertDialog(
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
              modificarStockProducte(context, record);
              _cambiarEstatComanda(context, record);
              pushPage(context, ComandesAServir());
              // _buildBody(context);
              //thisCard.currentState.toggleCard();
            },
          ),
          FlatButton(
            child: Text('Cancel.'),
            onPressed: () {
              Navigator.of(context).pop();

            },
          ),
        ],

    );
  }
  Widget _lineaCard( String text_1, String text_2){
    // final screenSize = MediaQuery.of(context).size;
    return  Container(
      width: double.maxFinite,
      //color: Colors.tealAccent,
      child: Padding(
        padding: const EdgeInsets.all( 10.0),
        child: Row(

          children: <Widget>[
            Expanded(
              child: Text(text_1,
                  textAlign: TextAlign.start),
            ),
            Expanded(
              child: Text(text_2,
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                      fontSize: 14.0
                  ),
                  textAlign: TextAlign.end),
            )
          ],
        ),
      ),
    );
  }
  //Lee de Firebase disponible de producto en almacén
  Widget _stockProducte(BuildContext context, Record record) {
    return StreamBuilder(
        stream: Firestore.instance.collection("productes").document(
            record.product_id).snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return Text("Loading");
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text("Disponibles en almacén: " + snapshot.data['enAlmacen'].toString()),
          );
        });
  }
  void modificarStockProducte(BuildContext context, Record record) {
    Firestore.instance.collection("productes")
        .document(record.product_id)
        .updateData({"enAlmacen": FieldValue.increment(-1)});
  }
// Un pedido servido se pasa a estado servido
  void _cambiarEstatComanda(BuildContext context, Record record) {
    Firestore.instance.collection("comanda").document(
        "0" + record.id.toString())
        .updateData({
      'servida': record.servida = true,
    });
  }
}
