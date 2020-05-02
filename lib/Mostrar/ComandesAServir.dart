import 'package:Balewaterproject/BackGroundPantalla.dart';
import 'package:Balewaterproject/Datos_Firebase.dart';
import 'package:Balewaterproject/Menus/BannerBaleWater.dart';
import 'package:Balewaterproject/medio_basura/ExpansionTileSample.dart';
import 'package:Balewaterproject/medio_basura/MostrarComandes1.dart';
import 'package:Balewaterproject/medio_basura/ReEscriureFire.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';

import '../util.dart';
import 'DadesClient.dart';

class ComandesAServir extends StatefulWidget{
  String coleccion;

  ComandesAServir( {
    Key key,
    this.coleccion}): super(key: key);
  @override
  _ComandesAServirState createState() => _ComandesAServirState();
}
class _ComandesAServirState extends State<ComandesAServir> {
  @override
  Widget build(BuildContext context) {

    //ReEscriureFire().escriure();

    return Scaffold(
      body: BackGroundPantalla(
          child: Column(
            children: <Widget>[
              BannerBaleWater(texte: "Comandes a servir",),
              Expanded(child:
              _buildBody(context, this.widget.coleccion)
              ),
            ],
          )
      ),
    );
  }

  Widget _buildBody(BuildContext context, String coleccio) {
    return StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance.collection("comandesAservir").snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return LinearProgressIndicator();
        if (snapshot.data.documents.isEmpty)  return _comanServidasVacio(context);
        else return _buildList(context, snapshot.data.documents );
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
        if (record.servida == false) {
          _deleteFirebase(context, record, "perRecollir");
          _writeFirebase(context, record, "comanda");
          _writeFirebase(context, record, "comandesAservir");
          return _impresioDades(context, record);
        } else if (record.recollida == false) {
          _deleteFirebase(context, record, "comandesAservir");
          _writeFirebase(context, record, "comanda");
          _writeFirebase(context, record, "perRecollir");
          return _impresioDades(context, record);
        } else {
          _deleteFirebase(context, record, "perRecollir");
          return _impresioDades(context, record);
        }
      },
    );
  }

  void _deleteFirebase(BuildContext context, Record record, String coleccion) {
    Firestore.instance.collection(coleccion).document(
        "0" + record.id.toString())
        .delete();
  }

  void _writeFirebase(BuildContext context, Record record, String coleccion) {
    String a = record.dat_servei.substring(3,5);
    String b = record.dat_servei.substring(0,2);
    Firestore.instance.collection(coleccion).document("0" + record.id.toString())
        .setData({
      'id': record.id,
      'nom': record.nom,
      'cognoms': record.cognoms,
      'data_servei': record.dat_servei,
      'data_comanda': record.dat_comanda,
      'horas': record.horas,
      'product_id': record.product_id,
      'recollida': record.recollida,
      'servida': record.servida,
      'importComanda': record.importComanda,
      'productNom': record.product_Nom,
      'mes' : int.parse(a),
      'dia' : int.parse(b)});
  }

//Lee de Firebase disponible de producto en almacén
  Widget stockProducte(BuildContext context, Record record) {
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

  Widget _mostraComandes(BuildContext context, Record record) {
    return FlipCard(
        onFlip: () {
          // de momento ninguna condición
        },
        direction: FlipDirection.VERTICAL,
        front: _impresioDades(context, record),
        back: _alertDialog(context, record)
    );
  }

  Widget _impresioDades(BuildContext context, Record record) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 6.0),
      height: 120.0,
      child: Container(
        decoration: new BoxDecoration(boxShadow: [
          new BoxShadow(
            color: Colors.blueAccent.withOpacity(0.2),
            blurRadius: 2.0,
          ),
        ]),
        child: Card(
            child: Row(
              children: <Widget>[
                Container(
                  width: 155.0,
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        _lineaCard( "Comanda:" , "0" + record.id.toString()),
                        _lineaCard("Id producte: " , record.product_id ),
                        _botonVerClient(context)
                      ]
                  ),
                ),
                VerticalDivider(
                  width: 5.0,
                ),
                Container(
                  width: 160.0,
                  child: Column(

                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        _lineaCard( "Servei:" , record.dat_servei),
                        _lineaCard("Lloguer: " , record.horas.toString() + " h."),
                      ]
                  ),
                )
              ],
            )
        ),
      ),
    );
  }
  Widget _lineaCard( String text_1, String text_2){
    // final screenSize = MediaQuery.of(context).size;
    return  Container(
      width: double.maxFinite,
      //color: Colors.tealAccent,
      child: Padding(
        padding: const EdgeInsets.only(top: 15.0),
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
  Widget _botonVerClient(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 14.0),
      child: Container(
        decoration: new BoxDecoration(boxShadow: [
          new BoxShadow(
            color: Colors.blueAccent.withOpacity(0.2),
            blurRadius: 5.0,
          ),
        ]),
        width: 120.0,
        // color: Colors.tealAccent,
        child: GestureDetector(
          onTap: ()=> pushPage(context, DadesClient()),
          child: Text("Més dades",
            style: TextStyle(
                color: Colors.blueAccent,
                fontWeight: FontWeight.w400,
                fontSize: 20.0
            ),
          ),
        ),
      ),
    );
  }
  Widget _alertDialog(BuildContext context, Record record) {
    return Container(
      height: 200.0,
      child: AlertDialog(
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
      ),
    );
  }

  AlertDialog _comanServidasVacio(BuildContext context) {
    return AlertDialog(
      title: Text('Comandes Servidas'),
      content: SingleChildScrollView(
        child:
        Text('No hi ha comandes per servir'),
        // Text('You\’re like me. I’m never satisfied.'),

      ),
      actions: <Widget>[
        FlatButton(
          child: Text('Ok.'),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ],
    );
  }
}
class Record {
  final String nom, cognoms, product_id, product_Nom;
  final String dat_servei, dat_comanda ;
  final int id, horas, dia, mes, importComanda;
  bool recollida, servida;
  final DocumentReference reference;

  Record.fromMap(Map<String, dynamic> map, {this.reference})
      : assert(map['id'] != null),
        assert(map['nom'] != null),
        assert(map['cognoms'] != null),
        assert(map['recollida'] != null),
        assert(map['servida'] != null),
        assert(map['data_servei'] != null),
        assert(map['data_comanda'] != null),
        assert(map['product_id'] != null),
        assert(map['horas'] != null),
        assert(map['mes'] != null),
        assert(map['dia'] != null),
        assert(map['importComanda'] != null),
        assert(map['productNom'] != null),
        id = map['id'],
        nom = map['nom'],
        cognoms = map['cognoms'],
        recollida = map['recollida'],
        horas = map['horas'],
        product_id = map['product_id'],
        dat_servei = map['data_servei'],
        dat_comanda= map['data_comanda'],
        servida = map['servida'],
        product_Nom = map['productNom'],
        importComanda = map['importComanda'],
        mes = map['mes'],
        dia = map['dia'];

  Record.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data, reference: snapshot.reference);

  @override
  String toString() => "Record<$nom:$cognoms>";
}
